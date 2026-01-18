import 'package:cached_network_image/cached_network_image.dart';
import 'package:dushka_burger/core/theming/app_color.dart';
import 'package:flutter/material.dart';

class ProductNetworkImage extends StatelessWidget {
  final String url;
  final double size;
  final BorderRadius borderRadius;
  final BoxFit fit;

  const ProductNetworkImage({
    super.key,
    required this.url,
    required this.size,
    required this.borderRadius,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    if (url.isEmpty) {
      return _ProductImagePlaceholder(size: size, borderRadius: borderRadius);
    }
    return ClipRRect(
      borderRadius: borderRadius,
      child: CachedNetworkImage(
        imageUrl: url,
        width: size,
        height: size,
        fit: fit,
        placeholder: (context, url) {
          return _ProductImagePlaceholder(
            size: size,
            borderRadius: borderRadius,
          );
        },
        errorWidget: (context, url, error) {
          return _ProductImagePlaceholder(
            size: size,
            borderRadius: borderRadius,
          );
        },
      ),
    );
  }
}

class _ProductImagePlaceholder extends StatelessWidget {
  final double size;
  final BorderRadius borderRadius;

  const _ProductImagePlaceholder({
    required this.size,
    required this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: ColorManager.brownColor,
        borderRadius: borderRadius,
      ),
      child: Icon(
        Icons.fastfood,
        color: ColorManager.navUnselected,
        size: size * 0.5,
      ),
    );
  }
}
