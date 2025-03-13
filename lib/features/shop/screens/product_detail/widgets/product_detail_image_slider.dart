import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../common/widgets/custom_shapes/curved_edges/curved_edges_widgets.dart';
import '../../../../../common/widgets/images/my_rounded_image.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../controllers/product/images_controller.dart';
import '../../../models/product_model.dart';

class MyProductImageSlider extends StatelessWidget {
  const MyProductImageSlider(
      {super.key, required this.product, this.isNetworkImage = true});

  final ProductModel product;
  final bool isNetworkImage;

  @override
  Widget build(BuildContext context) {
    final controller = ImagesController.instance;
    final isDark = MyHelperFunctions.isDarkMode(context);
    final images = controller.getAllProductImages(product);
    return MyCurvedEdgesWidget(
      child: Container(
        color: isDark ? MyColors.darkerGrey : MyColors.light,
        child: Stack(
          children: [
            /// Main Large Image
            SizedBox(
              height: 400,
              child: Padding(
                padding: const EdgeInsets.all(MySizes.defaultSpace * 2),
                child: Center(
                  child: Obx(
                    () {
                      final image =
                          controller.selectedProductImage.value.isEmpty
                              ? product.thumbnail
                              : controller.selectedProductImage.value;
                      return GestureDetector(
                        onTap: () => controller.showEnlargedImage(image),
                        child: isNetworkImage
                            ? CachedNetworkImage(
                                imageUrl: image,
                                progressIndicatorBuilder:
                                    (_, __, downloadProgress) =>
                                        CircularProgressIndicator(
                                            value: downloadProgress.progress,
                                            color: MyColors.primary),
                                errorWidget: (_, __, ___) =>
                                    const Icon(Icons.error),
                              )
                            : Image(image: AssetImage(image)),
                      );
                    },
                  ),
                ),
              ),
            ),

            /// Image Slider
            Positioned(
              right: 0,
              bottom: 30,
              left: MySizes.defaultSpace,
              child: SizedBox(
                height: 80,
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: images.length,
                  scrollDirection: Axis.horizontal,
                  physics: const AlwaysScrollableScrollPhysics(),
                  separatorBuilder: (_, __) =>
                      const SizedBox(width: MySizes.spaceBtwItems),
                  itemBuilder: (_, index) {
                    return Obx(
                      () {
                        final imageSelected =
                            controller.selectedProductImage.value ==
                                images[index];
                        return MyRoundedImage(
                          isNetworkImage: isNetworkImage,
                          width: 80,
                          fit: BoxFit.contain,
                          imageUrl: images[index],
                          padding: const EdgeInsets.all(MySizes.sm),
                          backgroundColor:
                              isDark ? MyColors.dark : MyColors.white,
                          onPressed: () => controller
                              .selectedProductImage.value = images[index],
                          border: Border.all(
                              color: imageSelected
                                  ? MyColors.primary
                                  : Colors.transparent),
                        );
                      },
                    );
                  },
                ),
              ),
            ),

            /// Appbar Icons
            MyAppBar(
              showBackArrow: true,
            ),
          ],
        ),
      ),
    );
  }
}
