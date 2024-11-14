import 'package:frontend/data/model/fabric.dart';
import 'package:frontend/data/model/type.dart';

class ProductModel {
  final int id;
  final String name;
  final String brand;
  final double price;
  final String image;
  final ProductFabricModel productFabric;
  final ProductTypeModel productType;

  ProductModel({
    required this.id,
    required this.name,
    required this.brand,
    required this.price,
    required this.image,
    required this.productFabric,
    required this.productType,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => 
   ProductModel(
      id: json['id'],
      name: json['name'],
      brand: json['brand'],
      price: json['price'].toDouble(),
      image: json['image'],
      productFabric: ProductFabricModel.fromJson(json['productFabric']),
      productType: ProductTypeModel.fromJson(json['productType']),
    );
  

  Map<String, dynamic> toJson() => {
     
      'id': id,
      'name': name,
      'brand': brand,
      'price': price,
      'image': image,
      'productFabric': productFabric.toJson(),
      'productType': productType.toJson(),
    
  };
}
