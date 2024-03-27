import 'package:mini_ecommerce_app_assignment/features/payment/domain/entities/purchase_total_entity.dart';

class PurchaseTotalModel extends PurchaseTotalEntity {
  const PurchaseTotalModel({
    required super.subTotal,
    required super.shippingFee,
    required super.tax,
    required super.total,
  });

  factory PurchaseTotalModel.fromJson(Map<String, dynamic> json) =>
      PurchaseTotalModel(
        subTotal: json['sub_total'],
        shippingFee: json['shipping_fee'],
        tax: json['tax'],
        total: json['total'],
      );

  Map<String, dynamic> toJson() => {
        'sub_total': subTotal,
        'shipping_fee': shippingFee,
        'tax': tax,
        'total': total,
      };
}
