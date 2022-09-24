import 'dart:convert';

import 'package:amazone_clone/models/product_model.dart';
import 'package:amazone_clone/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../constants/error_handling.dart';
import '../../../constants/global_variables.dart';
import '../../../constants/utils.dart';
import '../../../provider/user_provider.dart';

class CartServices {
  Future<void> removeFromCart({
    required BuildContext context,
    required ProductModel product,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response response = await http.delete(
        Uri.parse('$uri/api/remove-from-cart/${product.id}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      httpErrorHandling(
          response: response,
          context: context,
          onSuccess: () {
            User user = userProvider.user
                .copyWith(cart: jsonDecode(response.body)['cart']);
            userProvider.setUserFromModel(user);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<void> rateProduct({
    required BuildContext context,
    required ProductModel product,
    required double rating,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response response =
          await http.post(Uri.parse('$uri/api/rate-product'),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
                'x-auth-token': userProvider.user.token,
              },
              body: jsonEncode({
                'id': product.id,
                'rating': rating,
              }));

      httpErrorHandling(response: response, context: context, onSuccess: () {});
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
