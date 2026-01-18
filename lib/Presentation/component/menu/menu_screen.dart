import 'package:dushka_burger/Presentation/component/menu/menu_loaded_view.dart';
import 'package:dushka_burger/Presentation/manager/menu_manger/menu_cubit.dart';
import 'package:dushka_burger/Presentation/manager/menu_manger/menu_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MenuCubit, MenuState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is MenuLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is MenuLoaded) {
          return MenuLoadedView(categories: state.categories);
        }
        if (state is MenuError) {
          return Center(child: Text(state.error.message ?? ''));
        }
        return const SizedBox();
      },
    );
  }
}
