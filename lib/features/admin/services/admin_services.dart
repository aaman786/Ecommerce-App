import 'dart:convert';
import 'dart:io';
import 'package:amazone_clone/constants/error_handling.dart';
import 'package:amazone_clone/constants/global_variables.dart';
import 'package:amazone_clone/constants/utils.dart';
import 'package:amazone_clone/features/admin/models/product_model.dart';
import 'package:amazone_clone/provider/user_provider.dart';
import 'package:cloudinary/cloudinary.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AdminServices {
  // ADD A PRODUCT
  Future<void> sellProduct({
    required BuildContext context,
    required String name,
    required String description,
    required String category,
    required double price,
    required double quantity,
    required List<File> images,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      // final cloudinary = CloudinaryPublic("aman0980", "kmatym3q");
      // List<String> imageUrls = [];
      // for (var i = 0; i < images.length; i++) {
      //   CloudinaryResponse cloudinaryResponse = await cloudinary
      //       .uploadFile(CloudinaryFile.fromFile(images[i].path, folder: name));

      //   imageUrls.add(cloudinaryResponse.secureUrl);
      // }

      // final cloudinary = CloudinaryPublic("aman0980", "kmatym3q");


      final cloudy = Cloudinary.unsignedConfig(cloudName: "aman0980");
      List<String> imageUrls = [];
      for (var i = 0; i < images.length; i++) {
        final response = await cloudy.unsignedUpload(
            uploadPreset: "kmatym3q", folder: name, file: images[i].path);

        String url = response.secureUrl!;
        String publicId = response.publicId!;

        imageUrls.add(url);
        // Images imgs = Images(url: url, publicId: publicId);
        // imageUrls.add(imgs);
      }

      ProductModel productModel = ProductModel(
          name: name,
          description: description,
          quantity: quantity,
          price: price,
          images: imageUrls,
          category: category);

      http.Response response =
          await http.post(Uri.parse('$uri/admin/add-product'),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
                'x-auth-token': userProvider.user.token,
              },
              body: productModel.toJson());

      httpErrorHandling(
          response: response,
          context: context,
          onSuccess: () {
            showSnackBar(context, "Product Added Successfully...");
            Navigator.pop(context);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // GET ALL THE PRODUCTS
  Future<List<ProductModel>> fetchAllProduct(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<ProductModel> productList = [];
    try {
      http.Response response = await http.get(
        Uri.parse("$uri/admin/get-products"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );
      httpErrorHandling(
          response: response,
          context: context,
          onSuccess: () {
            for (var i = 0; i < jsonDecode(response.body).length; i++) {
              productList.add(
                ProductModel.fromJson(
                  jsonEncode(jsonDecode(response.body)[i]),
                ),
              );
            }
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return productList;
  }

  // DELETE THE PRODUCT
  void deleteProduct({
    required BuildContext context,
    required ProductModel productModel,
    required VoidCallback onSuccess,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response response = await http.post(
        Uri.parse('$uri/admin/delete-product'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({'id': productModel.id}),
      );

      httpErrorHandling(
          response: response, context: context, onSuccess: onSuccess);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
