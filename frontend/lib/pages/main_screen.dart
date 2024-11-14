import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/cubit/shop_cubit.dart';
import 'package:frontend/data/model/product.dart';
import 'package:frontend/pages/list_tile.dart';

class MainScreen extends StatefulWidget {
  final List<ProductModel> shopList;
  const MainScreen({
    super.key,
    required this.shopList,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
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
          icon: const Icon(Icons.menu_rounded),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/user_page');
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () {
              // cart
            },
          ),
          IconButton(
            icon: const Icon(Icons.person_outline),
            onPressed: () {
              Navigator.pushNamed(context, '/account_settings');
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
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
                  prefixIcon: const Icon(Icons.search),
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
          Expanded(
            child: ListView.builder(
                itemCount: widget.shopList.length,
                itemBuilder: (context, index) {
                  final item = widget.shopList[index];
                  return GestureDetector(
                    onTap: () => moveToDetailScreen(context,item,widget.shopList),
                    child: ListTileCustom(
                        name: item.name,
                        price: item.price,
                        photo: item.image,
                        paddingHorizontal: paddingHorizontal,
                        screenHeight: screenHeight,
                        screenWidth: screenWidth,
                        paddingVertical: paddingVertical,
                        buttonSize: buttonSize,
                        containerHeight: containerHeight,
                        imageHeight: imageHeight,
                        imageWidth: imageWidth),
                  );
                }),
          )
        ],
      ),
    );
  }
}

moveToDetailScreen(BuildContext context,ProductModel product,List<ProductModel> list) {
  final pokeCubit = BlocProvider.of<ShopCubit>(context);
  pokeCubit.detailScreen(product,list);
}


// CustomScrollView(
//         slivers: [
//           // search
//           SliverToBoxAdapter(
//             child: Padding(
//               padding: EdgeInsets.all(paddingHorizontal),
//               child: DecoratedBox(
//                 decoration: BoxDecoration(
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.11),
//                       blurRadius: 40,
//                       spreadRadius: 0.0,
//                     ),
//                   ],
//                 ),
//                 child: TextField(
//                   decoration: InputDecoration(
//                     hintText: 'Search shoes',
//                     prefixIcon: Icon(Icons.search),
//                     filled: true,
//                     fillColor: Colors.white,
//                     contentPadding: EdgeInsets.symmetric(
//                         vertical: 0.0, horizontal: paddingHorizontal),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(screenWidth * 0.05),
//                       borderSide: BorderSide.none,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           // lista kontenerow na buty
//           // https://api.flutter.dev/flutter/widgets/SliverToBoxAdapter-class.html
//           SliverList(
//             delegate: SliverChildBuilderDelegate(
//               (context, index) {
//                 final shoe = widget.shopList[index];
//                 return ListView.builder(itemCount: pokemonList.length,
//       itemBuilder: (context, index) {
//         final item = pokemonList[index];
//         return BlocProvider(
//           key: Key(item.name),
//           create: (context) => TileCubit(PokeRepository()),
//           child: PokeListTile(pokemon: item),
//         );
//       },)
//               },
//               childCount: widget.shopList.length,
//             ),
//           ),
//         ],
//       ),