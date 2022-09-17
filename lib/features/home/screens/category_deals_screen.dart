// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:amazone_clone/common/widgets/custom_loading_indicator.dart';
import 'package:amazone_clone/features/product%20details/screens/product_details.dart';
import 'package:flutter/material.dart';

import '../../../constants/global_variables.dart';
import '../../admin/models/product_model.dart';
import '../services/home_services.dart';

class CategoryDealsScreen extends StatefulWidget {
  static const String routeName = "/CategoryDealsScreen";

  final String categoryName;
  const CategoryDealsScreen({
    Key? key,
    required this.categoryName,
  }) : super(key: key);

  @override
  State<CategoryDealsScreen> createState() => _CategoryDealsScreenState();
}

class _CategoryDealsScreenState extends State<CategoryDealsScreen> {
  List<ProductModel>? productList;

  @override
  void initState() {
    super.initState();
    fetchCategoryProduct();
  }

  Future<void> fetchCategoryProduct() async {
    final HomeServices homeServices = HomeServices();
    productList = await homeServices.fetchCategoryProducts(
        context: context, categoryName: widget.categoryName);
    setState(() {});
  }

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
          title: Text(
            widget.categoryName,
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: productList == null
          ? const CustomLoadingIndicator()
          : Column(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Text(
                    'Keep Shopping for ${widget.categoryName}',
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: 170,
                  child: GridView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.only(left: 15),
                    itemCount: productList!.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      // childAspectRatio: 1.4,
                      // mainAxisSpacing: 10,
                    ),
                    itemBuilder: (context, index) {
                      final productData = productList![index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, ProductDetailsScreen.routeName,arguments: productData);
                        },
                        child: Column(children: [
                          SizedBox(
                            height: 130,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.black12, width: 0.5),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Image.network(productData.images[0]),
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            padding: const EdgeInsets.only(
                                left: 0, top: 5, right: 15),
                            child: Text(
                              productData.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(),
                            ),
                          ),
                        ]),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
