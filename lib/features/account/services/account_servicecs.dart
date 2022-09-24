import 'dart:convert';

import 'package:amazone_clone/features/auth/screens/auth_screen.dart';
import 'package:amazone_clone/models/order_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/error_handling.dart';
import '../../../constants/global_variables.dart';
import '../../../constants/utils.dart';
import '../../../provider/user_provider.dart';

class AccountServices {
  Future<List<OrderModel>> fetchMyOrders(
      {required BuildContext context}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<OrderModel> ordersList = [];
    try {
      http.Response response = await http.get(
        Uri.parse("$uri/api/orders/me"),
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
              ordersList.add(
                OrderModel.fromJson(
                  jsonEncode(jsonDecode(response.body)[i]),
                ),
              );
            }
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return ordersList;
  }

  Future<void> logOut(BuildContext context) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      await sharedPreferences.setString('x-auth-token', '');
      Navigator.pushNamedAndRemoveUntil(
          context, AuthScreen.routeName, (route) => false);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
