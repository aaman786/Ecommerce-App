import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../../../constants/error_handling.dart';
import '../../../constants/global_variables.dart';
import '../../../constants/utils.dart';
import '../../../provider/user_provider.dart';
import '../../../models/product_model.dart';
import 'package:http/http.dart' as http;

class HomeServices {
  Future<List<ProductModel>> fetchCategoryProducts(
      {required BuildContext context, required String categoryName}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<ProductModel> productList = [];
    try {
      http.Response response = await http.get(
        Uri.parse("$uri/api/products?category=$categoryName"),
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

  Future<ProductModel> fetchDealofTheDay(
      {required BuildContext context}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    ProductModel product = ProductModel(
        name: '',
        description: '',
        quantity: 0.0,
        price: 0.0,
        image: [],
        category: '');
    try {
      http.Response response = await http.get(
        Uri.parse("$uri/api/deal-of-the-day"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );
      httpErrorHandling(
          response: response,
          context: context,
          onSuccess: () {
            product = ProductModel.fromJson(response.body);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return product;
  }
}
