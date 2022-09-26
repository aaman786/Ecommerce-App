import 'package:amazone_clone/common/widgets/custom_loading_indicator.dart';
import 'package:amazone_clone/features/account/widgets/single_product.dart';
import 'package:amazone_clone/features/admin/add%20product/screens/add_product_screen.dart';
import 'package:amazone_clone/models/product_model.dart';
import 'package:amazone_clone/features/admin/services/admin_services.dart';
import 'package:amazone_clone/provider/admin-providers/products_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  // List<ProductModel>? product;

  // @override
  // void initState() {
  //   super.initState();
  // fetchAllProducts();
  //
  // }

  void fetchProducts() {
    Provider.of<ProductsProvider>(context).fetchAllProducts(context);
  }

  void deleteProduct(ProductModel productModel, int index) {
    final AdminServices adminServices = AdminServices();
    adminServices.deleteProduct(
        context: context,
        productModel: productModel,
        onSuccess: () {
          Provider.of<ProductsProvider>(context, listen: false)
              .product!
              .removeAt(index);
        });
  }

  @override
  void didChangeDependencies() {
    fetchProducts();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<ProductsProvider>(context).product;
    return product == null
        ? const CustomLoadingIndicator()
        : Scaffold(
            body: product.isEmpty
                ? const Center(
                    child: Text("Yet there is no product."),
                  )
                : GridView.builder(
                    itemCount: product.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                    itemBuilder: (context, index) {
                      final productData = product[index];
                      return Column(
                        children: [
                          SizedBox(
                            height: 140,
                            child: SingleProduct(
                              // image: productData.images[0],
                              image: productData.image[0].imageUrl,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                child: Text(
                                  productData.name,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    deleteProduct(productData, index);
                                  },
                                  icon: const Icon(Icons.delete_outline))
                            ],
                          )
                        ],
                      );
                    }),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, AddProductScreen.routeName);
              },
              tooltip: "Add Product",
              child: const Icon(Icons.add),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
