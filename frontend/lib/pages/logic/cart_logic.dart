import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/cubit/cart_cubit.dart';
import 'package:frontend/pages/cart.dart';
import 'package:frontend/pages/loading.dart';
import 'package:frontend/pages/map_page.dart';
import 'package:frontend/pay_page.dart';

class CartLogic extends StatelessWidget {
  const CartLogic({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        if (state is CartInit) {
          return const LoadingScreen();
        } else if (state is CartList) {
          return Cart(items: state.items, ammount: state.fullPirce);
        } else if (state is CartMap) {
          return MapPage(markers: state.markers);
        } else if (state is WebPay) {
          return PayPage(url: state.link);
        }
        return const LoadingScreen();
      },
    );
  }
}
