import 'package:flutter/material.dart';
import 'package:mini_ecommerce_app_assignment/features/others/widgets/cart_item_list_view.dart';
import 'package:mini_ecommerce_app_assignment/features/others/widgets/notification_icon.dart';
import 'package:mini_ecommerce_app_assignment/features/others/widgets/total_bottom_bar.dart';
import 'package:mini_ecommerce_app_assignment/features/product/presentation/providers/product_provider.dart';

import 'package:provider/provider.dart';

class CartView extends StatelessWidget {
  final bool? isFromDetail;
  const CartView({
    super.key,
    this.isFromDetail = false,
  });

  @override
  Widget build(BuildContext context) {
    final productProvider = context.read<ProductsProvider>();
    return Scaffold(
      appBar: isFromDetail!
          ? AppBar(
              leading: IconButton(
                onPressed: Navigator.of(context).pop,
                icon: const Icon(Icons.arrow_back),
              ),
              title: Text(
                "My Cart",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            )
          : null,
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        children: [
          isFromDetail!
              ? const SizedBox()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "My Cart",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                        onTap: () async {}, child: const NotificationIcon()),
                  ],
                ),
          Consumer<ProductsProvider>(
            builder: (_, provider, __) {
              return provider.cartProducts.isEmpty == true
                  ? SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: isFromDetail!
                          ? MediaQuery.of(context).size.height
                          : MediaQuery.of(context).size.height * 0.8,
                      child: const Center(
                        child: Text("No cart items."),
                      ),
                    )
                  : SizedBox(
                      height: isFromDetail!
                          ? MediaQuery.of(context).size.height * 0.88
                          : MediaQuery.of(context).size.height * 0.82,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CartItemListView(
                            cartItems: productProvider.cartProducts,
                          ),
                          const TotalBottomBar(),
                        ],
                      ),
                    );
            },
          ),
        ],
      ),
    );
  }
}
