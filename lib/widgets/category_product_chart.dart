// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:charts_flutter_new/flutter.dart' as chart;
import 'package:flutter/material.dart';

import 'package:amazone_clone/features/admin/model/sales_model.dart';

class CategoryProductCharts extends StatelessWidget {
  final List<chart.Series<SalesModel, String>> seriesList;
  const CategoryProductCharts({
    Key? key,
    required this.seriesList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return chart.BarChart(
      seriesList,
      animate: true,
    );
  }
}
