import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/enums.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../personalization/controllers/settings_controller.dart';
import '../../models/payment_method_model.dart';
import '../../screens/checkout/widgets/payment_tile.dart';

class CheckoutController extends GetxController {
  static CheckoutController get instance => Get.find();

  final settingsController = Get.put(SettingsController());
  final Rx<PaymentMethodModel> selectedPaymentMethod =
      PaymentMethodModel.empty().obs;

  @override
  void onInit() {
    selectedPaymentMethod.value = PaymentMethodModel(
        name: PaymentMethods.cash.name, image: MyImages.cash);
    super.onInit();
  }

  Future<dynamic> selectPaymentMethod(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (_) => SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(MySizes.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const MySectionHeading(
                  title: 'Méthode de paiement', showActionButton: false),
              const SizedBox(height: MySizes.spaceBtwSections),
              MyPaymentTile(
                paymentMethod: PaymentMethodModel(
                  name: PaymentMethods.wave.name,
                  image: MyImages.wave,
                ),
              ),
              const SizedBox(height: MySizes.spaceBtwItems / 2),
              MyPaymentTile(
                paymentMethod: PaymentMethodModel(
                  name: PaymentMethods.OM.name,
                  image: MyImages.orangeMoney,
                ),
              ),
              const SizedBox(height: MySizes.spaceBtwItems / 2),
              MyPaymentTile(
                paymentMethod: PaymentMethodModel(
                  name: PaymentMethods.paypal.name,
                  image: MyImages.paypal,
                ),
              ),
              const SizedBox(height: MySizes.spaceBtwItems / 2),
              MyPaymentTile(
                paymentMethod: PaymentMethodModel(
                  name: PaymentMethods.cash.name,
                  image: MyImages.cash,
                ),
              ),
              const SizedBox(height: MySizes.spaceBtwItems / 2),
              MyPaymentTile(
                paymentMethod: PaymentMethodModel(
                  name: PaymentMethods.visa.name,
                  image: MyImages.visa,
                ),
              ),
              const SizedBox(height: MySizes.spaceBtwItems / 2),
              MyPaymentTile(
                paymentMethod: PaymentMethodModel(
                  name: PaymentMethods.masterCard.name,
                  image: MyImages.masterCard,
                ),
              ),
              const SizedBox(height: MySizes.spaceBtwItems / 2),
              const SizedBox(height: MySizes.spaceBtwSections),
            ],
          ),
        ),
      ),
    );
  }

  bool isShippingFree(double subTotal) {
    if (settingsController.settings.value.freeShippingThreshold != null &&
        settingsController.settings.value.freeShippingThreshold! > 0.0) {
      if (subTotal > settingsController.settings.value.freeShippingThreshold!) {
        return true;
      }
    }
    return false;
  }

  double getShippingCost(double subTotal) {
    return isShippingFree(subTotal)
        ? 0
        : settingsController.settings.value.shippingCost;
  }

  double getTaxAmount(double subTotal) {
    return settingsController.settings.value.taxRate * subTotal;
  }

  double getTotal(double subTotal) {
    double taxAmount = subTotal * settingsController.settings.value.taxRate;
    double totalPrice = subTotal +
        taxAmount +
        (isShippingFree(subTotal)
            ? 0
            : settingsController.settings.value.shippingCost);
    return double.tryParse(totalPrice.toStringAsFixed(0)) ?? 0;
  }
}
