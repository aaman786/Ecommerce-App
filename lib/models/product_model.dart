import 'dart:convert';
import 'package:amazone_clone/models/image_model.dart';
import 'package:amazone_clone/models/ratings_model.dart';

class ProductModel {
  final String name;
  final String description;
  final double quantity;
  final double price;
  // final List<String> images;
  final List<ImagesModel> image;
  final String category;
  final String? id;
  final List<Ratings>? rating;
  // final String? userId;

  ProductModel({
    required this.name,
    required this.description,
    required this.quantity,
    required this.price,
    // required this.images,
    required this.image,
    required this.category,
    this.id,
    this.rating,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'description': description,
      'quantity': quantity,
      'price': price,
      // 'images': images,
      'images': image.map((e) => jsonDecode(e.toJson())).toList(),
      'category': category,
      'id': id,
      'rating': rating
      // 'userId': userId,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      quantity: map['quantity']?.toDouble() ?? '0.0',
      price: map['price']?.toDouble() ?? '0.0',
      // images: List<String>.from(map['images']),
      image: List<ImagesModel>.from(
        map['images']?.map(
          (x) => ImagesModel.fromMap(x),
        ),
      ),
      category: map['category'] ?? '',
      id: map['_id'],
      rating: map['ratings'] != null
          ? List<Ratings>.from(
              map['ratings']?.map(
                (x) => Ratings.fromMap(x),
              ),
            )
          : null,
      // userId: map['userId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
