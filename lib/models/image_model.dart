import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ImagesModel {
  final String imageUrl;
  final String publicId;

  ImagesModel({
    required this.imageUrl,
    required this.publicId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'imageUrl': imageUrl,
      'publicId': publicId,
    };
  }

  factory ImagesModel.fromMap(Map<String, dynamic> map) {
    return ImagesModel(
      imageUrl: map['imageUrl'] ?? '',
      publicId: map['publicId'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ImagesModel.fromJson(String source) =>
      ImagesModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
