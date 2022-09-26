import 'package:amazone_clone/common/widgets/custom_loading_indicator.dart';
import 'package:amazone_clone/features/account/widgets/single_product.dart';
import 'package:amazone_clone/features/admin/services/admin_services.dart';
import 'package:amazone_clone/features/order%20details/screens/order_details_screen.dart';
import 'package:amazone_clone/models/order_model.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  List<OrderModel>? orders;
  final AdminServices adminServices = AdminServices();

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  void fetchOrders() async {
    orders = await adminServices.fetchAllOrders(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return orders == null
        ? const CustomLoadingIndicator()
        : GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 02),
            itemCount: orders!.length,
            itemBuilder: (context, index) {
              final orderData = orders![index];
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, OrderDetailsScreens.routeName,
                      arguments: orderData);
                },
                child: SizedBox(
                  height: 140,
                  child: SingleProduct(
                    // image: orderData.products[0].image[0],
                    image: orderData.products[0].image[0].imageUrl,
                  ),
                ),
              );
            },
          );
  }
}
