import 'package:dushka_burger/Presentation/layout/widgets/home_cart_button.dart';
import 'package:dushka_burger/Presentation/layout/widgets/home_nav_item.dart';
import 'package:dushka_burger/Presentation/layout/widgets/home_nav_item_data.dart';
import 'package:dushka_burger/Presentation/manager/cart_manger/cart_cubit.dart';
import 'package:dushka_burger/Presentation/manager/cart_manger/cart_state.dart';
import 'package:dushka_burger/core/theming/app_color.dart';
import 'package:dushka_burger/core/utils/extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBottomNavBar extends StatelessWidget {
  final List<HomeNavItemData> items;
  final int currentIndex;
  final ValueChanged<int> onItemSelected;
  final Animation<double> waveAnimation;

  const HomeBottomNavBar({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onItemSelected,
    required this.waveAnimation,
  });

  @override
  Widget build(BuildContext context) {
    final width = context.width;
    final height = context.height;
    final barHeight = height * 0.08;
    final totalHeight = height * 0.085;
    return SizedBox(
      height: totalHeight,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: barHeight,
              padding: EdgeInsets.symmetric(horizontal: width * 0.04),
              decoration: BoxDecoration(
                color: ColorManager.brownColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(width * 0.085),
                  topRight: Radius.circular(width * 0.085),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: width * 0.043,
                    offset: Offset(0, -height * 0.007),
                  ),
                ],
              ),
              child: Row(
                children: [
                  HomeNavItem(
                    item: items[0],
                    isSelected: currentIndex == 0,
                    onTap: () => onItemSelected(0),
                  ),
                  HomeNavItem(
                    item: items[1],
                    isSelected: currentIndex == 1,
                    onTap: () => onItemSelected(1),
                  ),
                  SizedBox(width: width * 0.192),
                  HomeNavItem(
                    item: items[2],
                    isSelected: currentIndex == 2,
                    onTap: () => onItemSelected(2),
                  ),
                  HomeNavItem(
                    item: items[3],
                    isSelected: currentIndex == 3,
                    onTap: () => onItemSelected(3),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: BlocBuilder<CartCubit, CartState>(
              builder: (context, state) {
                final cartCount =
                    state is CartLoaded ? state.response.totalItems : 0;
                return SizedBox(
                  width: width * 0.192,
                  child: HomeCartButton(
                    cartCount: cartCount,
                    waveAnimation: waveAnimation,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
