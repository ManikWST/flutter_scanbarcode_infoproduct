class Product {
  final String name;
  final String description;
  final String price;
  final String image;

  Product({
    required this.name,
    required this.description,
    required this.price,
    required this.image,
  });

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      price: map['price'] ?? '',
      image: map['image'] ?? '',
    );
  }
}
