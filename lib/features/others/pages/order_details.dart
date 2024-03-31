import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mini_ecommerce_app_assignment/features/auth/presentation/provider/auth_provider.dart';
import 'package:mini_ecommerce_app_assignment/features/others/widgets/add_address_widget.dart';
import 'package:mini_ecommerce_app_assignment/features/others/widgets/total_bottom_bar.dart';
import 'package:mini_ecommerce_app_assignment/features/payment/data/model/order_model.dart';
import 'package:mini_ecommerce_app_assignment/features/payment/presentation/providers/payment_provider.dart';
import 'package:provider/provider.dart';

class OrderDetailsPage extends StatelessWidget {
  final OrderModel orderModel;
  const OrderDetailsPage({
    super.key,
    required this.orderModel,
  });

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Details"),
        centerTitle: true,
        actions: [
          TextButton(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all(
                Colors.red,
              ),
              overlayColor: MaterialStateProperty.all(
                Colors.transparent,
              ),
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text("Delete an order!"),
                  content: const Text("Are you sure want to delete"),
                  actions: [
                    ElevatedButton(
                      onPressed: () async {
                        await context
                            .read<PaymentProvider>()
                            .updateorDeleteOrder(
                              uid: user.user!.id,
                              isUpdate: false,
                              orderModel: orderModel,
                            )
                            .whenComplete(
                          () {
                            Navigator.of(context).pop();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Deleted"),
                              ),
                            );
                            Navigator.of(context).pop();
                          },
                        );
                      },
                      child: const Text("Ok"),
                    )
                  ],
                ),
              );
            },
            child: const Text("Cancel order"),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 16.0, left: 16, right: 16),
        children: [
          Text(
            "Order ID: ${orderModel.orderId?.split('-').first}",
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            "Your orders",
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 8,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: orderModel.cartItems
                .map(
                  (product) => Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey.withOpacity(0.5),
                          ),
                        ),
                        height: 50,
                        width: 50,
                        child: CachedNetworkImage(
                          imageUrl: product.image,
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
                            Text(
                              product.title,
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            Text(
                              "${product.qty} x quantity",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
                .toList(),
          ),
          const SizedBox(
            height: 16,
          ),
          TotalBottomBar(
            isOrderDetails: true,
            orderModel: orderModel,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Divider(),
          ),
          const SizedBox(
            height: 8,
          ),
          AddAddressWidget(
            isOrderDetails: true,
            orderModel: orderModel,
          ),
          Text(
            orderModel.isCashOnDelivery
                ? "Cash on delivery"
                : "Payment completed",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Row(
            children: [
              Text(
                "Order Status: ",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                orderModel.isDelivered ? "Complete" : "On going",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color:
                          orderModel.isDelivered ? Colors.green : Colors.orange,
                    ),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            "Order Date: ${DateFormat.yMMMEd().format(orderModel.createdAt)}",
            style: Theme.of(context).inputDecorationTheme.hintStyle,
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            "Arrivial Date: ${DateFormat.yMMMEd().format(orderModel.arrivialTime)}",
            style: Theme.of(context).inputDecorationTheme.hintStyle,
          ),
        ],
      ),
    );
  }
}
