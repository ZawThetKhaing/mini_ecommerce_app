import 'package:flutter/material.dart';
import 'package:mini_ecommerce_app_assignment/features/product/data/models/product_model.dart';
import 'package:mini_ecommerce_app_assignment/features/product/presentation/providers/product_provider.dart';
import 'package:provider/provider.dart';

class AddorRemoveCartItem extends StatelessWidget {
  final ProductModel product;
  const AddorRemoveCartItem({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductsProvider>(
      builder: (_, provider, __) => Row(
        children: [
          GestureDetector(
            onTap: () async {
              int qty = product.qty ?? 1;
              qty -= 1;
              if (qty == 0) {
                await provider.deleteCartItem(product);
              } else {
                await provider.updateCartItem(product.copyWith(qty: qty));
              }
            },
            child: Container(
              width: 24,
              height: 20,
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                border: Border.all(width: 0.8),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Center(
                child: Icon(
                  Icons.remove,
                  size: 16,
                ),
              ),
            ),
          ),
          Text(product.qty == null ? '1' : product.qty.toString()),
          GestureDetector(
            onTap: () async {
              int qty = product.qty ?? 1;
              qty += 1;

              await provider.updateCartItem(product.copyWith(qty: qty));
            },
            child: Container(
              margin: const EdgeInsets.only(left: 8),
              width: 24,
              height: 20,
              decoration: BoxDecoration(
                border: Border.all(width: 0.8),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Center(
                child: Icon(
                  Icons.add,
                  size: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
