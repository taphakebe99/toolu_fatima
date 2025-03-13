import 'dart:io';

import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:toolu_fatima/data/pdf/pdf_api.dart';

import '../../features/personalization/controllers/user_controller.dart';
import '../../features/personalization/models/user_model.dart';
import '../../features/shop/models/order_model.dart';

class PdfInvoiceApi {
  static Future<File> generate(OrderModel order) async {
    final pdf = Document();

    // Attendre la récupération de l'utilisateur avant de générer le PDF
    final user = await UserController.instance.getUserById(order.userId);

    pdf.addPage(MultiPage(
      build: (context) => [
        buildHeader(order, user),
        SizedBox(height: 3 * PdfPageFormat.cm),
        buildTitle(),
        buildInvoice(order),
        Divider(),
        buildTotal(order),
      ],
      footer: (context) => buildFooter(),
    ));

    return PdfApi.saveDocument(name: 'ticket-de-caisse.pdf', pdf: pdf);
  }

  static Widget buildHeader(OrderModel order, UserModel? user) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 1 * PdfPageFormat.cm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildSupplierInfo(),
              Container(
                height: 50,
                width: 50,
                child: BarcodeWidget(
                  barcode: Barcode.qrCode(),
                  data: order.id,
                ),
              ),
            ],
          ),
          SizedBox(height: 1 * PdfPageFormat.cm),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildCustomerInfo(order, user),
              buildInvoiceInfo(order),
            ],
          ),
        ],
      );

  static Widget buildCustomerInfo(OrderModel order, UserModel? user) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          user != null ? user.fullName : "Utilisateur inconnu",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        if (order.shippingAddress != null) Text(order.shippingAddress!.name),
      ],
    );
  }

  static Widget buildInvoiceInfo(OrderModel order) {
    final titles = ['Numéro de facture:', 'Date commande :'];
    final data = [
      order.id,
      DateFormat("dd/MM/yy · HH:mm").format(order.orderDate)
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(titles.length, (index) {
        return buildText(title: titles[index], value: data[index], width: 200);
      }),
    );
  }

  static Widget buildSupplierInfo() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('TOOLU FATIMA', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 1 * PdfPageFormat.mm),
          Text('Téléphone : 77 134 56 78'),
        ],
      );

  static Widget buildTitle() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'FACTURE',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 1 * PdfPageFormat.cm),
        ],
      );

  static Widget buildInvoice(OrderModel order) {
    final headers = [
      'Description',
      'Date',
      'Quantité',
      'Prix unitaire',
      'Total'
    ];
    final data = order.items.map((item) {
      final total = (item.quantity * item.price).toStringAsFixed(0);
      return [
        item.title,
        DateFormat("dd/MM/yy").format(order.orderDate),
        '${item.quantity}${item.selectedVariation != null ? " (${item.selectedVariation!.entries.map((e) => "${e.key}: ${e.value}").join(", ")})" : ""}',

        //'${item.quantity} ${item.unit}',
        '${item.price.toStringAsFixed(0)} FCFA',
        '$total FCFA',
      ];
    }).toList();

    return TableHelper.fromTextArray(
      headers: headers,
      data: data,
      border: null,
      headerStyle: TextStyle(fontWeight: FontWeight.bold),
      headerDecoration: BoxDecoration(color: PdfColors.grey300),
      cellHeight: 30,
      cellAlignments: {
        0: Alignment.centerLeft,
        1: Alignment.centerRight,
        2: Alignment.centerRight,
        3: Alignment.centerRight,
        4: Alignment.centerRight,
      },
    );
  }

  static Widget buildTotal(OrderModel order) {
    return Container(
      alignment: Alignment.centerRight,
      child: Row(
        children: [
          Spacer(flex: 6),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildText(
                    title: 'Sous-total',
                    value: order.totalAmount.toStringAsFixed(0),
                    unite: true),
                buildText(
                    title: 'Frais de livraison',
                    value: order.shippingCost.toStringAsFixed(0),
                    unite: true),
                buildText(
                    title: 'Tax (${(order.taxCost * 100).toStringAsFixed(0)}%)',
                    value: order.taxCost.toStringAsFixed(0),
                    unite: true),
                Divider(),
                buildText(
                  title: 'Total',
                  titleStyle:
                      TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  value: '${order.totalAmount.toStringAsFixed(0)} FCFA',
                  unite: true,
                ),
                SizedBox(height: 2 * PdfPageFormat.mm),
                Container(height: 1, color: PdfColors.grey400),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget buildFooter() => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Divider(),
          SizedBox(height: 2 * PdfPageFormat.mm),
          Text('Merci pour votre confiance !',
              style: TextStyle(fontStyle: FontStyle.italic)),
        ],
      );

  static Widget buildText({
    required String title,
    required String value,
    double width = double.infinity,
    TextStyle? titleStyle,
    bool unite = false,
  }) {
    final style = titleStyle ?? TextStyle(fontWeight: FontWeight.bold);

    return Container(
      width: width,
      child: Row(
        children: [
          Expanded(child: Text(title, style: style)),
          Text(value, style: unite ? style : null),
        ],
      ),
    );
  }
}
