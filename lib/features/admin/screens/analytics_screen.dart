import 'package:amazone_clone/common/widgets/custom_loading_indicator.dart';
import 'package:amazone_clone/features/admin/model/sales_model.dart';
import 'package:amazone_clone/features/admin/services/admin_services.dart';
import 'package:amazone_clone/widgets/category_product_chart.dart';
import 'package:charts_flutter_new/flutter.dart' as chart;
import 'package:flutter/material.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({Key? key}) : super(key: key);

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  final AdminServices adminServices = AdminServices();
  int? totalSales;
  List<SalesModel>? earning;

  @override
  Widget build(BuildContext context) {
    return earning == null || totalSales == null
        ? const CustomLoadingIndicator()
        : Column(
            children: [
              Text(
                "\$$totalSales",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 250,
                child: CategoryProductCharts(seriesList: [
                  chart.Series(
                    id: "sales",
                    data: earning!,
                    domainFn: (SalesModel sales, _) => sales.label,
                    measureFn: (SalesModel sales, _) => sales.earning,
                  )
                ]),
              )
            ],
          );
  }
}
