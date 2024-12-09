import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/cubit/cart_cubit.dart';
import 'package:frontend/data/model/cart.dart';
import 'package:frontend/pages/checkout_page.dart';
import 'package:frontend/pages/lists_tile/cart_tile.dart';

class Cart extends StatefulWidget {
  final List<CartModel> items;
  final double ammount;

  const Cart({
    super.key,
    required this.items,
    required this.ammount,
  });

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  double shipping = 50;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Cart"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: ListView.builder(
              itemCount: widget.items.length,
              itemBuilder: (context, index) {
                final item = widget.items[index];
                return ProductTile(
                  id: item.id,
                  name: item.name,
                  price: item.price,
                  imageUrl: item.photo,
                  initialQuantity: item.count,
                  size: item.size,
                );
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10, left: 30, right: 30),
            width: screenWidth * 0.78,
            height: screenHeight * 0.035,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Subtotal',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                Text(
                  '${(widget.ammount).toString()} \$',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10, left: 30, right: 30),
            width: screenWidth * 0.78,
            height: screenHeight * 0.035,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Shipping',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                Text(
                  '$shipping \$',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10, left: 30, right: 30),
            width: screenWidth * 0.78,
            height: screenHeight * 0.035,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                Text(
                  '${widget.ammount + shipping} \$',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 30, left: 30, right: 30),
            width: screenWidth * 0.78,
            height: screenHeight * 0.055,
            child: ElevatedButton(
              onPressed: () => moveToMapScreen(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightBlue,
              ),
              child: const Text(
                'Checkout',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white),
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.05),
        ],
      ),
    );
  }
}

moveToMapScreen(BuildContext context) {
  final cartCubit = BlocProvider.of<CartCubit>(context);
  cartCubit.getLocationOfShops();
}
