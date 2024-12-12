import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:frontend/data/model/adress.dart';
import 'package:frontend/data/model/cart.dart';
import 'package:frontend/data/model/order.dart';
import 'package:frontend/data/model/product_in_order.dart';
import 'package:frontend/pages/logic/secure_storage_manager.dart';
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
    double fullPrice = 0;

    final List<String> savedItems = db.getStringList('items') ?? [];

    if (savedItems.isEmpty) {
      emit(const CartList([], 0));
    }

    final List<CartModel> items = savedItems
        .map(
          (item) => CartModel.fromJson(jsonDecode(item)),
        )
        .toList();

    for (var i = 0; i < items.length; i++) {
      fullPrice = fullPrice + items[i].price * items[i].count;
    }
    fullPrice = fullPrice.roundToDouble();

    emit(CartList(items, fullPrice));
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
    double fullPrice = 0;
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

    for (var i = 0; i < items.length; i++) {
      fullPrice = fullPrice + items[i].price * items[i].count;
    }
    fullPrice = fullPrice.roundToDouble();

    emit(CartList(items, fullPrice));
    return;
  }

  Future<void> clearCart() async {
    final SharedPreferences db = await SharedPreferences.getInstance();
    db.clear();
  }

  Future<void> editItem(int id, bool addItem) async {
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

    for (var i = 0; i < items.length; i++) {
      if (items[i].id == id) {
        int newCount = items[i].count;
        if (addItem) {
          newCount = newCount + 1;

          items[i] = CartModel(
              id: items[i].id,
              count: newCount,
              name: items[i].name,
              photo: items[i].photo,
              price: items[i].price,
              size: items[i].size);
        } else {
          if (newCount == 1) {
            items.removeAt(i);
          } else {
            newCount = newCount - 1;
            items[i] = CartModel(
                id: items[i].id,
                count: newCount,
                name: items[i].name,
                photo: items[i].photo,
                price: items[i].price,
                size: items[i].size);
          }
        }

        break;
      }
    }

    List<String> readyToSave = items
        .map(
          (item) => jsonEncode(item.toJson()),
        )
        .toList();

    db.setStringList('items', readyToSave);
    double fullPrice = 0;
    for (var i = 0; i < items.length; i++) {
      fullPrice = fullPrice + items[i].price * items[i].count;
    }
    fullPrice = fullPrice.roundToDouble();
    emit(CartList(items, fullPrice));
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
            onTap: () => saveShopId(shop['id'].toString()),
          ),
        );
      }
      Set<Marker> list2 = list.toSet();
      emit(CartMap(list2));
    } else {
      throw Exception('You Failed');
    }
  }

  void saveShopId(String id) async {
    final SharedPreferences db = await SharedPreferences.getInstance();
    db.setString('shopId', id);
  }

  Future<void> placeOrder(
    String name,
    String email,
    bool isPickup,
  ) async {
    final SharedPreferences db = await SharedPreferences.getInstance();
    final String? shopId = db.getString('shopId');
    String service = 'INPOST';
    double fullPrice = 0;

    final List<String> savedItems = db.getStringList('items') ?? [];

    if (savedItems.isEmpty) {
      emit(const CartList([], 0));
    }

    final List<CartModel> items = savedItems
        .map(
          (item) => CartModel.fromJson(jsonDecode(item)),
        )
        .toList();
    String phone = "123456789";
    for (var i = 0; i < items.length; i++) {
      fullPrice = fullPrice + items[i].price * items[i].count;
    }
    fullPrice = fullPrice.roundToDouble();

    final storageManager = SecureStorageManager.instance;

    String? postCode = await storageManager.read('postal_code');
    String? city = await storageManager.read('city');
    String? street = await storageManager.read('street');

    final fetchedBuildingNumber = await storageManager.read('building_number');

    final fullAddress = '$street $fetchedBuildingNumber';

    final adress = OrderAddress(
      street: fullAddress,
      postcode: postCode!,
      city: city!,
    );

    List<Product> orderProducts = [];
    for (var e in items) {
      orderProducts.add(
        Product(productId: e.id, quantity: e.count),
      );
    }

    OrderModel order;

    if (isPickup) {
      order = OrderModel(
        products: orderProducts,
        shopId: shopId!,
        orderAddress: null,
        name: name,
        email: email,
        phoneNumber: phone,
        service: service,
        finalPrice: fullPrice + 50,
      );
    } else {
      order = OrderModel(
        products: orderProducts,
        shopId: null,
        orderAddress: adress,
        name: name,
        email: email,
        phoneNumber: phone,
        service: service,
        finalPrice: fullPrice + 50,
      );
    }

    const String url = 'https://butex.onrender.com/api/v1/order';
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'accept': '*/*',
        },
        body: jsonEncode({
          "products": order.products,
          "shopId": null,
          "orderAddress": {
            "street": "Przykładowa 6",
            "postcode": "95-100",
            "city": "Zgierz",
          },
          "name": "Tomek wlodek",
          "email": "test@test.pl",
          "phoneNumber": "603338899",
          "service": "INPOST",
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Order placed successfully: ${response.body}');
      } else {
        print('Failed to place order: ${response.statusCode}');
      }

      final data = json.decode(response.body);

      final id = data["id"];

      final String apiUrl =
          'https://butex.onrender.com/api/v1/payment?orderId=$id';

      try {
        final response = await http.post(
          Uri.parse(apiUrl),
          headers: {
            'accept': '*/*',
            'Content-Type': 'application/json',
          },
          body: '',
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          final data = json.decode(response.body);
          final String link = data["redirectUrl"];

          print('Payment request successful: ${response.body}');
          emit(WebPay(link));
        } else {
          print('Payment request failed: ${response.statusCode}');
        }
      } catch (error) {
        print('Error occurred while sending payment request: $error');
      }
    } catch (e) {
      print('Error sending order: $e');
    }
  }
}
