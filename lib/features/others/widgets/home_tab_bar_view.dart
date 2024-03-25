import 'package:flutter/material.dart';
import 'package:mini_ecommerce_app_assignment/features/others/widgets/product_card.dart';
import 'package:mini_ecommerce_app_assignment/features/product/presentation/providers/product_provider.dart';
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
  late ProductsProvider provider;

  @override
  void initState() {
    provider = context.read<ProductsProvider>();
    _tabController =
        TabController(length: widget.category.length + 1, vsync: this);

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        _tabController.index == 0
            ? provider.filterByCategory("All")
            : provider.filterByCategory(
                provider.productCategory![_tabController.index - 1]);
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
          child: provider.filterProducts.isEmpty && provider.isFilterBy
              ? const Center(
                  child: Text("No product found!"),
                )
              : GridView.builder(
                  itemCount: provider.isFilterBy
                      ? provider.filterProducts.length
                      : _tabController.index == 0
                          ? provider.allProducts.length
                          : provider.filterProducts.length,
                  padding: const EdgeInsets.all(8),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (_, i) {
                    final product = provider.isFilterBy
                        ? provider.filterProducts[i]
                        : _tabController.index == 0
                            ? provider.allProducts[i]
                            : provider.filterProducts[i];

                    return ProductCard(product: product);
                  },
                ),
        ),

        //
      ],
    );
  }
}
