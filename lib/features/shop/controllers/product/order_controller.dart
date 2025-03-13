/*import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/succes_screen/success_screen.dart';
import '../../../../data/repositories/authentication/authentication_repository.dart';
import '../../../../data/repositories/order/order_repository.dart';
import '../../../../home_menu.dart';
import '../../../../utils/constants/enums.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../../utils/popups/loaders.dart';
import '../../../personalization/controllers/address_controller.dart';
import '../../models/order_model.dart';
import 'cart_controller.dart';
import 'checkout_controller.dart';

class OrderController extends GetxController {
  static OrderController get instance => Get.find();

  /// Variables
  RxBool isLoading = true.obs;
  RxList<OrderModel> allOrders = <OrderModel>[].obs;

  final cartController = CartController.instance;
  final addressController = AddressController.instance;
  final checkoutController = CheckoutController.instance;
  final orderRepository = Get.put(OrderRepository());

  //final invoiceController = Get.put(InvoiceController());

  /// Fetch user's order history
  Future<List<OrderModel>> fetchUserOrders() async {
    try {
      final userOrders = await orderRepository.fetchUserOrders();
      return userOrders;
    } catch (e) {
      MyLoaders.warningSnackBar(title: 'Oups!', message: e.toString());
      return [];
    }
  }

  /// -- Load category data
  Future<void> fetchOrders() async {
    try {
      // Show loader while loading categories
      isLoading.value = true;

      // Fetch categories from data source (Firestore, API, etc.)
      final fetchedOrders = await orderRepository.fetchUserOrders();

      // Update the categories list
      allOrders.assignAll(fetchedOrders);
    } catch (e) {
      MyLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  /// Add methods for order processing
  void processOrder(double subTotal) async {
    try {
      // Start Loader
      MyFullScreenLoader.openLoadingDialog(
          'Votre commande est en cours de traitement.',
          MyImages.pencilAnimation);

      // Get user authentication Id
      final userId = AuthenticationRepository.instance.getUserID;
      if (userId.isEmpty) return;

      if (addressController.selectedAddress.value.id.isEmpty) {
        MyLoaders.warningSnackBar(
          title: 'Adresse de livraison requise',
          message: 'Veuillez ajouter une adresse pour continuer.',
        );
        MyFullScreenLoader.stopLoading();

        return;
      }

      // Add Details
      final order = OrderModel(
        // Generate a unique ID for the order
        id: UniqueKey().toString(),
        userId: userId,
        status: OrderStatus.pending,
        totalAmount: checkoutController.getTotal(subTotal),
        orderDate: DateTime.now(),
        shippingAddress: addressController.selectedAddress.value,
        paymentMethod: checkoutController.selectedPaymentMethod.value.name,

        items: cartController.cartItems.toList(),
        shippingCost: checkoutController.getShippingCost(subTotal),
        taxCost: checkoutController.getTaxAmount(subTotal),
      );

      // Trigger payment gateway
      // if(checkoutController.selectedPaymentMethod.value.name == PaymentMethods.paypal.name) {
      //   final response = await MyPaypalService.getPayment();
      //   print('Paypal Payment is ${response ? 'Successful' : 'Failed'}');
      //   if(response) MyLoaders.successSnackBar(title: 'Congratulations', message: 'Paypal Payment Paid');
      //   if(!response) MyLoaders.warningSnackBar(title: 'Failed', message: 'Paypal Payment Failed');
      // }

      // Save the order and order to Firestore
      await orderRepository.saveOrder(order, userId);

      // Update the cart status
      cartController.clearCart();

      // Show Success screen
      Get.off(() => SuccessScreen(
            image: MyImages.orderCompleted,
            title: 'Paiement réussi!',
            subTitle: 'Votre article sera expédié bientôt!',
            onPressed: () => Get.offAll(() => const HomeMenu()),
          ));
    } catch (e) {
      MyLoaders.errorSnackBar(title: 'Oops!', message: e.toString());
    }
  }
}
*/

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/succes_screen/success_screen.dart';
import '../../../../data/repositories/authentication/authentication_repository.dart';
import '../../../../data/repositories/order/order_repository.dart';
import '../../../../home_menu.dart';
import '../../../../utils/constants/enums.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../../utils/popups/loaders.dart';
import '../../../personalization/controllers/address_controller.dart';
import '../../models/order_model.dart';
import 'cart_controller.dart';
import 'checkout_controller.dart';
import 'product_controller.dart';

class OrderController extends GetxController {
  static OrderController get instance => Get.find();

  /// Variables
  final cartController = CartController.instance;
  final addressController = AddressController.instance;
  final checkoutController = CheckoutController.instance;
  final orderRepository = Get.put(OrderRepository());

  /// Fetch user's order history
  Future<List<OrderModel>> fetchUserOrders() async {
    try {
      final userOrders = await orderRepository.fetchUserOrders();
      return userOrders;
    } catch (e) {
      MyLoaders.warningSnackBar(title: 'Oups!', message: e.toString());
      return [];
    }
  }

  /// Add methods for order processing
  void processOrder(double subTotal) async {
    try {
      // Start Loader
      MyFullScreenLoader.openLoadingDialog(
          'Traitement de votre commande...', MyImages.pencilAnimation);

      // Get user authentication Id
      final userId = AuthenticationRepository.instance.getUserID;
      if (userId.isEmpty) return;



      // Add Details
      final order = OrderModel(
        // Generate a unique ID for the order
        id: UniqueKey().toString(),
        userId: userId,
        status: OrderStatus.pending,
        totalAmount: checkoutController.getTotal(subTotal),
        orderDate: DateTime.now(),
        shippingAddress: addressController.selectedAddress.value,
        paymentMethod: checkoutController.selectedPaymentMethod.value.name,
        items: cartController.cartItems.toList(),
        shippingCost: checkoutController.getShippingCost(subTotal),
        taxCost: checkoutController.getTaxAmount(subTotal),
      );

      // Trigger payment gateway
      // if(checkoutController.selectedPaymentMethod.value.name == PaymentMethods.paypal.name) {
      //   final response = await TPaypalService.getPayment();
      //   print('Paypal Payment is ${response ? 'Successful' : 'Failed'}');
      //   if(response) MyLoaders.successSnackBar(title: 'Congratulations', message: 'Paypal Payment Paid');
      //   if(!response) MyLoaders.warningSnackBar(title: 'Failed', message: 'Paypal Payment Failed');
      // }

      // Save the order to Firestore
      await orderRepository.saveOrder(order, userId);

      // Once the order placed, update Stock of each item
      final productController = Get.put(ProductController());

      for (var product in cartController.cartItems) {
        await productController.updateProductStock(
            product.productId, product.quantity, product.variationId);
      }

      // Update the cart status
      cartController.clearCart();

      // Show Success screen
      Get.off(() => SuccessScreen(
        image: MyImages.orderCompletedAnimation,
        title: 'Succès du paiement !',
        subTitle: 'Votre article sera expédié sous peu !',
        onPressed: () => Get.offAll(() => const HomeMenu()),
      ));
    } catch (e) {
      MyLoaders.errorSnackBar(title: 'Oups', message: e.toString());
    }
  }
}
