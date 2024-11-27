import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/cubit/cart_cubit.dart';
import 'package:frontend/data/model/cart.dart';
import 'dart:convert';

import 'package:frontend/data/model/product.dart';

class ListTileCustom extends StatefulWidget {
  final int id;
  final String name;
  final double price;
  final String photo;
  final double screenWidth;
  final double screenHeight;
  final double paddingHorizontal;
  final double paddingVertical;
  final double containerHeight;
  final double imageWidth;
  final double imageHeight;
  final double buttonSize;

  const ListTileCustom({
    super.key,
    required this.id,
    required this.name,
    required this.price,
    required this.photo,
    required this.paddingHorizontal,
    required this.screenHeight,
    required this.screenWidth,
    required this.paddingVertical,
    required this.buttonSize,
    required this.containerHeight,
    required this.imageHeight,
    required this.imageWidth,
  });

  @override
  State<ListTileCustom> createState() => _ListTileState();
}

class _ListTileState extends State<ListTileCustom> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: widget.paddingHorizontal,
        vertical: widget.paddingVertical,
      ),
      child: Container(
        height: widget.containerHeight,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(widget.screenWidth * 0.05),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.11),
              blurRadius: 40,
              spreadRadius: 0.0,
            ),
          ],
        ),
        child: Stack(
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(widget.paddingHorizontal),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: widget.screenWidth * 0.055,
                          ),
                        ),
                        SizedBox(height: widget.screenHeight * 0.01),
                        Text(
                          '${widget.price.toString()} \$',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: widget.screenWidth * 0.05,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: widget.imageWidth,
                  child: Padding(
                    padding: EdgeInsets.only(right: widget.paddingHorizontal),
                    child: Image.memory(
                      base64Decode(widget.photo),
                      width: widget.imageWidth,
                      height: widget.imageHeight,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            ),
            // add to cart
            Positioned(
              bottom: 0,
              right: 0,
              child: GestureDetector(
                onTap: () => addToCart(
                  context,
                  widget.id,
                  widget.name,
                  widget.price,
                  widget.photo,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(widget.screenWidth * 0.05),
                    topLeft: Radius.circular(widget.screenWidth * 0.05),
                  ),
                  child: SizedBox(
                    width: widget.buttonSize,
                    height: widget.buttonSize,
                    child: DecoratedBox(
                      decoration: const BoxDecoration(color: Colors.blue),
                      child: Icon(
                        Icons.add_shopping_cart,
                        color: Colors.white,
                        size: widget.buttonSize * 0.6,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  addToCart(
    BuildContext context,
    int id,
    String name,
    double price,
    String image,
  ) {
    final cartCubit = BlocProvider.of<CartCubit>(context);
    cartCubit.addToCart(CartModel(
      id: id,
      count: 1,
      name: name,
      photo: image,
      price: price,
      size: 43,
    ));
  }
}
