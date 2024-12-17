class OrderAddress {
  final String street;
  final String postcode;
  final String city;

  OrderAddress({
    required this.street,
    required this.postcode,
    required this.city,
  });

  factory OrderAddress.fromJson(Map<String, dynamic> json) => OrderAddress(
        street: json['street'],
        postcode: json['postcode'],
        city: json['city'],
      );

  Map<String, dynamic> toJson() => {
        'street': street,
        'postcode': postcode,
        'city': city,
      };
}