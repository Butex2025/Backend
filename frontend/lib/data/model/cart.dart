class CartModel {
  final int id;
  final double size;
  final double price;
  final String name;
  final int count;
  final String photo;

  CartModel({
    required this.id,
    required this.count,
    required this.name,
    required this.photo,
    required this.price,
    required this.size,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        id: json['id'],
        count: json['count'],
        name: json['name'],
        photo: json['pohot'],
        price: json['price'],
        size: json['size'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'count': count,
        'name': name,
        'photo': photo,
        'price': price,
        'size': size,
      };
}
