import 'package:mini_ecommerce_app_assignment/core/utils/typedef.dart';
import 'package:mini_ecommerce_app_assignment/features/payment/data/datasource/remote_datasource/order_remote_datasource.dart';
import 'package:mini_ecommerce_app_assignment/features/payment/domain/entities/order_entity.dart';
import 'package:mini_ecommerce_app_assignment/features/payment/domain/repository/order_repository.dart';
import 'package:mini_ecommerce_app_assignment/features/payment/domain/usecases/set_order_usecase.dart';

class OrderRepositoryImpl implements OrderRepository {
  const OrderRepositoryImpl({required this.orderRemoteDataSource});

  final OrderRemoteDataSource orderRemoteDataSource;

  @override
  ResultVoid deleteOrder(String orderId) =>
      orderRemoteDataSource.deleteOrder(orderId);

  @override
  ResultFuture<List<OrderEntity>> getOrderList(String uid) =>
      orderRemoteDataSource.getOrderList(uid);

  @override
  ResultVoid setOrder(SetOrderParams entity) =>
      orderRemoteDataSource.setOrder(entity);

  @override
  ResultVoid updateOrder(SetOrderParams entity) =>
      orderRemoteDataSource.updateOrder(entity);
}
