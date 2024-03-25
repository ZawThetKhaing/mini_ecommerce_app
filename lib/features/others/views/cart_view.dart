import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mini_ecommerce_app_assignment/features/others/widgets/notification_icon.dart';
import 'package:mini_ecommerce_app_assignment/features/product/data/models/product_model.dart';
import 'package:mini_ecommerce_app_assignment/features/product/presentation/providers/product_provider.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

class CartView extends StatelessWidget {
  final bool? isFromDetail;
  const CartView({
    super.key,
    this.isFromDetail = false,
  });

  @override
  Widget build(BuildContext context) {
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
            builder: (_, provider, __) => FutureBuilder(
              future: provider.getCartProducts(),
              builder: (_, snapshots) {
                if (snapshots.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshots.data == null || snapshots.data!.isEmpty) {
                  return SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: isFromDetail!
                        ? MediaQuery.of(context).size.height
                        : MediaQuery.of(context).size.height * 0.8,
                    child: const Center(
                      child: Text("No cart items."),
                    ),
                  );
                } else {
                  final List<ProductModel?> cartItems =
                      snapshots.data!.toList();
                  return SizedBox(
                    height: isFromDetail!
                        ? MediaQuery.of(context).size.height * 0.88
                        : MediaQuery.of(context).size.height * 0.82,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.5,
                          child: ListView.builder(
                            itemCount: cartItems.length,
                            itemBuilder: (_, index) {
                              return Container(
                                width: 83,
                                height: 90,
                                margin: const EdgeInsets.all(8),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white,
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 83,
                                      height: 90,
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        border: Border.all(width: 0.5),
                                      ),
                                      child: CachedNetworkImage(
                                        imageUrl: cartItems[index]!.image,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "${cartItems[index]?.title.substring(0, 18) ?? ''}...",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyLarge
                                                        ?.copyWith(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      provider
                                                          .deleteCartItem(
                                                            cartItems[index]!,
                                                          )
                                                          .whenComplete(
                                                            () => ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                              const SnackBar(
                                                                duration:
                                                                    Durations
                                                                        .medium2,
                                                                content: Text(
                                                                  "Remove from cart successfully!",
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                      ;
                                                    },
                                                    child: const PhosphorIcon(
                                                      PhosphorIconsRegular
                                                          .trash,
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                "${cartItems[index]!.count} item(s) left",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium,
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "\$ ${cartItems[index]!.price}",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge
                                                    ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                              ),
                                              Row(
                                                children: [
                                                  Container(
                                                    width: 24,
                                                    height: 20,
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 8),
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          width: 0.8),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4),
                                                    ),
                                                    child: const Center(
                                                      child: Icon(
                                                        Icons.remove,
                                                        size: 16,
                                                      ),
                                                    ),
                                                  ),
                                                  const Text("1"),
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            left: 8),
                                                    width: 24,
                                                    height: 20,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          width: 0.8),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4),
                                                    ),
                                                    child: const Center(
                                                      child: Icon(
                                                        Icons.add,
                                                        size: 16,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        Container(
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text("Subtotal"),
                                    Text(
                                        "\$ ${provider.subTotal.toStringAsFixed(2)}"),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 4.0,
                                  vertical: 8.0,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text("Tax(5%)"),
                                    Text(
                                        "\$ ${provider.tax.toStringAsFixed(2)}"),
                                  ],
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 4.0, vertical: 8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text("Total"),
                                    Text(
                                        "\$ ${provider.total.toStringAsFixed(2)}"),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  child: Text("Checkout (${cartItems.length})"),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
