import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mini_ecommerce_app_assignment/features/others/widgets/notification_icon.dart';
import 'package:mini_ecommerce_app_assignment/features/product/presentation/providers/product_provider.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

class WishListView extends StatelessWidget {
  const WishListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Wish List",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                    onTap: () async {}, child: const NotificationIcon()),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Expanded(
              child:
                  Consumer<ProductsProvider>(builder: (context, provider, _) {
                return FutureBuilder(
                    future: provider.getWishList(),
                    builder: (context, snapshots) {
                      if (snapshots.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      if (snapshots.data == null || snapshots.data!.isEmpty) {
                        return const Center(
                          child: Text("Oops! Your wish list is empty."),
                        );
                      }

                      final wishListItems = snapshots.data!.toList();

                      return ListView.builder(
                          itemCount: wishListItems.length,
                          itemBuilder: (context, index) {
                            return Container(
                              width: 110,
                              height: 150,
                              margin: const EdgeInsets.symmetric(vertical: 4),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 110,
                                    height: 140,
                                    padding: const EdgeInsets.all(4),
                                    child: CachedNetworkImage(
                                      imageUrl: wishListItems[index].image,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 8.0,
                                      ),
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
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 12.0),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    SizedBox(
                                                      width: 220,
                                                      child: Text(
                                                        wishListItems[index]
                                                            .title,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyLarge
                                                            ?.copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        provider
                                                            .deleteWishListItem(
                                                              wishListItems[
                                                                  index],
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
                                                                      "Remove from wish list!"),
                                                                ),
                                                              ),
                                                            );
                                                      },
                                                      child: const PhosphorIcon(
                                                        PhosphorIconsFill.heart,
                                                        color: Colors.red,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Text(
                                                "${wishListItems[index].count} item(s) left",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium,
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 12.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "\$ ${wishListItems[index].price}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge
                                                      ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                ),
                                                SizedBox(
                                                  width: 90,
                                                  height: 40,
                                                  child: ElevatedButton(
                                                    style: ButtonStyle(
                                                      padding:
                                                          MaterialStateProperty
                                                              .all(
                                                        EdgeInsets.zero,
                                                      ),
                                                    ),
                                                    onPressed: () {
                                                      provider
                                                          .addToCart(
                                                              wishListItems[
                                                                  index])
                                                          .whenComplete(
                                                            () => ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                              const SnackBar(
                                                                duration:
                                                                    Durations
                                                                        .medium2,
                                                                content: Text(
                                                                    "Add to cart successfully!"),
                                                              ),
                                                            ),
                                                          );
                                                    },
                                                    child: const Text(
                                                        "Add to cart"),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          });
                    });
              }),
            ),
          ],
        ),
      ),
    );
  }
}
