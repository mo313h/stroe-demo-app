class ProductModel {
  final int id;
  final String title;
  final String description;
  final num price;
  final String thumbnail;

  ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.thumbnail,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    id: json['id'],
    title: json['title'],
    description: json['description'],
    price: json['price'],
    thumbnail: json['thumbnail'],
  );
}
