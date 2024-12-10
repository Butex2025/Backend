import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/cubit/cart_cubit.dart';

class ProductTile extends StatefulWidget {
  final int id;
  final String name;
  final double price;
  final String imageUrl;
  final int initialQuantity;
  final int size;

  const ProductTile({
    super.key,
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.initialQuantity,
    required this.size,
  });

  @override
  State<ProductTile> createState() => _ProductTileState();
}

class _ProductTileState extends State<ProductTile> {
  late int quantity;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.memory(
                base64Decode(widget.imageUrl),
                height: 60,
                width: 60,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        '\$${widget.price.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        ' Size: ${widget.size}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () => decrementQuantity(context, widget.id),
                  icon: const Icon(Icons.remove_circle_outline),
                  color: Colors.grey,
                ),
                Text(
                  '${widget.initialQuantity}',
                  style: const TextStyle(fontSize: 16),
                ),
                IconButton(
                  onPressed: () => incrementQuantity(context, widget.id),
                  icon: const Icon(Icons.add_circle_outline),
                  color: Colors.blue,
                ),
              ],
            ),
            const SizedBox(width: 8),
            IconButton(
              onPressed: () => removeItem(context, widget.name),
              icon: const Icon(Icons.delete_outline),
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}

void incrementQuantity(BuildContext context, int id) {
  final cartCubit = BlocProvider.of<CartCubit>(context);
  cartCubit.editItem(id, true);
}

void decrementQuantity(BuildContext context, int id) {
  final cartCubit = BlocProvider.of<CartCubit>(context);
  cartCubit.editItem(id, false);
}

void removeItem(BuildContext context, String name) {
  final cartCubit = BlocProvider.of<CartCubit>(context);
  cartCubit.removeFromCart(name);
}
