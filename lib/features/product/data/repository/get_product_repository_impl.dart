import 'package:mini_ecommerce_app_assignment/core/utils/typedef.dart';
import 'package:mini_ecommerce_app_assignment/features/product/data/datasource/product_remote_datasource.dart';
import 'package:mini_ecommerce_app_assignment/features/product/domain/entities/product_entity.dart';
import 'package:mini_ecommerce_app_assignment/features/product/domain/repository/get_product_repository.dart';

class GetProductsRepositoryImpl implements GetProductRepository {
  const GetProductsRepositoryImpl({required this.productRemoteDataSource});

  final ProductRemoteDataSource productRemoteDataSource;

  @override
  ResultFuture<ProductResponseEntity> getProducts() =>
      productRemoteDataSource.getProducts();
}
