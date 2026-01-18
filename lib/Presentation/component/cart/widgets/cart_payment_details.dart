import 'package:dushka_burger/Presentation/component/cart/cart_theme.dart';
import 'package:dushka_burger/core/resource_manager/string_manager.dart';
import 'package:dushka_burger/core/utils/extentions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CartPaymentDetails extends StatelessWidget {
  final String totalPrice;
  final String vat;
  final String totalPayment;

  const CartPaymentDetails({
    super.key,
    required this.totalPrice,
    required this.vat,
    required this.totalPayment,
  });

  @override
  Widget build(BuildContext context) {
    final width = context.width;
    final height = context.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          StringManager.paymentDetails.tr(),
          style: TextStyle(
            fontSize: width * 0.048,
            fontWeight: FontWeight.w700,
            color: CartColors.textPrimary,
          ),
        ),
        SizedBox(height: height * 0.015),
        Divider(color: CartColors.divider),
        SizedBox(height: height * 0.01),
        _PaymentRow(
          label: StringManager.totalPrice.tr(),
          value: totalPrice,
          isBold: false,
        ),
        SizedBox(height: height * 0.012),
        _PaymentRow(
          label: StringManager.vat.tr(),
          value: vat,
          isBold: false,
        ),
        SizedBox(height: height * 0.018),
        Divider(color: CartColors.divider),
        SizedBox(height: height * 0.02),
        _PaymentRow(
          label: StringManager.totalPayment.tr(),
          value: totalPayment,
          isBold: true,
        ),
      ],
    );
  }
}

class _PaymentRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isBold;

  const _PaymentRow({
    required this.label,
    required this.value,
    required this.isBold,
  });

  @override
  Widget build(BuildContext context) {
    final width = context.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isBold ? width * 0.042 : width * 0.038,
            fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
            color: CartColors.textPrimary,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isBold ? width * 0.042 : width * 0.038,
            fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
            color: CartColors.textPrimary,
          ),
        ),
      ],
    );
  }
}
