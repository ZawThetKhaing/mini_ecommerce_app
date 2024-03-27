import 'package:flutter/material.dart';
import 'package:mini_ecommerce_app_assignment/features/others/widgets/cart_item_list_tile.dart';
import 'package:mini_ecommerce_app_assignment/features/product/data/models/product_model.dart';

class CartItemListView extends StatelessWidget {
  const CartItemListView({
    super.key,
    required this.cartItems,
  });
  final List<ProductModel?> cartItems;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.55,
      child: ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (_, index) {
          return CartItemListTile(product: cartItems[index]!);
        },
      ),
    );
  }
}
