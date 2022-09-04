import 'dart:convert';

import 'package:amazone_clone/constants/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

void httpErrorHandling(
    {required Response response,
    required BuildContext context,
    required VoidCallback onSuccess}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;

    case 400:
      showSnackBar(context, jsonDecode(response.body)['msg']);
      break;

    case 500:
      showSnackBar(context, jsonDecode(response.body)['error']);
      break;

    default:
      showSnackBar(context, response.body);
  }
}