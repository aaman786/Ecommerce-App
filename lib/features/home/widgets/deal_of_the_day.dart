import 'package:amazone_clone/common/widgets/custom_loading_indicator.dart';
import 'package:amazone_clone/features/home/services/home_services.dart';
import 'package:amazone_clone/features/product%20details/screens/product_details_screen.dart';
import 'package:flutter/material.dart';

import '../../../models/product_model.dart';

class DealOfTheDay extends StatefulWidget {
  const DealOfTheDay({Key? key}) : super(key: key);

  @override
  State<DealOfTheDay> createState() => _DealOfTheDayState();
}

class _DealOfTheDayState extends State<DealOfTheDay> {
  ProductModel? product;

  @override
  void initState() {
    super.initState();
    fetchDealOfTheDay();
  }

  void fetchDealOfTheDay() async {
    final HomeServices homeServices = HomeServices();
    product = await homeServices.fetchDealofTheDay(context: context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return product == null
        ? const CustomLoadingIndicator()
        : GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, ProductDetailsScreen.routeName,
                  arguments: product);
            },
            child: Column(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.only(left: 10, top: 10),
                  child: const Text(
                    "Deal Of The Day",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Image.network(
                  product!.images[0],
                  height: 235,
                  fit: BoxFit.fitHeight,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 15),
                  alignment: Alignment.topLeft,
                  child: Text(
                    "\$${product!.price}",
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.only(left: 15, top: 5, right: 40),
                  child: const Text('Aaman ',
                      maxLines: 2, overflow: TextOverflow.ellipsis),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: product!.images
                        .map(
                          (e) => Image.network(
                            e,
                            fit: BoxFit.fitWidth,
                            width: 100,
                            height: 100,
                          ),
                        )
                        .toList(),
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.symmetric(vertical: 15)
                      .copyWith(left: 15),
                  child: Text(
                    "See all deals",
                    style: TextStyle(color: Colors.cyan[800]),
                  ),
                ),
              ],
            ),
          );
  }
}
