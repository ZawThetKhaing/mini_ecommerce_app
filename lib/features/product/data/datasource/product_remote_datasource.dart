import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:mini_ecommerce_app_assignment/core/constants/constant.dart';
import 'package:mini_ecommerce_app_assignment/core/error/faliure.dart';
import 'package:mini_ecommerce_app_assignment/core/utils/typedef.dart';
import 'package:mini_ecommerce_app_assignment/features/product/data/models/product_model.dart';
import 'package:http/http.dart' as http;

abstract class ProductRemoteDataSource {
  ResultFuture<ProductResponseModel> getProducts();
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  const ProductRemoteDataSourceImpl({required this.client});

  final http.Client client;

  @override
  ResultFuture<ProductResponseModel> getProducts() async {
    Uri uri = Uri.parse(Urls.fetchAllProduct);

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final model = ProductResponseModel.fromJson(
          jsonDecode(response.body),
        );
        return Right(model);
      } else {
        return Left(DatabaseFailure(response.statusCode.toString()));
      }
    } catch (e) {
      return const Left(
        ServerFailure(
          "No data",
        ),
      );
    }
  }
}
