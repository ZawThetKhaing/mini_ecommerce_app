import 'package:flutter/material.dart';
import 'package:mini_ecommerce_app_assignment/features/product/data/models/product_model.dart';
import 'package:mini_ecommerce_app_assignment/features/product/domain/usecaese/get_products_usecase.dart';

class GetProductsProvider extends ChangeNotifier {
  GetProductsProvider({required this.getProductsUsecase});

  final GetProductsUsecase getProductsUsecase;

  List<ProductModel>? _allProducts = [];

  List<ProductModel> get allProducts => _allProducts ?? [];

  List<String>? _productCategory = [];

  List<String>? get productCategory => _productCategory;

  List<ProductModel>? _filterProducts = [];

  List<ProductModel> get filterProducts => _filterProducts ?? [];

  List<ProductModel> search(String? value) {
    if (value == null) return [];
    return allProducts
        .where(
          (element) => element.title.replaceAll(' ', '').toLowerCase().contains(
                value.replaceAll(' ', '').toLowerCase(),
              ),
        )
        .toList();
  }

  void filterByCategory(String category) {
    _filterProducts =
        _allProducts?.where((element) => element.category == category).toList();

    notifyListeners();
  }

  Future<void> fetchAllProducts() async {
    try {
      final result = await getProductsUsecase();

      result.fold(
        (fail) {
          _allProducts = null;
          notifyListeners();
        },
        (entity) {
          _allProducts = entity.products.map(
            (e) {
              return ProductModel.fromEntity(e);
            },
          ).toList();
          _productCategory =
              _allProducts?.map((e) => e.category).toSet().toList();
          notifyListeners();
        },
      );
    } catch (e) {
      _allProducts = null;
      notifyListeners();
    }
  }
}
