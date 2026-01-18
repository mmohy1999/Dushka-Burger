import 'package:dushka_burger/Domain/entities/addons.dart';
import 'package:dushka_burger/Presentation/component/product_details/widgets/product_details_addon_block.dart';
import 'package:dushka_burger/Presentation/component/product_details/widgets/product_details_extras_loading.dart';
import 'package:dushka_burger/Presentation/manager/addons_manger/addons_cubit.dart';
import 'package:dushka_burger/Presentation/manager/addons_manger/addons_state.dart';
import 'package:dushka_burger/core/theming/app_color.dart';
import 'package:dushka_burger/core/utils/extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsExtrasSection extends StatelessWidget {
  final bool Function(AddonItem, int) isSelected;
  final void Function(AddonItem, int) onToggle;

  const ProductDetailsExtrasSection({
    super.key,
    required this.isSelected,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddonsCubit, AddonsState>(
      builder: (context, state) {
        if (state is AddonsLoading || state is AddonsInitial) {
          return const ProductDetailsExtrasLoading();
        }
        if (state is AddonsError) {
          return Text(
            state.error.readableMessage,
            style: TextStyle(
              fontSize: context.width * 0.036,
              fontWeight: FontWeight.w600,
              color: ColorManager.navSelected,
            ),
          );
        }
        if (state is AddonsLoaded) {
          final response = state.response;
          if (response.blocks.isEmpty) {
            return const SizedBox.shrink();
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final block in response.blocks)
                ProductDetailsAddonBlock(
                  block: block,
                  isSelected: isSelected,
                  onToggle: onToggle,
                ),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
