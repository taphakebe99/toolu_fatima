import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/constants/sizes.dart';
import '../../models/product_model.dart';

class ImagesController extends GetxController {
  static ImagesController get instance => Get.find();

  /// Variables
  RxString selectedProductImage = ''.obs;

  /// -- Get All Images from product and Variations
  List<String> getAllProductImages(ProductModel product) {
    // Use Set to add unique images only
    Set<String> images = {};

    // Load thumbnail image
    images.add(product.image);
    // Assign Thumbnail as Selected Image
    selectedProductImage.value = product.image;

    return images.toList();
  }

  /// -- Show Image Popup
  void showEnlargedImage(String image) {
    Get.to(
      fullscreenDialog: true,
      () => Dialog.fullscreen(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: MySizes.defaultSpace * 2,
                    horizontal: MySizes.defaultSpace),
                child: CachedNetworkImage(imageUrl: image),
              ),
              const SizedBox(height: MySizes.spaceBtwSections),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: 150,
                  child: OutlinedButton(
                      onPressed: () => Get.back(), child: const Text('Fermer')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
