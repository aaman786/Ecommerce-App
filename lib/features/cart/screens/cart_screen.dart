import 'package:amazone_clone/common/widgets/custom_button.dart';
import 'package:amazone_clone/features/address/screens/address_screen.dart';
import 'package:amazone_clone/features/cart/widgets/cart_product.dart';
import 'package:amazone_clone/features/cart/widgets/sub_total.dart';
import 'package:amazone_clone/features/home/widgets/address_box.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../constants/global_variables.dart';
import '../../../provider/user_provider.dart';
import '../../search/screens/search_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  
  void navigateToAddress(int sum) {
    Navigator.pushNamed(context, AddressScreen.routeName,
        arguments: sum.toString());
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    int sum = 0;
    user.cart
        .map((e) => sum += e['quantity'] * e['product']['price'] as int)
        .toList();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(gradient: GlobalVariables.appBarGradient),
          ),
          title: Row(children: [
            Expanded(
              child: Container(
                  height: 42,
                  margin: const EdgeInsets.only(left: 15),
                  child: Material(
                    borderRadius: BorderRadius.circular(15),
                    elevation: 01,
                    child: TextFormField(
                      onFieldSubmitted: (query) {
                        Navigator.pushNamed(context, SearchScreen.routeName,
                            arguments: query);
                      },
                      decoration: InputDecoration(
                          prefixIcon: InkWell(
                            onTap: () {},
                            child: const Padding(
                              padding: EdgeInsets.only(left: 6),
                              child: Icon(
                                Icons.search,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          filled: true,
                          contentPadding: const EdgeInsets.only(top: 10),
                          border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(07),
                              ),
                              borderSide: BorderSide.none),
                          enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(07),
                            ),
                            borderSide:
                                BorderSide(color: Colors.black38, width: 01),
                          ),
                          hintText: "Search Amazon.in",
                          hintStyle: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 17)),
                    ),
                  )),
            ),
            Container(
              color: Colors.transparent,
              height: 42,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: const Icon(
                Icons.mic,
                color: Colors.black,
                size: 25,
              ),
            )
          ]),
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          const AddressBox(),
          const SubTotal(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomButton(
                onPressed: () => navigateToAddress(sum),
                color: Colors.yellow[800],
                text: "Proceed to Buy (${user.cart.length}) items"),
          ),
          GlobalVariables.kSizedBoxOfHeight30,
          Container(
            color: Colors.black12.withOpacity(0.08),
            height: 1,
          ),
          GlobalVariables.kSizedBoxOfHeight05,
          ListView.builder(
              shrinkWrap: true,
              itemCount: user.cart.length,
              itemBuilder: (context, index) {
                return CartProduct(index: index);
              })
        ],
      )),
    );
  }
}
