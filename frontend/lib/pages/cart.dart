import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/cubit/cart_cubit.dart';
import 'package:frontend/data/model/cart.dart';
import 'package:frontend/pages/checkout_page.dart';
import 'package:frontend/pages/lists_tile/cart_tile.dart';

class Cart extends StatefulWidget {
  final List<CartModel> items;
  const Cart({
    super.key,
    required this.items,
  });

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  double ammount = 0;
  double shipping = 50;
  void countPrice() async {
    double countPrice = 0;
    for (var i = 0; i < widget.items.length; i++) {
      countPrice = countPrice + widget.items[i].price;
    }
    setState(() {
      ammount = countPrice;
    });
  }

  @override
  void initState() {
    countPrice();
    super.initState();
  }

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
                  name: item.name,
                  price: item.price,
                  imageUrl: item.photo,
                  initialQuantity: item.count,
                );
              },
            ),
          ),
          SizedBox(
            width: screenWidth * 0.9,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  'Subtotal',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                Text(
                  '$ammount \$',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            width: screenWidth * 0.8,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
          SizedBox(
            width: screenWidth * 0.85,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text(
                  'Total',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                Text(
                  '${ammount + shipping} \$',
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
            width: 330,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const CheckoutPage()),);
              },
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
