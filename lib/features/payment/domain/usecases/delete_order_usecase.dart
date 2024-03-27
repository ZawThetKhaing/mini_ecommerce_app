import 'package:mini_ecommerce_app_assignment/core/usecase/usecase.dart';
import 'package:mini_ecommerce_app_assignment/core/utils/typedef.dart';
import 'package:mini_ecommerce_app_assignment/features/payment/domain/repository/order_repository.dart';

class DeleteOrderUsecase implements UseCaseWithParams<void, String> {
  const DeleteOrderUsecase({required this.orderRepository});

  final OrderRepository orderRepository;

  @override
  ResultFuture<void> call(String params) => orderRepository.deleteOrder(params);
}
