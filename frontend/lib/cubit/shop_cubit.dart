import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:frontend/data/model/product.dart';
import 'package:http/http.dart' as http;

part 'shop_state.dart';

class ShopCubit extends Cubit<ShopState> {
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

  Future<void> detailScreen(ProductModel product,List<ProductModel> list ) async {
    emit(MoveToDetailScreen(product,list ));
  }

  Future<void> moveBackToMainScreen(List<ProductModel> list) async {
    emit(MainList(list));
  }
}
