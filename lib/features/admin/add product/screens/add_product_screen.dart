import 'dart:io';

import 'package:amazone_clone/common/widgets/custom_button.dart';
import 'package:amazone_clone/common/widgets/custom_textfield.dart';
import 'package:amazone_clone/constants/utils.dart';
import 'package:amazone_clone/features/admin/screens/admin_screen.dart';
import 'package:amazone_clone/features/admin/services/admin_services.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../../../../constants/global_variables.dart';

class AddProductScreen extends StatefulWidget {
  static const String routeName = "/addProduct";
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _productDescriptionController =
      TextEditingController();
  final TextEditingController _productQuantityController =
      TextEditingController();
  final TextEditingController _productPriceController = TextEditingController();

  String category = 'Mobiles';
  List<File> images = [];

  final _addProductFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _productNameController.dispose();
    _productDescriptionController.dispose();
    _productPriceController.dispose();
    _productQuantityController.dispose();
    

    super.dispose();
  }

  List<String> productCategories = [
    'Mobiles',
    'Essentials',
    'Appliances',
    'Books',
    'Fashion',
  ];

  AdminServices adminServices = AdminServices();
  void sellProduct() {
    if (_addProductFormKey.currentState!.validate() && images.isNotEmpty) {
      adminServices.sellProduct(
          context: context,
          name: _productNameController.text,
          description: _productDescriptionController.text,
          category: category,
          price: double.parse(_productPriceController.text),
          quantity: double.parse(_productQuantityController.text),
          images: images);
    }
  }

  void selectImage() async {
    var res = await pickImages();
    setState(() {
      images = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.backgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(gradient: GlobalVariables.appBarGradient),
          ),
          title: const Text(
            "Add Product",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          automaticallyImplyLeading: true,
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _addProductFormKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              children: [
                GlobalVariables.kSizedBoxOfHeight15,
                images.isNotEmpty
                    ? CarouselSlider(
                        items: images
                            .map((e) => Builder(
                                builder: (BuildContext context) => Image.file(
                                      e,
                                      fit: BoxFit.cover,
                                      height: 200,
                                    )))
                            .toList(),
                        options:
                            CarouselOptions(viewportFraction: 1, height: 200),
                      )
                    : GestureDetector(
                        onTap: selectImage,
                        child: DottedBorder(
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(10),
                          dashPattern: const [10, 4],
                          strokeCap: StrokeCap.round,
                          child: Container(
                            width: double.infinity,
                            height: 150,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.folder_open,
                                  size: 40,
                                ),
                                GlobalVariables.kSizedBoxOfHeight10,
                                Text(
                                  "Select Product Images",
                                  style: TextStyle(
                                      color: Colors.grey[400], fontSize: 15),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                GlobalVariables.kSizedBoxOfHeight30,
                CustomTextField(
                    hintLabel: "Product Name",
                    controller: _productNameController),
                GlobalVariables.kSizedBoxOfHeight10,
                CustomTextField(
                    hintLabel: "Product Description",
                    maxLines: 07,
                    controller: _productDescriptionController),
                GlobalVariables.kSizedBoxOfHeight10,
                CustomTextField(
                    hintLabel: "Product Price",
                    controller: _productPriceController),
                GlobalVariables.kSizedBoxOfHeight10,
                CustomTextField(
                    hintLabel: "Product Quantity",
                    controller: _productQuantityController),
                GlobalVariables.kSizedBoxOfHeight10,
                SizedBox(
                  width: double.infinity,
                  child: DropdownButton(
                    value: category,
                    onChanged: (String? newVal) {
                      setState(() {
                        category = newVal!;
                      });
                    },
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: productCategories
                        .map(
                          (String item) =>
                              DropdownMenuItem(value: item, child: Text(item)),
                        )
                        .toList(),
                  ),
                ),
                GlobalVariables.kSizedBoxOfHeight10,
                CustomButton(onPressed: sellProduct, text: "Sell")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
