class ProductTypeModel {
  final int id;
  final String type;

  ProductTypeModel({required this.id, required this.type});

  factory ProductTypeModel.fromJson(Map<String, dynamic> json) =>
     ProductTypeModel(
      id: json['id'],
      type: json['type'],
    );
  

  Map<String, dynamic> toJson() =>{
      "id": id,
      "type": type,
    
  };
}
