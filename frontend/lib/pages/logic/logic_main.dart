import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/cubit/shop_cubit.dart';
import 'package:frontend/pages/detail_page.dart';
import 'package:frontend/pages/loading.dart';
import 'package:frontend/pages/main_screen.dart';

class LogicMain extends StatelessWidget {
  const LogicMain({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopCubit, ShopState>(
      builder: (context, state) {
        if (state is MainList) {
          return MainScreen(shopList: state.shopList);
        } else if (state is Loading) {
          return const LoadingScreen();
        } else if (state is MoveToDetailScreen) {
          return DetailPage(
            product: state.product,
            list: state.list,
          );
        }
        return const LoadingScreen();
      },
    );
  }
}
