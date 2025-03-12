import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../utils/local_storage/storage_utility.dart';
import '../../../../utils/popups/loaders.dart';
import '../../models/cart_item_model.dart';
import '../../models/product_model.dart';

class CartController extends GetxController {
  static CartController get instance => Get.find();

  final instruction = TextEditingController();

  RxString unit = ''.obs;
  RxInt noOfCartItems = 0.obs;
  RxDouble totalCartPrice = 0.0.obs;
  RxInt productQuantityInCart = 0.obs;
  RxList<CartItemModel> cartItems = <CartItemModel>[].obs;

  CartController() {
    loadCartItems();
  }

  /// Cette fonction convertit un `ProductModel` en `CartItemModel`
  CartItemModel convertToCartItem(
      ProductModel product, int quantity, String instruction, String unit) {
    final price = product.price;
    return CartItemModel(
      productId: product.id,
      title: product.title,
      price: price,
      unit: unit,
      quantity: quantity,
      instruction: instruction,
      image: product.image,
    );
  }

  void addToCart(ProductModel product) {
    // Vérification de la quantité
    if (productQuantityInCart.value < 1) {
      MyLoaders.customToast(message: 'Veuillez sélectionner une quantité.');
      return;
    }

    // Conversion du `ProductModel` en `CartItemModel` avec la quantité donnée
    final selectedCartItem = convertToCartItem(product,
        productQuantityInCart.value, instruction.value.text, unit.value);

    // Vérifier si le produit est déjà ajouté au panier
    int index = cartItems.indexWhere(
        (cartItem) => cartItem.productId == selectedCartItem.productId);

    if (index >= 0) {
      // Mise à jour de la quantité si le produit est déjà ajouté
      cartItems[index].quantity = selectedCartItem.quantity;
    } else {
      cartItems.add(selectedCartItem);
    }

    updateCart();
    MyLoaders.customToast(
        message: 'Votre produit a été ajouté au panier avec succès.');
  }

  void addOneToCart(CartItemModel item) {
    int index = cartItems
        .indexWhere((cartItem) => cartItem.productId == item.productId);

    if (index >= 0) {
      cartItems[index].quantity += 1;
    } else {
      cartItems.add(item);
    }

    updateCart();
  }

  void removeOneFromCart(CartItemModel item) {
    int index = cartItems
        .indexWhere((cartItem) => cartItem.productId == item.productId);

    if (index >= 0) {
      if (cartItems[index].quantity > 1) {
        cartItems[index].quantity -= 1;
      } else {
        // Afficher une boîte de dialogue avant de supprimer complètement
        cartItems[index].quantity == 1
            ? removeFromCartDialog(index)
            : cartItems.removeAt(index);
      }
      updateCart();
    }
  }

  void removeFromCartDialog(int index) {
    Get.defaultDialog(
      title: 'Supprimer le produit',
      middleText: 'Êtes-vous sûr de vouloir supprimer ce produit du panier ?',
      onConfirm: () {
        // Supprimer l'article du panier
        cartItems.removeAt(index);
        updateCart();
        MyLoaders.customToast(message: 'Le produit a été supprimé du panier.');
        Get.back();
      },
      onCancel: () => Get.back(),
    );
  }

  void updateCart() {
    updateCartTotals();
    saveCartItems();
    cartItems.refresh();
  }

  void loadCartItems() async {
    final cartItemStrings =
        MyLocalStorage.instance().readData<List<dynamic>>('cartItems');
    if (cartItemStrings != null) {
      cartItems.assignAll(cartItemStrings
          .map((item) => CartItemModel.fromJson(item as Map<String, dynamic>)));
      updateCartTotals();
    }
  }

  void updateCartTotals() {
    double calculatedTotalPrice = 0.0;
    int calculatedNoOfItems = 0;

    for (var item in cartItems) {
      calculatedTotalPrice += (item.price) * item.quantity.toDouble();
      calculatedNoOfItems += item.quantity;
    }

    totalCartPrice.value = calculatedTotalPrice;
    noOfCartItems.value = calculatedNoOfItems;
  }

  void saveCartItems() {
    final cartItemStrings = cartItems.map((item) => item.toJson()).toList();
    MyLocalStorage.instance().writeData('cartItems', cartItemStrings);
  }

  /// -- Initialiser le nombre d'articles déjà ajoutés au panier
  void updateAlreadyAddedProductCount(ProductModel product) {
    productQuantityInCart.value = getProductQuantityInCart(product.id);
  }

  int getProductQuantityInCart(String productId) {
    final foundItem = cartItems
        .where((item) => item.productId == productId)
        .fold(0, (previousValue, element) => previousValue + element.quantity);
    return foundItem;
  }

  void clearCart() {
    productQuantityInCart.value = 0;
    cartItems.clear();
    updateCart();
  }
}
