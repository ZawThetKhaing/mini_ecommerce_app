import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:dartz/dartz.dart';
import 'package:mini_ecommerce_app_assignment/core/constants/firestore_collections.dart';
import 'package:mini_ecommerce_app_assignment/core/error/faliure.dart';
import 'package:mini_ecommerce_app_assignment/core/utils/typedef.dart';
import 'package:mini_ecommerce_app_assignment/features/payment/data/model/order_model.dart';
import 'package:mini_ecommerce_app_assignment/features/payment/data/model/order_list_model.dart';
import 'package:mini_ecommerce_app_assignment/features/payment/domain/usecases/set_order_usecase.dart';
import 'package:uuid/uuid.dart';

abstract class OrderRemoteDataSource {
  ResultFuture<List<OrderModel>> getOrderList(String uid);

  ResultFuture<Stream<OrderListModel>> getOrderStream(String uid);

  ResultVoid setOrder(SetOrderParams params);

  ResultVoid updateOrder(SetOrderParams params);

  ResultVoid deleteOrder(String orderId);
}

class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  OrderRemoteDataSourceImpl({
    required this.firebaseFirestore,
    required this.uuid,
  });
  final firestore.FirebaseFirestore firebaseFirestore;

  final Uuid uuid;

  @override
  ResultVoid deleteOrder(String orderId) async {
    try {
      await firebaseFirestore
          .collection(FireStoreCollections.orderCollection)
          .doc(orderId)
          .delete();
      return const Right(null);
    } on firestore.FirebaseException catch (e) {
      return Left(ServerFailure("${e.message}"));
    }
  }

  @override
  ResultFuture<List<OrderModel>> getOrderList(String uid) async {
    try {
      final snapShot = await firebaseFirestore
          .collection(FireStoreCollections.orderCollection)
          .doc(uid)
          .get();

      if (snapShot.data() != null) {
        try {
          OrderListModel model =
              OrderListModel.fromJson(snapShot.data()!, snapShot.id);

          return Right(model.orderList as List<OrderModel>);
        } catch (e) {
          rethrow;
        }
      } else {
        return const Left(ServerFailure("No order found!"));
      }
    } on firestore.FirebaseException catch (e) {
      return Left(ServerFailure("${e.message}"));
    }
  }

  @override
  ResultVoid setOrder(SetOrderParams params) async {
    try {
      await firebaseFirestore
          .collection(FireStoreCollections.orderCollection)
          .doc(params.uid)
          .set((params.orderListEntity as OrderListModel).toJson(uuid.v1()));

      return const Right(null);
    } on firestore.FirebaseException catch (e) {
      return Left(ServerFailure("${e.message}"));
    }
  }

  @override
  ResultVoid updateOrder(SetOrderParams params) async {
    try {
      await firebaseFirestore
          .collection(FireStoreCollections.orderCollection)
          .doc(params.uid)
          .update((params.orderListEntity as OrderListModel).toJson());
      return const Right(null);
    } on firestore.FirebaseException catch (e) {
      return Left(ServerFailure("${e.message}"));
    }
  }

  @override
  ResultFuture<Stream<OrderListModel>> getOrderStream(String uid) async {
    try {
      final orderStream = firebaseFirestore
          .collection(FireStoreCollections.orderCollection)
          .doc(uid)
          .snapshots();

      final stream = orderStream.map(
          (event) => OrderListModel.fromJson(event.data() ?? {}, event.id));

      return Right(stream);
    } catch (e) {
      return const Left(ServerFailure("No data"));
    }
  }
}
