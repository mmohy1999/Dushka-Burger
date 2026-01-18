import 'package:dushka_burger/Presentation/component/product_details/widgets/shimmer_box.dart';
import 'package:dushka_burger/core/utils/extentions.dart';
import 'package:flutter/material.dart';

class ProductDetailsExtrasLoading extends StatelessWidget {
  const ProductDetailsExtrasLoading({super.key});

  @override
  Widget build(BuildContext context) {
    final width = context.width;
    final height = context.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShimmerBox(
          width: width * 0.3,
          height: height * 0.02,
          borderRadius: BorderRadius.circular(width * 0.02),
        ),
        SizedBox(height: height * 0.02),
        ShimmerBox(
          width: width,
          height: height * 0.08,
          borderRadius: BorderRadius.circular(width * 0.04),
        ),
        SizedBox(height: height * 0.015),
        ShimmerBox(
          width: width,
          height: height * 0.08,
          borderRadius: BorderRadius.circular(width * 0.04),
        ),
      ],
    );
  }
}
