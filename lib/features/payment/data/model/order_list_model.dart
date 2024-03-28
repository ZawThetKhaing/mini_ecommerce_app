import 'package:mini_ecommerce_app_assignment/features/payment/data/model/order_model.dart';
import 'package:mini_ecommerce_app_assignment/features/payment/domain/entities/order_entity.dart';

class OrderListModel extends OrderListEntity {
  const OrderListModel({
    required super.orderList,
  });

  factory OrderListModel.fromJson(Map<String, dynamic> json, String id) =>
      OrderListModel(
          orderList: (json['order_list'] as List<dynamic>).map(
        (e) {
          return OrderModel.fromJson(e as Map<String, dynamic>);
        },
      ).toList());

  Map<String, dynamic> toJson([String? id]) => {
        'order_list': orderList.map(
          (e) => (e as OrderModel).toJson(id),
        )
      };
}
