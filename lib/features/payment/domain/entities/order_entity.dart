import 'package:equatable/equatable.dart';
import 'package:mini_ecommerce_app_assignment/features/payment/domain/entities/address_entity.dart';
import 'package:mini_ecommerce_app_assignment/features/payment/domain/entities/payment_method_entity.dart';
import 'package:mini_ecommerce_app_assignment/features/payment/domain/entities/purchase_total_entity.dart';
import 'package:mini_ecommerce_app_assignment/features/product/domain/entities/product_entity.dart';

class OrderListEntity extends Equatable {
  const OrderListEntity({
    required this.orderList,
  });
  final List<OrderEntity> orderList;
  @override
  List<Object?> get props => [
        orderList,
      ];
}

class OrderEntity extends Equatable {
  const OrderEntity(
      {this.orderId,
      this.paymentMethod,
      required this.address,
      required this.purchaseTotal,
      required this.cartItems,
      required this.createdAt,
      required this.updatedAt,
      required this.arrivialTime,
      required this.isDelivered,
      required this.isCashOnDelivery});

  final String? orderId;
  final AddressEntity address;
  final PaymentMethodEntity? paymentMethod;
  final PurchaseTotalEntity purchaseTotal;
  final List<ProductEntity> cartItems;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime arrivialTime;
  final bool isDelivered;
  final bool isCashOnDelivery;

  @override
  List<Object?> get props => [
        orderId,
        // address,
        // paymentMethod,
        // purchaseTotal,
        // cartItems,
        // createdAt,
        // updatedAt,
        // arrivialTime,
        // isDelivered,
        // isCashOnDelivery,
      ];
}
