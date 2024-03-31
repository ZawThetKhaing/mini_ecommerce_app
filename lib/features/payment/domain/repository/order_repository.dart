import 'package:mini_ecommerce_app_assignment/core/utils/typedef.dart';
import 'package:mini_ecommerce_app_assignment/features/payment/domain/entities/order_entity.dart';
import 'package:mini_ecommerce_app_assignment/features/payment/domain/usecases/set_order_usecase.dart';

abstract class OrderRepository {
  ResultFuture<List<OrderEntity>> getOrderList(String uid);

  ResultFuture<Stream<OrderListEntity>> getOrderStream(String uid);

  ResultVoid setOrder(SetOrderParams entity);

  ResultVoid updateOrder(SetOrderParams entity);

  ResultVoid deleteOrder(String orderId);
}
