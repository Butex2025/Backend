import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:frontend/data/model/cart.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(const CartInit());

  Future<List<CartModel>> loadCart() async {
    final SharedPreferences db = await SharedPreferences.getInstance();

    final List<String> savedItems = db.getStringList('items') ?? [];

    if (savedItems.isEmpty) {
      return [];
    }

    final List<CartModel> items = savedItems
        .map(
          (item) => CartModel.fromJson(jsonDecode(item)),
        )
        .toList();
    return items;
  }

  Future<void> loadCart2() async {
    final SharedPreferences db = await SharedPreferences.getInstance();

    final List<String> savedItems = db.getStringList('items') ?? [];

    if (savedItems.isEmpty) {
      return;
    }

    final List<CartModel> items = savedItems
        .map(
          (item) => CartModel.fromJson(jsonDecode(item)),
        )
        .toList();
    emit(CartList(items));
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

  Future<void> removeFromCart(String name) async {
    final SharedPreferences db = await SharedPreferences.getInstance();

    final List<String> savedItems = db.getStringList('items') ?? [];

    if (savedItems.isEmpty) {
      //error
      return;
    }

    final List<CartModel> items = savedItems
        .map(
          (item) => CartModel.fromJson(jsonDecode(item)),
        )
        .toList();

    for (var i = 0; i < items.length; i++) {
      if (items[i].name == name) {
        items.remove(items[i]);
      }
    }

    List<String> readyToSave = items
        .map(
          (item) => jsonEncode(item.toJson()),
        )
        .toList();

    db.setStringList('items', readyToSave);
    emit(CartList(items));
    return;
  }

  Future<void> clearCart() async {
    final SharedPreferences db = await SharedPreferences.getInstance();
    db.clear();
  }

  // Future<void> sendCart() {

  // }

  Future<void> editItem(CartModel item) async {
    final SharedPreferences db = await SharedPreferences.getInstance();

    final List<String> savedItems = db.getStringList('items') ?? [];

    if (savedItems.isEmpty) {
      //error
      return;
    }

    final List<CartModel> items = savedItems
        .map(
          (item) => CartModel.fromJson(jsonDecode(item)),
        )
        .toList();

    for (var i = 0; i < items.length; i++) {
      if (items[i].id == item.id) {
        items[i] = CartModel(
            id: item.id,
            count: item.count,
            name: item.name,
            photo: item.photo,
            price: item.price,
            size: item.size);
        break;
      }
    }

    List<String> readyToSave = items
        .map(
          (item) => jsonEncode(item.toJson()),
        )
        .toList();

    db.setStringList('items', readyToSave);
    return;
  }
}
