import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mini_ecommerce_app_assignment/core/routes/route_config.dart';
import 'package:mini_ecommerce_app_assignment/features/others/widgets/add_or_remove_cart_item.dart';
import 'package:mini_ecommerce_app_assignment/features/product/data/models/product_model.dart';
import 'package:mini_ecommerce_app_assignment/features/product/presentation/providers/product_provider.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

class CartItemListTile extends StatelessWidget {
  const CartItemListTile({
    super.key,
    required this.product,
    this.isCheckOut = false,
  });
  final ProductModel product;
  final bool isCheckOut;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamed(RouteConfig.details, arguments: product);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: isCheckOut ? null : const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 100,
              height: 110,
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                border: Border.all(width: 0.5),
              ),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          isCheckOut
                              ? SizedBox(
                                  width: MediaQuery.of(context).size.width > 280
                                      ? 250
                                      : 200,
                                  height: 50,
                                  child: Text(
                                    product.title,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                )
                              : SizedBox(
                                  width: 200,
                                  height: 45,
                                  child: Text(
                                    product.title,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                ),
                          isCheckOut
                              ? const SizedBox()
                              : GestureDetector(
                                  onTap: () {
                                    context
                                        .read<ProductsProvider>()
                                        .deleteCartItem(
                                          product,
                                        )
                                        .whenComplete(
                                          () => ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              duration: Durations.medium2,
                                              content: Text(
                                                "Remove from cart successfully!",
                                              ),
                                            ),
                                          ),
                                        );
                                  },
                                  child: const PhosphorIcon(
                                    PhosphorIconsRegular.trash,
                                    color: Colors.red,
                                  ),
                                ),
                        ],
                      ),
                      Text(
                        isCheckOut
                            ? "${product.qty} x quantity"
                            : "${product.count} item(s) left",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "\$ ${product.price}",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      isCheckOut
                          ? const SizedBox()
                          : AddorRemoveCartItem(product: product),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
