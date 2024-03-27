import 'package:flutter/material.dart';
import 'package:mini_ecommerce_app_assignment/features/product/data/models/product_model.dart';
import 'package:mini_ecommerce_app_assignment/features/product/domain/usecaese/add_to_cart_usecase.dart';
import 'package:mini_ecommerce_app_assignment/features/product/domain/usecaese/add_to_wish_list_usecase.dart';
import 'package:mini_ecommerce_app_assignment/features/product/domain/usecaese/delete_cart_item_usecase.dart';
import 'package:mini_ecommerce_app_assignment/features/product/domain/usecaese/delete_wish_list_usecase.dart';
import 'package:mini_ecommerce_app_assignment/features/product/domain/usecaese/get_cart_list_usecase.dart';
import 'package:mini_ecommerce_app_assignment/features/product/domain/usecaese/get_wish_list_usecase.dart';
import 'package:mini_ecommerce_app_assignment/features/product/domain/usecaese/products_usecase.dart';

class ProductsProvider extends ChangeNotifier {
  ProductsProvider({
    required this.getProductsUsecase,
    required this.addToCartUsecase,
    required this.getCartListUsecase,
    required this.deleteCartItemUsecase,
    required this.addToWishListUsecase,
    required this.getWishListUsecase,
    required this.deleteWishListUsecase,
  });

  final GetProductsUsecase getProductsUsecase;

  final AddToCartUsecase addToCartUsecase;

  final GetCartListUsecase getCartListUsecase;

  final DeleteCartItemUsecase deleteCartItemUsecase;

  final AddToWishListUsecase addToWishListUsecase;

  final GetWishListUsecase getWishListUsecase;

  final DeleteWishListUsecase deleteWishListUsecase;

  List<ProductModel>? _allProducts = [];

  List<ProductModel> get allProducts => _allProducts ?? [];

  List<String>? _productCategory = [];

  List<String>? get productCategory => _productCategory;

  List<ProductModel> cartProducts = [];

  List<ProductModel> _wishListProducts = [];

  List<ProductModel>? _filterProducts = [];

  List<ProductModel> get filterProducts => _filterProducts ?? [];

  double priceSliderStartValue = 0;

  double priceSliderEndValue = 1;

  double ratingSliderValue = 0;

  String dropDownValue = '';

  bool isFilterBy = false;

  Object? selectedRadioBtnValue;

  void radioBtnChange(Object? value) {
    selectedRadioBtnValue = value;
    notifyListeners();
  }

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

  double get subTotal {
    if (cartProducts.isEmpty == true) return 0;
    final price = cartProducts.map((e) => double.parse(e.price)).toList();
    double total = 0;
    price.forEach(
      (element) {
        total += element;
      },
    );
    return total;
  }

  double get tax => subTotal * 0.05;

  double get total => subTotal + tax + 50;

  void onDropDownChange(String? value) {
    dropDownValue = value ?? '';
    notifyListeners();
  }

  void onPriceSliderChange(RangeValues value) {
    priceSliderStartValue = value.start;
    priceSliderEndValue = value.end;

    notifyListeners();
  }

  void onRatingSliderChange(double value) {
    ratingSliderValue = value;
    notifyListeners();
  }

  void filterByCategory(String category) {
    isFilterBy = false;
    if (category == "All") {
      notifyListeners();
      return;
    }
    _filterProducts =
        _allProducts?.where((element) => element.category == category).toList();

    notifyListeners();
  }

  void filterProduct() {
    _filterProducts = allProducts.where(
      (element) {
        return element.category == dropDownValue &&
            double.parse(element.rate) >= ratingSliderValue &&
            (double.parse(element.price) >= priceSliderStartValue * 1000 &&
                double.parse(element.price) <= priceSliderEndValue * 1000);
      },
    ).toList();
    isFilterBy = true;
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

  Future<bool> addToCart(ProductModel model) async {
    final result = await addToCartUsecase(model);

    return result.fold((l) => false, (r) => true);
  }

  Future<List<ProductModel>?> getCartProducts() async {
    final result = await getCartListUsecase();

    return result.fold(
      (l) {
        return [];
      },
      (list) {
        cartProducts = list.map((e) => ProductModel.fromEntity(e!)).toList();

        return cartProducts;
      },
    );
  }

  Future<void> deleteCartItem(ProductModel model) async {
    await deleteCartItemUsecase(model);
    notifyListeners();
  }

  Future<bool> addToWishList(ProductModel model) async {
    final result = await addToWishListUsecase(model);

    return result.fold((l) => false, (r) => true);
  }

  Future<List<ProductModel>?> getWishList() async {
    final result = await getWishListUsecase();

    return result.fold(
      (l) {
        return [];
      },
      (list) {
        _wishListProducts =
            list.map((e) => ProductModel.fromEntity(e!)).toList();

        return _wishListProducts;
      },
    );
  }

  Future<void> deleteWishListItem(ProductModel model) async {
    await deleteWishListUsecase(model);
    notifyListeners();
  }
}
