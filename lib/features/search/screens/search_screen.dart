// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:amazone_clone/common/widgets/custom_loading_indicator.dart';
import 'package:amazone_clone/models/product_model.dart';
import 'package:amazone_clone/features/home/widgets/address_box.dart';
import 'package:amazone_clone/features/product%20details/screens/product_details_screen.dart';
import 'package:amazone_clone/features/search/widget/search_product.dart';
import 'package:flutter/material.dart';
import '../../../constants/global_variables.dart';
import '../services/search_services.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName = "/search-screen";
  final String searchQuery;
  const SearchScreen({
    Key? key,
    required this.searchQuery,
  }) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<ProductModel>? products;

  @override
  void initState() {
    super.initState();
    fetchSearchedProduct();
  }

  Future<void> fetchSearchedProduct() async {
    final SearchService searchService = SearchService();
    products = await searchService.fetchSearchedProduct(
        context: context, searchQuery: widget.searchQuery);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return products == null
        ? const CustomLoadingIndicator()
        : Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(60),
              child: AppBar(
                flexibleSpace: Container(
                  decoration: const BoxDecoration(
                      gradient: GlobalVariables.appBarGradient),
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
                              Navigator.pushNamed(
                                  context, SearchScreen.routeName,
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
                                  borderSide: BorderSide(
                                      color: Colors.black38, width: 01),
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
            body: Column(children: [
              const AddressBox(),
              GlobalVariables.kSizedBoxOfHeight10,
              Expanded(
                child: ListView.builder(
                  itemCount: products!.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, ProductDetailsScreen.routeName,
                              arguments: products![index]);
                        },
                        child: SearchedProduct(product: products![index]));
                  },
                ),
              ),
            ]),
          );
  }
}
