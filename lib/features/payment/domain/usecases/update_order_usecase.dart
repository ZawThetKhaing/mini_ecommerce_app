import 'package:mini_ecommerce_app_assignment/core/usecase/usecase.dart';
import 'package:mini_ecommerce_app_assignment/core/utils/typedef.dart';
import 'package:mini_ecommerce_app_assignment/features/payment/domain/repository/order_repository.dart';
import 'package:mini_ecommerce_app_assignment/features/payment/domain/usecases/set_order_usecase.dart';

class UpdateOrderUsecase implements UseCaseWithParams<void, SetOrderParams> {
  const UpdateOrderUsecase({required this.orderRepository});

  final OrderRepository orderRepository;
  @override
  ResultFuture<void> call(SetOrderParams params) =>
      orderRepository.updateOrder(params);
}
