import 'package:mini_ecommerce_app_assignment/core/usecase/usecase.dart';
import 'package:mini_ecommerce_app_assignment/core/utils/typedef.dart';
import 'package:mini_ecommerce_app_assignment/features/product/domain/entities/product_entity.dart';
import 'package:mini_ecommerce_app_assignment/features/product/domain/repository/get_product_repository.dart';

class GetProductsUsecase extends UseCaseWithoutParams<ProductResponseEntity> {
  const GetProductsUsecase({required this.getProductRepository});

  final GetProductRepository getProductRepository;

  @override
  ResultFuture<ProductResponseEntity> call() =>
      getProductRepository.getProducts();
}
