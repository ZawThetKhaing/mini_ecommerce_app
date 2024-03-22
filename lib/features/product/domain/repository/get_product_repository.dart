import 'package:mini_ecommerce_app_assignment/core/utils/typedef.dart';
import 'package:mini_ecommerce_app_assignment/features/product/domain/entities/product_entity.dart';

abstract class GetProductRepository {
  ResultFuture<ProductResponseEntity> getProducts();
}
