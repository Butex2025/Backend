import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:frontend/data/model/cart.dart';
import 'package:frontend/data/model/product.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

part 'shop_state.dart';

class ShopCubit extends Cubit<ShopState> {
  Timer? intervalTimer;

  ShopCubit() : super(const ShopInit()) {
    getAllItems();
  }

  Future<void> getAllItems() async {
    emit(const Loading());
    final url = Uri.parse('https://butex.onrender.com/api/v1/product');
    List<ProductModel> items;

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'accept': '*/*',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      items = data.map((item) => ProductModel.fromJson(item)).toList();
      emit(MainList(items));
    } else {
      throw Exception('Failed to add product');
    }
  }

  Future<void> addToCart(CartModel item) async {
    final SharedPreferences db = await SharedPreferences.getInstance();

    final List<String> savedItems = db.getStringList('items') ?? [];

    final List<CartModel> items = savedItems
        .map(
          (item) => CartModel.fromJson(jsonDecode(item)),
        )
        .toList();

    items.add(item);

    List<String> readyToSave = items
        .map(
          (item) => jsonEncode(item.toJson()),
        )
        .toList();

    db.setStringList('items', readyToSave);
    return;
  }

  Future<void> detailScreen(
      ProductModel product, List<ProductModel> list) async {
    emit(MoveToDetailScreen(product, list));
  }

  Future<void> moveBackToMainScreen(List<ProductModel> list) async {
    emit(MainList(list));
  }

  @override
  Future<void> close() {
    intervalTimer?.cancel();
    return super.close();
  }
}
