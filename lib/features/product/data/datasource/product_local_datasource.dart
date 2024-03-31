import 'package:dartz/dartz.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mini_ecommerce_app_assignment/core/constants/boxes.dart';
import 'package:mini_ecommerce_app_assignment/core/error/faliure.dart';
import 'package:mini_ecommerce_app_assignment/core/utils/typedef.dart';
import 'package:mini_ecommerce_app_assignment/features/product/domain/entities/product_entity.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart' as foundation;

abstract class ProductLocalDataSource {
  Future<bool> initDb();

  ResultVoid addToCart(ProductEntity entity);

  ResultVoid updateCartItem(ProductEntity entity);

  ResultFuture<List<ProductEntity?>> getCartList();

  ResultVoid deleteCartItem(ProductEntity entity);

  ResultVoid addToWishList(ProductEntity entity);

  ResultFuture<List<ProductEntity?>> getWishList();

  ResultVoid deleteWishList(ProductEntity entity);
}

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  @override
  Future<bool> initDb() async {
    try {
      if (!foundation.kIsWeb) {
        final appDir = await getApplicationDocumentsDirectory();
        await Hive.initFlutter(appDir.path);
      }

      if (!Hive.isAdapterRegistered(ProductResponseEntityAdapter().typeId)) {
        Hive.registerAdapter(ProductResponseEntityAdapter());

        await Hive.openBox<ProductResponseEntity>(Boxes.kProductResponse);
      }
      if (!Hive.isAdapterRegistered(ProductEntityAdapter().typeId)) {
        Hive.registerAdapter(ProductEntityAdapter());

        await Hive.openBox<ProductEntity>(Boxes.kWishList);

        await Hive.openBox<ProductEntity>(Boxes.kCartItems);
      }

      return true;
    } catch (e) {
      rethrow;
    }
  }

  @override
  ResultVoid addToCart(ProductEntity entity) async =>
      addToDb(Boxes.kCartItems, entity);

  @override
  ResultFuture<List<ProductEntity?>> getCartList() async =>
      getFromDb(Boxes.kCartItems);

  @override
  ResultVoid deleteCartItem(ProductEntity entity) async =>
      deleteFromDb(Boxes.kCartItems, entity.id);

  @override
  ResultVoid addToWishList(ProductEntity entity) async =>
      addToDb(Boxes.kWishList, entity);

  @override
  ResultFuture<List<ProductEntity?>> getWishList() async =>
      getFromDb(Boxes.kWishList);

  @override
  ResultVoid updateCartItem(ProductEntity entity) =>
      addToDb(Boxes.kCartItems, entity);

  @override
  ResultVoid deleteWishList(ProductEntity entity) async =>
      deleteFromDb(Boxes.kWishList, entity.id);

  ResultVoid addToDb(String boxKey, ProductEntity entity) async {
    final Box box = Hive.box<ProductEntity>(boxKey);

    try {
      await box.put(entity.id, entity);
      return const Right(null);
    } catch (e) {
      return Left(
        DbFaliure(boxKey == Boxes.kWishList
            ? "Add to wish list failed!"
            : "Add to cart failed!"),
      );
    }
  }

  ResultFuture<List<ProductEntity?>> getFromDb(String boxKey) async {
    final Box<ProductEntity> box = Hive.box<ProductEntity>(boxKey);

    final keys = box.keys.toList();

    final result = keys.map((e) => box.get(e)).toList();
    if (result.isEmpty) {
      return const Left(DbFaliure('No data'));
    } else {
      return Right(result);
    }
  }

  ResultVoid deleteFromDb(
    String boxKey,
    dynamic key,
  ) async {
    final Box<ProductEntity> box = Hive.box<ProductEntity>(boxKey);

    try {
      await box.delete(key);
      return const Right(null);
    } catch (e) {
      return const Left(DbFaliure("Delete failed."));
    }
  }
}
