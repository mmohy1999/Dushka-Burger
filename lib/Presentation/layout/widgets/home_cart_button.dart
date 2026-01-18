import 'package:dushka_burger/Presentation/manager/cart_manger/cart_cubit.dart';
import 'package:dushka_burger/core/resource_manager/app_images.dart';
import 'package:dushka_burger/core/resource_manager/routes_manager.dart';
import 'package:dushka_burger/core/theming/app_color.dart';
import 'package:dushka_burger/core/utils/extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeCartButton extends StatelessWidget {
  final int cartCount;
  final Animation<double> waveAnimation;

  const HomeCartButton({
    super.key,
    required this.cartCount,
    required this.waveAnimation,
  });

  @override
  Widget build(BuildContext context) {
    final width = context.width;
    final height = context.height;
    return GestureDetector(
      onTap: () {
        context.pushNamed(
          Routes.cart,
          arguments: context.read<CartCubit>(),
        );
      },
      child: Center(
        child: Transform.translate(
          offset: Offset(0, -height * 0.025),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              if (cartCount > 0)
                Positioned.fill(
                  child: IgnorePointer(
                    child: AnimatedBuilder(
                      animation: waveAnimation,
                      builder: (context, child) {
                        final value = waveAnimation.value;
                        final scale = 1 + (value * 0.6);
                        final opacity = (1 - value) * 0.55;
                        return Transform.scale(
                          scale: scale,
                          child: Opacity(
                            opacity: opacity.clamp(0.0, 1.0),
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: ColorManager.navSelected.withOpacity(
                                  0.5,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              Container(
                width: width * 0.17,
                height: width * 0.17,
                decoration: BoxDecoration(
                  color: ColorManager.navSelected,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: width * 0.032,
                      offset: Offset(0, height * 0.007),
                    ),
                  ],
                ),
                child: Center(
                  child: SvgPicture.asset(
                    AppImages.cart,
                    height: width * 0.07,
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 0,
                bottom: 0,
                right: width * 0.013,
                child: Container(
                  width: width * 0.058,
                  height: width * 0.058,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: ColorManager.navSelected,
                      width: width * 0.005,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    cartCount.toString(),
                    style: TextStyle(
                      fontSize: width * 0.031,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
