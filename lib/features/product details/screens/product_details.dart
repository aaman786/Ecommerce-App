import 'package:amazone_clone/common/widgets/custom_button.dart';
import 'package:amazone_clone/common/widgets/star.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:amazone_clone/features/admin/models/product_model.dart';
import '../../../constants/global_variables.dart';
import '../../search/screens/search_screen.dart';

class ProductDetailsScreen extends StatefulWidget {
  static const String routeName = "/productDetailScreen";
  final ProductModel product;
  const ProductDetailsScreen({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.product.id!),
                const Star(ratting: 04),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Text(
              widget.product.name,
              style: const TextStyle(fontSize: 15),
            ),
          ),
          CarouselSlider(
            items: widget.product.images
                .map((e) => Builder(
                    builder: (BuildContext context) => Image.network(
                          e,
                          fit: BoxFit.cover,
                          height: 200,
                        )))
                .toList(),
            options: CarouselOptions(viewportFraction: 1, height: 300),
          ),
          Container(
            height: 05,
            color: Colors.black12,
          ),
          Padding(
            padding: const EdgeInsets.all(08),
            child: RichText(
              text: TextSpan(
                text: "Deal Price",
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black),
                children: [
                  TextSpan(
                    text: "\$${widget.product.price}",
                    style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 22,
                        color: Colors.red),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.product.description,
            ),
          ),
          Container(
            height: 05,
            color: Colors.black12,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: CustomButton(onPressed: () {}, text: "Buy Now"),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: CustomButton(
              onPressed: () {},
              text: "Add To Cart",
              color: const Color.fromRGBO(254, 216, 19, 1),
              textColor: Colors.black,
            ),
          ),
        ],
      )),
    );
  }
}
