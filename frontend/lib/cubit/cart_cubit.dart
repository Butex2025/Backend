import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:frontend/data/model/cart.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(const CartInit()) {
    loadCart();
  }

  Future<void> loadCart() async {
    emit(const CartInit());
    final SharedPreferences db = await SharedPreferences.getInstance();

    final List<String> savedItems = db.getStringList('items') ?? [];

    if (savedItems.isEmpty) {
          emit(const CartList([]));

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

  Future<void> getLocationOfShops() async {
    emit(const CartInit());
    List<Marker> list = [];
    final url = Uri.parse('https://butex.onrender.com/api/v1/shop');

    final response = await http.get(
      url,
      headers: {
        'accept': '*/*',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      for (var shop in data) {
        list.add(
          Marker(
            markerId: MarkerId(shop['id'].toString()),
            position: LatLng(shop['latitude'], shop['longitude']),
            infoWindow: InfoWindow(title: shop['name']),
            onTap: () => print('to ja'),
          ),
        );
      }
      Set<Marker> list2 = list.toSet();
      emit(CartMap(list2));
    } else {
      throw Exception('You Failed');
    }
  }
}
