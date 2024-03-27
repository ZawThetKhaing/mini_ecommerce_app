import 'package:flutter/material.dart';
import 'package:mini_ecommerce_app_assignment/features/payment/data/model/order_model.dart';

class OrderPage extends StatelessWidget {
  final List<OrderModel> orderItems;
  const OrderPage({
    super.key,
    required this.orderItems,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: orderItems.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(orderItems[index].orderId!),
          );
        },
      ),
    );
  }
}
