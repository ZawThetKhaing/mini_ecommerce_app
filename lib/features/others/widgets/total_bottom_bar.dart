import 'package:flutter/material.dart';
import 'package:mini_ecommerce_app_assignment/core/routes/route_config.dart';
import 'package:mini_ecommerce_app_assignment/features/auth/presentation/provider/auth_provider.dart';
import 'package:mini_ecommerce_app_assignment/features/payment/data/model/order_model.dart';
import 'package:mini_ecommerce_app_assignment/features/payment/data/model/purchase_total.dart';
import 'package:mini_ecommerce_app_assignment/features/payment/presentation/providers/payment_provider.dart';
import 'package:mini_ecommerce_app_assignment/features/product/presentation/providers/product_provider.dart';
import 'package:provider/provider.dart';

class TotalBottomBar extends StatelessWidget {
  const TotalBottomBar({
    super.key,
    this.isCheckOut = false,
    this.isOrderDetails = false,
    this.orderModel,
  });
  final bool isCheckOut;
  final bool isOrderDetails;
  final OrderModel? orderModel;

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductsProvider>(
      builder: (_, provider, __) => Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 4.0,
                vertical: 8.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Subtotal"),
                  Text(
                      "\$ ${orderModel?.purchaseTotal.subTotal.toStringAsFixed(2) ?? provider.subTotal.toStringAsFixed(2)}"),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 4.0,
                vertical: 8.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Tax(5%)"),
                  Text(
                      "\$ ${orderModel?.purchaseTotal.tax.toStringAsFixed(2) ?? provider.tax.toStringAsFixed(2)}"),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Shipping fee"),
                  Text(
                      "\$ ${orderModel?.purchaseTotal.shippingFee.toStringAsFixed(2) ?? provider.shippingFee}"),
                ],
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 4.0,
                vertical: 8.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Total"),
                  Text(
                      "\$ ${orderModel?.purchaseTotal.total.toStringAsFixed(2) ?? provider.total.toStringAsFixed(2)}"),
                ],
              ),
            ),
            isOrderDetails
                ? const SizedBox()
                : SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () async {
                        final paymentProvider = context.read<PaymentProvider>();

                        if (!isCheckOut) {
                          Navigator.of(context).pushNamed(RouteConfig.checkOut);
                          return;
                        } else {
                          final cartProvider = context.read<ProductsProvider>();
                          final authProvider = context.read<AuthProvider>();
                          final purchaseTotal = PurchaseTotalModel(
                            subTotal: provider.subTotal,
                            shippingFee: provider.shippingFee,
                            tax: provider.tax,
                            total: provider.total,
                          );

                          if (paymentProvider.addressModel == null ||
                              provider.selectedRadioBtnValue == null) {
                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: Text(
                                  provider.selectedRadioBtnValue == null
                                      ? "Payment method empty!"
                                      : "Address empty!",
                                ),
                                content: Text(provider.selectedRadioBtnValue ==
                                        null
                                    ? "Please choose a payment method."
                                    : "You need to input an address before order."),
                                actions: [
                                  ElevatedButton(
                                    onPressed: Navigator.of(context).pop,
                                    child: const Text("Ok"),
                                  )
                                ],
                              ),
                            );
                          }

                          if (provider.selectedRadioBtnValue == 1 &&
                              paymentProvider.paymentMethodModel == null) {
                            // Radio button value is 1 when user select bank payment

                            await Navigator.of(context).pushNamed(
                              RouteConfig.paymentForm,
                            );
                          }

                          if (provider.selectedRadioBtnValue == 1 &&
                              paymentProvider.paymentMethodModel == null)
                            return;

                          final result = await paymentProvider.setOrder(
                            purchaseTotalModel: purchaseTotal,
                            carItems: cartProvider.cartProducts,
                            isCashonDelivery:
                                provider.selectedRadioBtnValue == 2,
                            uid: authProvider.user?.id ?? '',
                          );

                          Future.delayed(const Duration(seconds: 0))
                              .whenComplete(
                            () {
                              if (result == true) {
                                final deleteCart = provider.cartProducts
                                    .map((e) => provider.deleteCartItem(e))
                                    .toList();
                                Future.wait(deleteCart);
                                Navigator.of(context)
                                    .pushNamed(RouteConfig.orderSuccessful);
                              }
                            },
                          );
                        }
                      },
                      child: Text(isCheckOut
                          ? "Place order"
                          : "Checkout (${provider.cartItemsQty})"),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
