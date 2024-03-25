import 'package:mini_ecommerce_app_assignment/core/usecase/usecase.dart';
import 'package:mini_ecommerce_app_assignment/core/utils/typedef.dart';
import 'package:mini_ecommerce_app_assignment/features/product/domain/entities/product_entity.dart';
import 'package:mini_ecommerce_app_assignment/features/product/domain/repository/product_repository.dart';

class AddToCartUsecase implements UseCaseWithParams<void, ProductEntity> {
  const AddToCartUsecase({required this.productRepository});
  final ProductRepository productRepository;

  @override
  ResultFuture<void> call(ProductEntity params) =>
      productRepository.addToCart(params);
}
