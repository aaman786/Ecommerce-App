import 'package:amazone_clone/constants/global_variables.dart';
import 'package:amazone_clone/features/account/widgets/below_appbar.dart';
import 'package:amazone_clone/features/account/widgets/orders.dart';
import 'package:amazone_clone/features/account/widgets/top_buttons.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(gradient: GlobalVariables.appBarGradient),
          ),
          title:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container(
              alignment: Alignment.topLeft,
              child: Image.asset(
                'assets/images/amazon_in.png',
                width: 120,
                height: 45,
                color: Colors.black,
              ),
            ),
            Row(children: [
              Container(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: const Icon(Icons.notifications_outlined)),
              Container(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: const Icon(Icons.search_outlined)),
            ])
          ]),
        ),
      ),
      body: Column(
        children: const [
          BelowAppbar(),
          GlobalVariables.kSizedBoxOfHeight10,
          TopButtons(),
          GlobalVariables.kSizedBoxOfHeight10,
          Orders()
        ],
      ),
    );
  }
}

