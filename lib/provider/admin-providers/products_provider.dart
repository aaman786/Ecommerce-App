import 'package:flutter/material.dart';
import '../../models/product_model.dart';
import '../../features/admin/services/admin_services.dart';

class ProductsProvider extends ChangeNotifier {
  List<ProductModel>? product;

  void fetchAllProducts(BuildContext context) async {
    final AdminServices adminServices = AdminServices();
    product = await adminServices.fetchAllProduct(context);
    notifyListeners();
  }
}
