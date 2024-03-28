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
        subTotal: double.parse(json['sub_total'].toString()),
        shippingFee: double.parse(json['shipping_fee'].toString()),
        tax: double.parse(json['tax'].toString()),
        total: double.parse(json['total'].toString()),
      );

  Map<String, dynamic> toJson() => {
        'sub_total': subTotal,
        'shipping_fee': shippingFee,
        'tax': tax,
        'total': total,
      };
}
