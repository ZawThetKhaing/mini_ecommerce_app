import 'package:flutter/material.dart';
import 'package:mini_ecommerce_app_assignment/core/routes/route_config.dart';
import 'package:mini_ecommerce_app_assignment/features/auth/presentation/provider/auth_provider.dart';
import 'package:mini_ecommerce_app_assignment/features/payment/data/model/purchase_total.dart';
import 'package:mini_ecommerce_app_assignment/features/payment/presentation/providers/payment_provider.dart';
import 'package:mini_ecommerce_app_assignment/features/product/presentation/providers/product_provider.dart';
import 'package:provider/provider.dart';

class TotalBottomBar extends StatelessWidget {
  const TotalBottomBar({
    super.key,
    this.isCheckOut = false,
  });
  final bool isCheckOut;

  @override
  Widget build(BuildContext context) {
    final productProvider = context.read<ProductsProvider>();
    return Container(
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
                Text("\$ ${productProvider.subTotal.toStringAsFixed(2)}"),
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
                Text("\$ ${productProvider.tax.toStringAsFixed(2)}"),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Shipping fee"),
                Text("\$ 50"),
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
                Text("\$ ${productProvider.total.toStringAsFixed(2)}"),
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: ElevatedButton(
              onPressed: () async {
                final provier = context.read<PaymentProvider>();

                if (!isCheckOut) {
                  Navigator.of(context).pushNamed(RouteConfig.checkOut);
                  return;
                } else {
                  final cartProvider = context.read<ProductsProvider>();
                  final provider = context.read<PaymentProvider>();
                  final authProvider = context.read<AuthProvider>();

                  final purchaseTotal = PurchaseTotalModel(
                    subTotal: productProvider.subTotal,
                    shippingFee: 50,
                    tax: productProvider.tax,
                    total: productProvider.total,
                  );

                  if (provier.addressModel == null ||
                      productProvider.selectedRadioBtnValue == null) {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: Text(
                          productProvider.selectedRadioBtnValue == null
                              ? "Payment method empty!"
                              : "Address empty!",
                        ),
                        content: Text(
                            productProvider.selectedRadioBtnValue == null
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

                  if (productProvider.selectedRadioBtnValue == 1 &&
                      provider.paymentMethodModel == null) {
                    // Radio button value is 1 when user select bank payment

                    await Navigator.of(context).pushNamed(
                      RouteConfig.paymentForm,
                    );
                  }

                  if (productProvider.selectedRadioBtnValue == 1 &&
                      provider.paymentMethodModel == null) return;

                  final result = await provider.setOrder(
                    purchaseTotalModel: purchaseTotal,
                    carItems: cartProvider.cartProducts,
                    isCashonDelivery:
                        productProvider.selectedRadioBtnValue == 2,
                    uid: authProvider.user?.id ?? '',
                  );

                  Future.delayed(const Duration(seconds: 0)).whenComplete(
                    () {
                      if (result == true) {
                        final deleteCart = productProvider.cartProducts
                            .map((e) => productProvider.deleteCartItem(e))
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
                  : "Checkout (${productProvider.cartProducts.length})"),
            ),
          ),
        ],
      ),
    );
  }
}
