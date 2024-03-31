import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mini_ecommerce_app_assignment/features/payment/data/model/address_model.dart';
import 'package:mini_ecommerce_app_assignment/features/payment/data/model/payment_method_model.dart';
import 'package:mini_ecommerce_app_assignment/features/payment/data/model/purchase_total.dart';
import 'package:mini_ecommerce_app_assignment/features/payment/domain/entities/order_entity.dart';
import 'package:mini_ecommerce_app_assignment/features/product/data/models/product_model.dart';

class OrderModel extends OrderEntity {
  const OrderModel({
    super.orderId,
    super.paymentMethod,
    required super.address,
    required super.purchaseTotal,
    required super.cartItems,
    required super.createdAt,
    required super.updatedAt,
    required super.arrivialTime,
    required super.isDelivered,
    required super.isCashOnDelivery,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      orderId: json['order_id'],
      address: AddressModel.fromJson(json['address']),
      paymentMethod: json['payment_method'] != null
          ? PaymentMethodModel.fromJson(json['payment_method'])
          : null,
      purchaseTotal: PurchaseTotalModel.fromJson(json['purchase_total']),
      cartItems: (json['cart_items'] as List<dynamic>)
          .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: (json['created_at'] as Timestamp).toDate(),
      updatedAt: (json['updated_at'] as Timestamp).toDate(),
      arrivialTime: (json['arrivial_time'] as Timestamp).toDate(),
      isDelivered: json['is_delivered'],
      isCashOnDelivery: json['is_cash_on_delivery'],
    );
  }

  Map<String, dynamic> toJson([String? uuid]) {
    return {
      'order_id': orderId ?? uuid,
      'address': (address as AddressModel).toJson(),
      'payment_method': paymentMethod != null
          ? (paymentMethod as PaymentMethodModel).toJson()
          : null,
      'purchase_total': (purchaseTotal as PurchaseTotalModel).toJson(),
      'cart_items': cartItems.map((e) => (e as ProductModel).toJson()).toList(),
      'created_at': createdAt,
      'updated_at': updatedAt,
      'arrivial_time': arrivialTime,
      'is_delivered': isDelivered,
      'is_cash_on_delivery': isCashOnDelivery,
    };
  }

  OrderModel copyWith({
    String? orderId,
    AddressModel? address,
    PaymentMethodModel? paymentMethod,
    PurchaseTotalModel? purchaseTotal,
    List<ProductModel>? cartItems,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? arrivialTime,
    bool? isDelivered,
    bool? isCashOnDelivery,
  }) =>
      OrderModel(
        orderId: orderId ?? this.orderId,
        address: address ?? this.address,
        paymentMethod: paymentMethod ?? this.paymentMethod,
        purchaseTotal: purchaseTotal ?? this.purchaseTotal,
        cartItems: cartItems ?? this.cartItems,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        arrivialTime: arrivialTime ?? this.arrivialTime,
        isDelivered: isDelivered ?? this.isDelivered,
        isCashOnDelivery: isCashOnDelivery ?? this.isCashOnDelivery,
      );
}
