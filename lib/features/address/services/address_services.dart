import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../../constants/error_handling.dart';
import '../../../constants/global_variables.dart';
import '../../../constants/utils.dart';
import '../../../models/user_model.dart';
import '../../../provider/user_provider.dart';

class AddressServices {
  void saveUserAddress({
    required BuildContext context,
    required String address,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response response = await http.post(
        Uri.parse('$uri/api/save-user-address'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'address': address,
        }),
      );

      httpErrorHandling(
          response: response,
          context: context,
          onSuccess: () {
            User user = userProvider.user
                .copyWith(address: jsonDecode(response.body)['address']);
            userProvider.setUserFromModel(user);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void placeOrder(
      {required BuildContext context,
      required String address,
      required double totalsum}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response response = await http.post(Uri.parse("$uri/api/order"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token,
          },
          body: jsonEncode({
            'cart': userProvider.user.cart,
            'address': address,
            'totalPrice': totalsum
          }));

      httpErrorHandling(
          response: response,
          context: context,
          onSuccess: () {
            showSnackBar(context, "Your order has been placed");
            User user = userProvider.user.copyWith(cart: []);
            userProvider.setUserFromModel(user);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
