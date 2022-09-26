import 'package:amazone_clone/common/widgets/custom_loading_indicator.dart';
import 'package:amazone_clone/constants/global_variables.dart';
import 'package:amazone_clone/features/account/services/account_servicecs.dart';
import 'package:amazone_clone/features/account/widgets/single_product.dart';
import 'package:amazone_clone/features/order%20details/screens/order_details_screen.dart';
import 'package:amazone_clone/models/order_model.dart';
import 'package:flutter/material.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  List<OrderModel>? orders;

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  void fetchOrders() async {
    final AccountServices accountServices = AccountServices();
    orders = await accountServices.fetchMyOrders(context: context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return orders == null
        ? const CustomLoadingIndicator()
        : Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 15),
                    child: const Text(
                      "Your Orders",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(right: 15),
                    child: Text(
                      "See all",
                      style:
                          TextStyle(color: GlobalVariables.selectedNavBarColor),
                    ),
                  ),
                ],
              ),
              Container(
                height: 170,
                padding: const EdgeInsets.only(left: 10, top: 10),
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: orders!.length,
                    itemBuilder: ((context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, OrderDetailsScreens.routeName,
                              arguments: orders![index]);
                        },
                        child: SingleProduct(
                          // image: orders![index].products[0].images[0],
                          image: orders![index].products[0].image[0].imageUrl,
                        ),
                      );
                    })),
              )
            ],
          );
  }
}
