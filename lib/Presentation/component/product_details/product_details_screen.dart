import 'package:dushka_burger/Domain/entities/category.dart';
import 'package:dushka_burger/Presentation/component/product_details/product_details_content.dart';
import 'package:dushka_burger/Presentation/component/product_details/product_details_controller.dart';
import 'package:dushka_burger/Presentation/component/product_details/widgets/product_details_add_to_cart_bar.dart';
import 'package:dushka_burger/Presentation/manager/addons_manger/addons_cubit.dart';
import 'package:dushka_burger/Presentation/manager/addons_manger/addons_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Product product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  late final ProductDetailsController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ProductDetailsController(
      onStateChanged: _handleStateChanged,
      isMounted: () => mounted,
    )..init(widget.product);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleStateChanged() {
    if (!mounted) {
      return;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _controller.addonsCubit,
      child: Scaffold(
        backgroundColor: const Color(0xFFE7E3DA),
        bottomNavigationBar: BlocBuilder<AddonsCubit, AddonsState>(
          builder: (context, state) {
            if (state is AddonsLoaded) {
              final canAdd = _controller.allRequiredSelected(state.response);
              return ProductDetailsAddToCartBar(
                enabled: canAdd,
                onPressed: canAdd
                    ? () => _controller.handleAddToCart(
                          context,
                          widget.product,
                          state.response,
                        )
                    : null,
              );
            }
            return const ProductDetailsAddToCartBar(
              enabled: false,
              onPressed: null,
            );
          },
        ),
        body: ProductDetailsContent(
          product: widget.product,
          quantity: _controller.quantity,
          onIncrement: _controller.incrementQuantity,
          onDecrement: _controller.decrementQuantity,
          isSelected: _controller.isOptionSelected,
          onToggle: _controller.toggleOption,
        ),
      ),
    );
  }
}
