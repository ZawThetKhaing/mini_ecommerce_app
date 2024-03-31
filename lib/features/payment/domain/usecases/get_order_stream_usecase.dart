import 'package:mini_ecommerce_app_assignment/core/usecase/usecase.dart';
import 'package:mini_ecommerce_app_assignment/core/utils/typedef.dart';
import 'package:mini_ecommerce_app_assignment/features/payment/domain/entities/order_entity.dart';
import 'package:mini_ecommerce_app_assignment/features/payment/domain/repository/order_repository.dart';

class GetOrderStreamUsecase
    implements UseCaseWithParams<Stream<OrderListEntity>, String> {
  const GetOrderStreamUsecase({required this.orderRepository});

  final OrderRepository orderRepository;

  @override
  ResultFuture<Stream<OrderListEntity>> call(String params) =>
      orderRepository.getOrderStream(params);
}
