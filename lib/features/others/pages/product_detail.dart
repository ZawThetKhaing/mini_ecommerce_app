import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mini_ecommerce_app_assignment/core/routes/route_config.dart';
import 'package:mini_ecommerce_app_assignment/features/product/data/models/product_model.dart';
import 'package:mini_ecommerce_app_assignment/features/product/presentation/providers/product_provider.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

class ProductDetail extends StatelessWidget {
  final ProductModel model;
  const ProductDetail({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    final provider = context.read<ProductsProvider>();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          splashRadius: 20,
          icon: const Icon(Icons.arrow_back),
          onPressed: Navigator.of(context).pop,
        ),
        centerTitle: true,
        title: Text(
          "Details",
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamed(RouteConfig.cart, arguments: true);
            },
            icon: const PhosphorIcon(PhosphorIconsRegular.shoppingCart),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 12),
            height: 320,
            child: CachedNetworkImage(
              imageUrl: model.image,
              fit: BoxFit.contain,
            ),
          ),
          Text(
            model.title,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            "${model.count} Remaining Instocks",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Text(
            "Rating : ${model.rate} %",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            model.description,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Colors.grey),
          ),
          const SizedBox(
            height: 8,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Price",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                "\$ ${model.price}",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          provider.addToCart(model).whenComplete(
                () => ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    duration: Durations.medium2,
                    content: Text("Add to cart successfully!"),
                  ),
                ),
              );
        },
        elevation: 0,
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        label: const Text("Add to Cart"),
        icon: const PhosphorIcon(
          PhosphorIconsRegular.shoppingBag,
        ),
      ),
    );
  }
}
