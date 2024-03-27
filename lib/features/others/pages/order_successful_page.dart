import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mini_ecommerce_app_assignment/core/routes/route_config.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class OrderSuccessfulPage extends StatelessWidget {
  const OrderSuccessfulPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const PhosphorIcon(
              PhosphorIconsRegular.checkCircle,
              size: 80,
              color: Colors.green,
            ),
            Text(
              "Order place successfully!",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              height: 4,
            ),
            SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.9,
              child: Text(
                "You can now track your order.Your order will arrive ${DateFormat.yMMMMd().format(DateTime.now())} and enjoy.",
                style: Theme.of(context).textTheme.bodyMedium,
                maxLines: 3,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ElevatedButton(
        child: const Text("Continue shopping"),
        onPressed: () {
          Navigator.of(context).pushNamedAndRemoveUntil(
            RouteConfig.wrapper,
            (_) => false,
          );
        },
      ),
    );
  }
}
