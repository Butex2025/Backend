import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/cubit/shop_cubit.dart';
import 'package:frontend/data/model/product.dart';

class DetailPage extends StatelessWidget {
  final ProductModel product;
  final List<ProductModel> list;
  const DetailPage({
    super.key,
    required this.product,
    required this.list,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            moveBackToMainScreen(
              context,
              list,
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () {
              // cart
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.memory(base64Decode(product.image)),
          Text(product.name),
          Text('${product.price} \$'),
          const Text(
            'Size',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}

moveBackToMainScreen(BuildContext context, List<ProductModel> list) {
  final pokeCubit = BlocProvider.of<ShopCubit>(context);
  pokeCubit.moveBackToMainScreen(list);
}
