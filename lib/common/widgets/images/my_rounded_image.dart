/*import 'package:flutter/material.dart';

import '../../../utils/constants/sizes.dart';

class MyRoundedImage extends StatelessWidget {
  const MyRoundedImage({
    super.key,
    this.width,
    this.height,
    required this.imageUrl,
    this.applyImageRadius = true,
    this.border,
    this.fit = BoxFit.contain,
    this.backgroundColor,
    this.padding,
    this.isNetworkImage = false,
    this.onPressed,
    this.borderRadius = MySizes.md,
  });

  final double? width, height;
  final String imageUrl;
  final bool applyImageRadius;
  final BoxBorder? border;
  final BoxFit? fit;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final bool isNetworkImage;
  final VoidCallback? onPressed;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        decoration: BoxDecoration(
          border: border,
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: ClipRRect(
          borderRadius: applyImageRadius
              ? BorderRadius.circular(borderRadius)
              : BorderRadius.zero,
          child: Image(
            image: isNetworkImage
                ? NetworkImage(imageUrl)
                : AssetImage(imageUrl) as ImageProvider,
            fit: fit,
          ),
        ),
      ),
    );
  }
}
*/

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utils/constants/sizes.dart';

class MyRoundedImage extends StatelessWidget {
  const MyRoundedImage({
    super.key,
    this.width = double.infinity,
    this.height,
    required this.imageUrl,
    this.applyImageRadius = true,
    this.border,
    this.fit = BoxFit.contain,
    this.backgroundColor,
    this.padding,
    this.isNetworkImage = false,
    this.onPressed,
    this.borderRadius = MySizes.md,
  });

  final double? width, height;
  final String imageUrl;
  final bool applyImageRadius;
  final BoxBorder? border;
  final BoxFit? fit;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final bool isNetworkImage;
  final VoidCallback? onPressed;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        decoration: BoxDecoration(
          border: border,
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: ClipRRect(
          borderRadius: applyImageRadius
              ? BorderRadius.circular(borderRadius)
              : BorderRadius.zero,
          child: isNetworkImage
              ? CachedNetworkImage(
                  imageUrl:
                      imageUrl.isNotEmpty ? imageUrl : "", // URL par défaut
                  fit: fit,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) =>
                      const Icon(Iconsax.image),
                )
              : Image.asset(
                  imageUrl,
                  fit: fit,
                ),
        ),
      ),
    );
  }
}
