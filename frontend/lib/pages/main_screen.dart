import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Map<String, dynamic>> shoes = [
    {
      'name': 'Air Max 90',
      'price': '\$120',
      'image': 'assets/images/bucik.png',
    },
    {
      'name': 'Air Max 90',
      'price': '\$120',
      'image': 'assets/images/bucik.png',
    },
    {
      'name': 'Air Max 90',
      'price': '\$120',
      'image': 'assets/images/bucik.png',
    },
    {
      'name': 'Air Max 90',
      'price': '\$120',
      'image': 'assets/images/bucik.png',
    },
    {
      'name': 'Air Max 90',
      'price': '\$120',
      'image': 'assets/images/bucik.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    // tu responsywnie sciagam width i height z urzadzenia
    // https://api.flutter.dev/flutter/widgets/MediaQuery-class.html
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    final double paddingHorizontal =
        screenWidth * 0.04; // 4% szerokosc telefonu
    final double paddingVertical =
        screenHeight * 0.015; // 1.5% wysokosc telefonu
    final double containerHeight = screenHeight * 0.18;
    final double imageWidth = screenWidth * 0.25;
    final double imageHeight = screenHeight * 0.12;
    final double buttonSize = screenWidth * 0.1;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu_rounded),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/user_page');
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart_outlined),
            onPressed: () {
              // cart
            },
          ),
          IconButton(
            icon: Icon(Icons.person_outline),
            onPressed: () {
              // profil
            },
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          // search
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(paddingHorizontal),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.11),
                      blurRadius: 40,
                      spreadRadius: 0.0,
                    ),
                  ],
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search shoes',
                    prefixIcon: Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.symmetric(
                        vertical: 0.0, horizontal: paddingHorizontal),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(screenWidth * 0.05),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ),
          ),
          // lista kontenerow na buty
          // https://api.flutter.dev/flutter/widgets/SliverToBoxAdapter-class.html
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final shoe = shoes[index];
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: paddingHorizontal,
                    vertical: paddingVertical,
                  ),
                  child: Container(
                    height: containerHeight,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(screenWidth * 0.05),
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
                                padding: EdgeInsets.all(paddingHorizontal),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      shoe['name'],
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: screenWidth * 0.055,
                                      ),
                                    ),
                                    SizedBox(height: screenHeight * 0.01),
                                    Text(
                                      shoe['price'],
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: screenWidth * 0.05,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: imageWidth,
                              child: Padding(
                                padding:
                                    EdgeInsets.only(right: paddingHorizontal),
                                child: Image.asset(
                                  shoe['image'],
                                  width: imageWidth,
                                  height: imageHeight,
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
                            onTap: () {
                              // tu pozniej dodac route do cart screen
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                bottomRight:
                                    Radius.circular(screenWidth * 0.05),
                                topLeft: Radius.circular(screenWidth * 0.05),
                              ),
                              child: SizedBox(
                                width: buttonSize,
                                height: buttonSize,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(color: Colors.blue),
                                  child: Icon(
                                    Icons.add_shopping_cart,
                                    color: Colors.white,
                                    size: buttonSize * 0.6,
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
              },
              childCount: shoes.length,
            ),
          ),
        ],
      ),
    );
  }
}
