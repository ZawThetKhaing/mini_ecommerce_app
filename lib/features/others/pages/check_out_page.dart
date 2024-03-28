import 'package:flutter/material.dart';
import 'package:mini_ecommerce_app_assignment/core/routes/route_config.dart';
import 'package:mini_ecommerce_app_assignment/features/auth/presentation/provider/auth_provider.dart';
import 'package:mini_ecommerce_app_assignment/features/others/widgets/add_address_widget.dart';
import 'package:mini_ecommerce_app_assignment/features/others/widgets/cart_item_list_tile.dart';
import 'package:mini_ecommerce_app_assignment/features/others/widgets/total_bottom_bar.dart';
import 'package:mini_ecommerce_app_assignment/features/payment/presentation/providers/payment_provider.dart';
import 'package:mini_ecommerce_app_assignment/features/product/presentation/providers/product_provider.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

class CheckOutPage extends StatefulWidget {
  const CheckOutPage({super.key});

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Check out",
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        children: [
          const AddAddressWidget(),
          const SizedBox(
            height: 8,
          ),
          Text(
            "Your order",
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(fontWeight: FontWeight.w600),
          ),
          Column(
            children: context
                .read<ProductsProvider>()
                .cartProducts
                .map(
                  (product) => CartItemListTile(
                    product: product,
                    isCheckOut: true,
                  ),
                )
                .toList(),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            "Choose payment method",
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          Consumer<ProductsProvider>(builder: (_, provider, __) {
            final PaymentProvider paymentProvider =
                context.read<PaymentProvider>();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Radio(
                      value: 1,
                      groupValue: provider.selectedRadioBtnValue,
                      onChanged: provider.radioBtnChange,
                    ),
                    Text(
                      "Bank payment",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
                provider.selectedRadioBtnValue == 1
                    ? GestureDetector(
                        onTap: () {
                          paymentProvider.paymentMethodModel?.cardNumber == null
                              ? Navigator.of(context)
                                  .pushNamed(RouteConfig.paymentForm)
                              : null;
                        },
                        child: Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.only(left: 20),
                          child: paymentProvider
                                      .paymentMethodModel?.cardNumber !=
                                  null
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Card number : ${paymentProvider.paymentMethodModel!.cardNumber}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall,
                                    ),
                                    Text(
                                      "Expired date  : ${paymentProvider.paymentMethodModel!.expiredDate}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall,
                                    ),
                                  ],
                                )
                              : Text(
                                  "Add a card",
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                        ),
                      )
                    : const SizedBox(),
                Row(
                  children: [
                    Radio(
                      value: 2,
                      groupValue: provider.selectedRadioBtnValue,
                      onChanged: provider.radioBtnChange,
                    ),
                    Text(
                      "Cash on delivery",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
                const TotalBottomBar(
                  isCheckOut: true,
                ),
              ],
            );
          })
        ],
      ),
    );
  }
}
