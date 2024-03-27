import 'package:mini_ecommerce_app_assignment/core/usecase/usecase.dart';
import 'package:mini_ecommerce_app_assignment/core/utils/typedef.dart';
import 'package:mini_ecommerce_app_assignment/features/payment/domain/entities/order_entity.dart';
import 'package:mini_ecommerce_app_assignment/features/payment/domain/repository/order_repository.dart';

class GetOrderListUsecase
    implements UseCaseWithParams<List<OrderEntity>, String> {
  const GetOrderListUsecase({required this.orderRepository});

  final OrderRepository orderRepository;

  @override
  ResultFuture<List<OrderEntity>> call(String params) =>
      orderRepository.getOrderList(params);
}
