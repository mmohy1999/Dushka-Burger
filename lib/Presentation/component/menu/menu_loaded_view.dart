import 'package:dushka_burger/Domain/entities/category.dart';
import 'package:dushka_burger/Presentation/component/menu/menu_loaded_controller.dart';
import 'package:dushka_burger/Presentation/component/menu/widgets/menu_category_list.dart';
import 'package:dushka_burger/Presentation/component/menu/widgets/menu_category_strip.dart';
import 'package:dushka_burger/Presentation/component/menu/widgets/menu_empty_state.dart';
import 'package:dushka_burger/core/theming/app_color.dart';
import 'package:dushka_burger/core/utils/extentions.dart';
import 'package:flutter/material.dart';

class MenuLoadedView extends StatefulWidget {
  final List<CategoryWithProducts> categories;

  const MenuLoadedView({super.key, required this.categories});

  @override
  State<MenuLoadedView> createState() => _MenuLoadedViewState();
}

class _MenuLoadedViewState extends State<MenuLoadedView> {
  late final MenuLoadedController _controller;

  @override
  void initState() {
    super.initState();
    _controller = MenuLoadedController(
      onSelectionChanged: _handleSelectionChanged,
      isMounted: () => mounted,
    )..init();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleSelectionChanged() {
    if (!mounted) {
      return;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final categories = widget.categories;
    _controller.syncCategoryKeys(categories.length);
    final height = context.height;
    final isEmpty =
        categories.isEmpty ||
        categories.every((category) => category.products.isEmpty);
    if (isEmpty) {
      return const MenuEmptyState();
    }
    return Container(
      color: ColorManager.brownColor,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: height * 0.015),
            MenuCategoryStrip(
              categories: categories,
              selectedIndex: _controller.selectedIndex,
              chipKeys: _controller.chipKeys,
              scrollController: _controller.categoryScrollController,
              onCategoryTap: _controller.onCategoryTap,
            ),
            SizedBox(height: height * 0.015),
            Expanded(
              child: MenuCategoryList(
                categories: categories,
                headerKeys: _controller.categoryKeys,
                listKey: _controller.listKey,
                scrollController: _controller.scrollController,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
