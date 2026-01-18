import 'package:dushka_burger/core/resource_manager/string_manager.dart';
import 'package:dushka_burger/core/theming/app_color.dart';
import 'package:dushka_burger/core/utils/extentions.dart';
import 'package:dushka_burger/Presentation/manager/locale_manger/locale_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = context.width;
    final height = context.height;
    final locale = context.watch<LocaleCubit>().state.locale;
    final isArabic = locale.languageCode == 'ar';
    final currentLanguage =
        isArabic ? StringManager.arabic.tr() : StringManager.english.tr();
    return Container(
      color: ColorManager.brownColor,
      child: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.06,
            vertical: height * 0.03,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _SettingsHeader(width: width, height: height),
              SizedBox(height: height * 0.035),
              Text(
                StringManager.language.tr(),
                style: TextStyle(
                  fontSize: width * 0.045,
                  fontWeight: FontWeight.w700,
                  color: ColorManager.navSelected,
                ),
              ),
              SizedBox(height: height * 0.014),
              _SettingTile(
                icon: Icons.translate_rounded,
                title: StringManager.selectLanguage.tr(),
                value: currentLanguage,
                onTap: () => _showLanguageSheet(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showLanguageSheet(BuildContext context) {
    final currentCode = context.read<LocaleCubit>().state.locale.languageCode;
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        final width = sheetContext.width;
        final height = sheetContext.height;
        return Container(
          padding: EdgeInsets.fromLTRB(
            width * 0.06,
            height * 0.018,
            width * 0.06,
            height * 0.02 + MediaQuery.viewPaddingOf(sheetContext).bottom,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(width * 0.08),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 12,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: width * 0.14,
                  height: 4,
                  decoration: BoxDecoration(
                    color: ColorManager.navUnselected.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(height: height * 0.02),
              Text(
                StringManager.selectLanguage.tr(),
                style: TextStyle(
                  fontSize: width * 0.048,
                  fontWeight: FontWeight.w700,
                  color: ColorManager.navSelected,
                ),
              ),
              SizedBox(height: height * 0.02),
              _LanguageOption(
                label: StringManager.english.tr(),
                isSelected: currentCode == 'en',
                onTap: () => _setLocale(sheetContext, const Locale('en')),
              ),
              SizedBox(height: height * 0.012),
              _LanguageOption(
                label: StringManager.arabic.tr(),
                isSelected: currentCode == 'ar',
                onTap: () => _setLocale(sheetContext, const Locale('ar')),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _setLocale(BuildContext context, Locale locale) async {
    await context.read<LocaleCubit>().setLocale(context, locale);
    if (context.mounted) Navigator.of(context).pop();
  }
}

class _SettingsHeader extends StatelessWidget {
  final double width;
  final double height;

  const _SettingsHeader({required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.05,
        vertical: height * 0.022,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(width * 0.06),
        gradient: const LinearGradient(
          colors: [
            ColorManager.primaryColor,
            Color(0xFFC10D2A),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: width * 0.12,
            height: width * 0.12,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.18),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.settings_outlined,
              color: Colors.white,
            ),
          ),
          SizedBox(width: width * 0.04),
          Expanded(
            child: Text(
              StringManager.settings.tr(),
              style: TextStyle(
                fontSize: width * 0.055,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final VoidCallback onTap;

  const _SettingTile({
    required this.icon,
    required this.title,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final width = context.width;
    final height = context.height;
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(width * 0.05),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(width * 0.05),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.045,
            vertical: height * 0.018,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(width * 0.05),
            border: Border.all(
              color: ColorManager.navUnselected.withOpacity(0.25),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: width * 0.11,
                height: width * 0.11,
                decoration: BoxDecoration(
                  color: ColorManager.brownColor,
                  borderRadius: BorderRadius.circular(width * 0.03),
                ),
                child: Icon(icon, color: ColorManager.navSelected),
              ),
              SizedBox(width: width * 0.04),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: width * 0.042,
                        fontWeight: FontWeight.w600,
                        color: ColorManager.navSelected,
                      ),
                    ),
                    SizedBox(height: height * 0.004),
                    Text(
                      value,
                      style: TextStyle(
                        fontSize: width * 0.038,
                        color: ColorManager.navUnselected,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: ColorManager.navUnselected,
                size: width * 0.08,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LanguageOption extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _LanguageOption({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final width = context.width;
    final height = context.height;
    final borderColor = isSelected
        ? ColorManager.primaryColor
        : ColorManager.navUnselected.withOpacity(0.3);
    final backgroundColor =
        isSelected ? ColorManager.brownColor : Colors.transparent;
    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(width * 0.04),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(width * 0.04),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.04,
            vertical: height * 0.016,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(width * 0.04),
            border: Border.all(color: borderColor),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: width * 0.042,
                    fontWeight: FontWeight.w600,
                    color: ColorManager.navSelected,
                  ),
                ),
              ),
              if (isSelected)
                Icon(
                  Icons.check_circle,
                  color: ColorManager.primaryColor,
                  size: width * 0.06,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
