import 'package:mini_ecommerce_app_assignment/core/usecase/usecase.dart';
import 'package:mini_ecommerce_app_assignment/core/utils/typedef.dart';
import 'package:mini_ecommerce_app_assignment/features/payment/domain/entities/order_entity.dart';
import 'package:mini_ecommerce_app_assignment/features/payment/domain/repository/order_repository.dart';

class SetOrderUsecase implements UseCaseWithParams<void, SetOrderParams> {
  const SetOrderUsecase({required this.orderRepository});

  final OrderRepository orderRepository;

  @override
  ResultFuture<void> call(SetOrderParams params) =>
      orderRepository.setOrder(params);
}

class SetOrderParams {
  const SetOrderParams({
    required this.uid,
    required this.orderListEntity,
  });
  final String uid;
  final OrderListEntity orderListEntity;
}
