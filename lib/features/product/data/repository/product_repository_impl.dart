import 'package:mini_ecommerce_app_assignment/core/utils/typedef.dart';
import 'package:mini_ecommerce_app_assignment/features/product/data/datasource/product_local_datasource.dart';
import 'package:mini_ecommerce_app_assignment/features/product/data/datasource/product_remote_datasource.dart';
import 'package:mini_ecommerce_app_assignment/features/product/domain/entities/product_entity.dart';
import 'package:mini_ecommerce_app_assignment/features/product/domain/repository/product_repository.dart';

class ProductsRepositoryImpl implements ProductRepository {
  const ProductsRepositoryImpl({
    required this.productRemoteDataSource,
    required this.productLocalDataSource,
  });

  final ProductRemoteDataSource productRemoteDataSource;
  final ProductLocalDataSource productLocalDataSource;

  @override
  ResultFuture<ProductResponseEntity> getProducts() =>
      productRemoteDataSource.getProducts();

  @override
  ResultVoid addToWishLists(ProductEntity entity) =>
      productLocalDataSource.addToWishList(entity);

  @override
  ResultFuture<List<ProductEntity?>> getCartList() =>
      productLocalDataSource.getCartList();

  @override
  ResultVoid deleteCartItem(ProductEntity entity) =>
      productLocalDataSource.deleteCartItem(entity);

  @override
  ResultVoid addToCart(ProductEntity entity) =>
      productLocalDataSource.addToCart(entity);

  @override
  ResultVoid deleteWishList(ProductEntity entity) =>
      productLocalDataSource.deleteWishList(entity);

  @override
  ResultFuture<List<ProductEntity?>> getWishList() =>
      productLocalDataSource.getWishList();

  @override
  ResultVoid updateCartItem(ProductEntity entity) =>
      productLocalDataSource.updateCartItem(entity);
}
