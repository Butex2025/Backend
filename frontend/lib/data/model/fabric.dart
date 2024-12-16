class ProductFabricModel {
  final int id;
  final String fabric;

  ProductFabricModel({required this.id, required this.fabric});

  factory ProductFabricModel.fromJson(Map<String, dynamic> json) =>
     ProductFabricModel(
      id: json['id'],
      fabric: json['fabric'],
    );
  

  Map<String, dynamic> toJson() => {
        'id': id,
        'fabric': fabric,
      };
}
