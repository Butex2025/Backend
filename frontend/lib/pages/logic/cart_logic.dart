import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/cubit/cart_cubit.dart';
import 'package:frontend/pages/cart.dart';
import 'package:frontend/pages/loading.dart';

class CartLogic extends StatelessWidget {
  // final CartCubit cartCubit;

  const CartLogic({
    super.key,
    // required this.cartCubit,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      // bloc: cartCubit,
      builder: (context, state) {
        if (state is CartInit) {
          return const LoadingScreen();
        }
        if (state is CartList) {
          return Cart(items: state.items);
        }
        return const LoadingScreen();
      },
    );
  }
}
