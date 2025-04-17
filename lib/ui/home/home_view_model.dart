import 'package:apple_market/data/model/product.dart';
import 'package:apple_market/data/repository/product_repository.dart';
import 'package:riverpod/riverpod.dart';

class HomeViewModel extends Notifier<List<Product>>{

  final _productRepository = ProductRepository();
  
  @override
  List<Product> build() {
    fetchData();
    return [];
  }

  Future<void> fetchData() async{
    state = await _productRepository.loadCsvData();
  }

}

final homeViewModel =
    NotifierProvider<HomeViewModel, List<Product>>(() => HomeViewModel());
