// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ProductModel {
  final String name;
  final String description;
  final double quantity;
  final double price;
  final List<String> images;
  final String category;
  final String? id;
  // final String? userId;

  ProductModel({
    required this.name,
    required this.description,
    required this.quantity,
    required this.price,
    required this.images,
    required this.category,
    this.id,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'description': description,
      'quantity': quantity,
      'price': price,
      'images': images,
      'category': category,
      'id': id,
      // 'userId': userId,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {

    return ProductModel(
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      quantity: map['quantity']?.toDouble() ?? '0.0',
      price: map['price']?.toDouble() ?? '0.0',
      images: List<String>.from(map['images']),
      category: map['category'] ?? '',
      id: map['_id'],
      // userId: map['userId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Images {
  String url;
  String publicId;

  Images({
    required this.url,
    required this.publicId,
  });

  factory Images.fromMap(Map<String, dynamic> map) {
    return Images(
      url: map['url'] ?? '',
      publicId: map['publicId'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return <String, String>{
      'url': url,
      'publicId': publicId,
    };
  }

  String toJson() => json.encode(toMap());

  factory Images.fromJson(String source) =>
      Images.fromMap(json.decode(source) as Map<String, dynamic>);
}
