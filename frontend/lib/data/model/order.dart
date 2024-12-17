import 'package:frontend/data/model/adress.dart';
import 'package:frontend/data/model/product_in_order.dart';

class OrderModel {
  final List<Product> products;
  final String? shopId;
  final OrderAddress? orderAddress;
  final String name;
  final String email;
  final String phoneNumber;
  final String service;
  final double finalPrice;

  OrderModel({
    required this.products,
    this.shopId,
    this.orderAddress,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.service,
    required this.finalPrice,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        products: (json['products'] as List)
            .map((item) => Product.fromJson(item))
            .toList(),
        shopId: json['shopId'],
        orderAddress: OrderAddress.fromJson(json['orderAddress']),
        name: json['name'],
        email: json['email'],
        phoneNumber: json['phoneNumber'],
        service: json['service'],
        finalPrice: json['finalPrice'],
      );

  Map<String, dynamic> toJson() => {
        'products': products.map((product) => product.toJson()).toList(),
        'shopId': shopId,
        'orderAddress': orderAddress!.toJson(),
        'name': name,
        'email': email,
        'phoneNumber': phoneNumber,
        'service': service,
        'finalPrice': finalPrice,
      };
}
