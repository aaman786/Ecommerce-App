import 'package:amazone_clone/constants/global_variables.dart';
import 'package:amazone_clone/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BelowAppbar extends StatelessWidget {
  const BelowAppbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      decoration: const BoxDecoration(gradient: GlobalVariables.appBarGradient),
      child: Row(
        children: [
          RichText(
            text: TextSpan(
                text: 'Hello',
                style: const TextStyle(fontSize: 22, color: Colors.black),
                children: [
                  TextSpan(
                    text: " ${user.name}",
                    style: const TextStyle(fontSize: 22, color: Colors.black),
                  )
                ]),
          ),
        ],
      ),
    );
  }
}
