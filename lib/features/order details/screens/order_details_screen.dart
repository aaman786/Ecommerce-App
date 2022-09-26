// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:amazone_clone/common/widgets/custom_button.dart';
import 'package:amazone_clone/constants/global_variables.dart';
import 'package:amazone_clone/features/admin/services/admin_services.dart';
import 'package:amazone_clone/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:amazone_clone/models/order_model.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class OrderDetailsScreens extends StatefulWidget {
  static const String routeName = "/odered-details";
  final OrderModel order;
  const OrderDetailsScreens({
    Key? key,
    required this.order,
  }) : super(key: key);

  @override
  State<OrderDetailsScreens> createState() => _OrdeDdetailsStateScreens();
}

class _OrdeDdetailsStateScreens extends State<OrderDetailsScreens> {
  int currentStep = 0;

  @override
  void initState() {
    super.initState();
    currentStep = widget.order.status;
  }

// !!! only for the admin
  void changeOrderStatus(int status) {
    final AdminServices adminServices = AdminServices();
    adminServices.changeOrderStatus(
        context: context,
        status: status,
        order: widget.order,
        onSucess: () {
          setState(() {
            currentStep += 1;
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: AppBar(title: const Text("Your Orders")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Text(
              'View order details',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(color: Colors.black12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      'Order Date:          ${DateFormat().format(DateTime.fromMillisecondsSinceEpoch(widget.order.orderedAt))}'),
                  Text('Order ID:              ${widget.order.id}'),
                  Text('Order Total:         \$${widget.order.total}')
                ],
              ),
            ),
            GlobalVariables.kSizedBoxOfHeight10,
            const Text(
              'Purchase details',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Container(
              decoration: const BoxDecoration(color: Colors.black12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  for (int i = 0; i < widget.order.products.length; i++)
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(9.0),
                          child: Image.network(
                            // widget.order.products[i].images[0],
                            widget.order.products[i].image[0].imageUrl,
                            height: 110,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.order.products[i].name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                                maxLines: 2,
                              ),
                              Text(widget.order.quantity[i].toString()),
                            ],
                          ),
                        )
                      ],
                    ),
                ],
              ),
            ),
            GlobalVariables.kSizedBoxOfHeight10,
            const Text(
              'View order details',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Container(
              decoration: const BoxDecoration(color: Colors.black12),
              child: Stepper(
                currentStep: currentStep,
                controlsBuilder: (context, details) {
                  if (user.type == 'admin') {
                    return CustomButton(
                        onPressed: () => changeOrderStatus(details.currentStep),
                        text: 'Done');
                  }
                  return const SizedBox();
                },
                steps: [
                  Step(
                    title: const Text('Pending'),
                    content: const Text('Your oerder yet to be delivered'),
                    isActive: currentStep > 0,
                    state: currentStep > 0
                        ? StepState.complete
                        : StepState.indexed,
                  ),
                  Step(
                    title: const Text('Delivered'),
                    content: const Text(
                        'Your order id deivered and verfified by you'),
                    isActive: currentStep > 1,
                    state: currentStep > 1
                        ? StepState.complete
                        : StepState.indexed,
                  ),
                  Step(
                    title: const Text('Delivered'),
                    content: const Text('Your order has been picked by you'),
                    isActive: currentStep >= 2,
                    state: currentStep >= 2
                        ? StepState.complete
                        : StepState.indexed,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
