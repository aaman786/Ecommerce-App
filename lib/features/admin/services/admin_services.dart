import 'dart:convert';
import 'dart:io';
import 'package:amazone_clone/constants/error_handling.dart';
import 'package:amazone_clone/constants/global_variables.dart';
import 'package:amazone_clone/constants/utils.dart';
import 'package:amazone_clone/features/admin/model/sales_model.dart';
import 'package:amazone_clone/models/image_model.dart';
import 'package:amazone_clone/models/order_model.dart';
import 'package:amazone_clone/models/product_model.dart';
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
      final cloudy = Cloudinary.unsignedConfig(cloudName: "aman0980");

      List<ImagesModel> imageUrls = [];

      for (var i = 0; i < images.length; i++) {
        final response = await cloudy.unsignedUpload(
            uploadPreset: "kmatym3q", folder: name, file: images[i].path);

        String url = response.secureUrl!;
        String publicId = response.publicId!;

        ImagesModel imagesModel =
            ImagesModel(imageUrl: url, publicId: publicId);
        imageUrls.add(imagesModel);
      }

      ProductModel productModel = ProductModel(
          name: name,
          description: description,
          quantity: quantity,
          price: price,
          image: imageUrls,
          category: category);

      http.Response response = await http.post(
        Uri.parse('$uri/admin/add-product'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: productModel.toJson(),
      );

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
    final cloudy = Cloudinary.signedConfig(
        apiKey: "291267363297935",
        apiSecret: "qq0VMB9fM-1XIj4_sV4B9Fia72s",
        cloudName: "aman0980");

    try {
      List<ImagesModel> imagedata = productModel.image;
      for (var i = 0; i < imagedata.length; i++) {
        CloudinaryResponse cloudinaryResponse = await cloudy.destroy(
            imagedata[i].publicId.toString(),
            url: imagedata[i].imageUrl,
            invalidate: true);

        print("cloudy response ~~~~~~~ ${cloudinaryResponse}");
      }

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

  Future<List<OrderModel>> fetchAllOrders(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<OrderModel> orderList = [];
    try {
      http.Response response = await http.get(
        Uri.parse("$uri/admin/get-orders"),
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
              orderList.add(
                OrderModel.fromJson(
                  jsonEncode(jsonDecode(response.body)[i]),
                ),
              );
            }
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return orderList;
  }

  Future<void> changeOrderStatus(
      {required BuildContext context,
      required int status,
      required OrderModel order,
      required VoidCallback onSucess}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response response = await http.post(
        Uri.parse("$uri/admin/change-order-status"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({'id': order.id, 'status': status}),
      );
      httpErrorHandling(
        response: response,
        context: context,
        onSuccess: onSucess,
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<Map<String, dynamic>> getEarning(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<SalesModel> sales = [];
    int totalEarinig = 0;
    try {
      http.Response response = await http.get(
        Uri.parse("$uri/admin/analytics"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );
      httpErrorHandling(
          response: response,
          context: context,
          onSuccess: () {
            var res = jsonDecode(response.body);
            totalEarinig = res['totalEarning'];
            sales = [
              SalesModel('Mobiles', res['mobileEarning']),
              SalesModel('Essential', res['esssentialEarning']),
              SalesModel('Appliance', res['appliancsEarning']),
              SalesModel('Book', res['bookEarning']),
            ];
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return {
      'sales': sales,
      'totalEarning': totalEarinig,
    };
  }
}
