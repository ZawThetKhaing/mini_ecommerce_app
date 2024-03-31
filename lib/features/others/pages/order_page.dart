import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:mini_ecommerce_app_assignment/core/routes/route_config.dart';
import 'package:mini_ecommerce_app_assignment/features/payment/data/model/order_list_model.dart';
import 'package:mini_ecommerce_app_assignment/features/payment/presentation/providers/payment_provider.dart';
import 'package:mini_ecommerce_app_assignment/features/product/data/models/product_model.dart';

import 'package:provider/provider.dart';

class OrderPage extends StatefulWidget {
  final String uid;
  const OrderPage({
    super.key,
    required this.uid,
  });

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  late final PaymentProvider paymentProvider;
  @override
  void initState() {
    paymentProvider = context.read<PaymentProvider>();
    paymentProvider.watchOrder(widget.uid);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Orders"),
        centerTitle: true,
      ),
      body: StreamBuilder<OrderListModel>(
        stream: paymentProvider.controller.stream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.data == null || snapshot.data!.orderList.isEmpty) {
            return const Center(
              child: SizedBox(
                child: Text("No order!"),
              ),
            );
          }
          final orderItems = snapshot.data?.orderList.toList() ?? [];
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: orderItems.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(
                    RouteConfig.orderDetails,
                    arguments: orderItems[index],
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 100,
                        width: 100,
                        child: CachedNetworkImage(
                          imageUrl: orderItems[index].cartItems.first.image,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Order id: ${orderItems[index].orderId!.split('-').first}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  orderItems[index].isDelivered
                                      ? "Delivered"
                                      : "On going",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        color: orderItems[index].isDelivered
                                            ? Colors.green
                                            : Colors.orange,
                                      ),
                                ),
                              ],
                            ),
                            Text(
                              "Quantity: ${paymentProvider.orderQuantity(orderItems[index].cartItems as List<ProductModel>)}",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Text(
                              "Order Date: ${DateFormat.yMMMEd().format(orderItems[index].createdAt)}",
                              style: Theme.of(context)
                                  .inputDecorationTheme
                                  .hintStyle,
                            ),
                            Text(
                              "Arrivial Date: ${DateFormat.yMMMEd().format(orderItems[index].arrivialTime)}",
                              style: Theme.of(context)
                                  .inputDecorationTheme
                                  .hintStyle,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
