import 'package:apple_market/data/model/product.dart';
import 'package:csv/csv.dart';
import 'package:flutter/services.dart';

class ProductRepository {

  Future<List<Product>> loadCsvData() async {
    final csvString =
        await rootBundle.loadString('assets/data/sample_data.csv');
    List<List<dynamic>> csvTable =
        const CsvToListConverter().convert(csvString, eol: '\n');

    // 헤더 제외 후 파싱
    return csvTable.skip(2).map((row) => Product.fromCsv(row)).toList();
  }

}
