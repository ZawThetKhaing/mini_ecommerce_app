import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mini_ecommerce_app_assignment/core/routes/route_config.dart';
import 'package:mini_ecommerce_app_assignment/features/product/presentation/providers/get_product_provider.dart';
import 'package:provider/provider.dart';

class HomeTabBarView extends StatefulWidget {
  final List<String> category;
  const HomeTabBarView({
    super.key,
    required this.category,
  });

  @override
  State<HomeTabBarView> createState() => _HomeTabBarViewState();
}

class _HomeTabBarViewState extends State<HomeTabBarView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late GetProductsProvider provider;

  @override
  void initState() {
    provider = context.read<GetProductsProvider>();
    _tabController =
        TabController(length: widget.category.length + 1, vsync: this);

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        if (_tabController.index == 0) {
          return;
        } else if (provider.productCategory != null) {
          provider.filterByCategory(
              provider.productCategory![_tabController.index - 1]);
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: SizedBox(
            height: 32,
            width: MediaQuery.of(context).size.width,
            child: TabBar(
              overlayColor: MaterialStateProperty.all(Colors.transparent),
              dividerColor: Colors.transparent,
              labelColor: Colors.white,
              indicatorSize: TabBarIndicatorSize.label,
              unselectedLabelColor: Colors.black,
              controller: _tabController,
              indicator: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(8),
              ),
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              tabs: [
                const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  child: Tab(
                    text: "All",
                  ),
                ),
                for (int i = 0; i < widget.category.length; i++) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    child: Tab(
                      text: widget.category[i],
                    ),
                  ),
                ]
              ],
            ),
          ),
        ),
        Expanded(
          child: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _tabController,
            children: [
              /// All Products Items Grid View
              GridView.builder(
                itemCount: provider.allProducts.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemBuilder: (_, i) {
                  final product = provider.allProducts[i];

                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        RouteConfig.details,
                        arguments: product,
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(
                            child: CachedNetworkImage(
                              imageUrl: product.image,
                              fit: BoxFit.cover,
                              progressIndicatorBuilder:
                                  (context, url, progress) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${product.title.substring(0, 16)}...",
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                              Text("\$ ${product.price}"),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),

              /// Filter by category

              for (int i = 0; i < widget.category.length; i++) ...[
                GridView.builder(
                  shrinkWrap: true,
                  itemCount: provider.filterProducts.length,
                  semanticChildCount: 0,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (_, index) {
                    final product = provider.filterProducts[index];

                    return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(
                            child: CachedNetworkImage(
                              imageUrl: product.image,
                              fit: BoxFit.cover,
                              progressIndicatorBuilder:
                                  (context, url, progress) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${product.title.substring(0, 16)}...",
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                              Text("\$ ${product.price}"),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                ),
              ]
            ],
          ),
        )
      ],
    );
  }
}
