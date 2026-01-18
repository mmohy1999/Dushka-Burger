import 'dart:io';

import 'package:dushka_burger/Presentation/component/menu/menu_screen.dart';
import 'package:dushka_burger/Presentation/layout/widgets/home_bottom_nav_bar.dart';
import 'package:dushka_burger/Presentation/layout/widgets/home_nav_item_data.dart';
import 'package:dushka_burger/Presentation/layout/widgets/home_placeholder_page.dart';
import 'package:dushka_burger/core/resource_manager/app_images.dart';
import 'package:dushka_burger/core/resource_manager/string_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  late final AnimationController _waveController;
  late final Animation<double> _waveAnimation;

  @override
  void initState() {
    super.initState();
    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat();
    _waveAnimation = CurvedAnimation(
      parent: _waveController,
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    _waveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final items = [
      HomeNavItemData(
        label: StringManager.home.tr(),
        selectedIcon: AppImages.homeSelected,
        unselectedIcon: AppImages.homeUnselected,
      ),
      HomeNavItemData(
        label: StringManager.menu.tr(),
        selectedIcon: AppImages.menuSelected,
        unselectedIcon: AppImages.menuUnselected,
      ),
      HomeNavItemData(
        label: StringManager.offers.tr(),
        selectedIcon: AppImages.offerSelected,
        unselectedIcon: AppImages.offerUnselected,
      ),
      HomeNavItemData(
        label: StringManager.account.tr(),
        selectedIcon: AppImages.accountSelected,
        unselectedIcon: AppImages.accountUnselected,
      ),
    ];
    return WillPopScope(
      onWillPop: _handleWillPop,
      child: Scaffold(
        body: _buildBody(),
        bottomNavigationBar: HomeBottomNavBar(
          items: items,
          currentIndex: _currentIndex,
          onItemSelected: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          waveAnimation: _waveAnimation,
        ),
      ),
    );
  }

  Future<bool> _handleWillPop() async {
    if (Navigator.of(context).canPop()) {
      return true;
    }
    if (Platform.isAndroid) {
      SystemNavigator.pop();
    }
    return false;
  }

  Widget _buildBody() {
    final pages = [
      HomePlaceholderPage(label: StringManager.home.tr()),
      MenuScreen(),
      HomePlaceholderPage(label: StringManager.offers.tr()),
      HomePlaceholderPage(label: StringManager.account.tr()),
    ];
    return pages[_currentIndex];
  }
}
