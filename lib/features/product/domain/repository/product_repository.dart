import 'package:mini_ecommerce_app_assignment/core/utils/typedef.dart';
import 'package:mini_ecommerce_app_assignment/features/product/domain/entities/product_entity.dart';

abstract class ProductRepository {
  ResultFuture<ProductResponseEntity> getProducts();

  ResultVoid addToCart(ProductEntity entity);

  ResultFuture<List<ProductEntity?>> getCartList();

  ResultVoid deleteCartItem(ProductEntity entity);

  ResultVoid addToWishLists(ProductEntity entity);

  ResultFuture<List<ProductEntity?>> getWishList();

  ResultVoid deleteWishList(ProductEntity entity);
}
