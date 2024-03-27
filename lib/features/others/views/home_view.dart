import 'package:flutter/material.dart';
import 'package:mini_ecommerce_app_assignment/features/others/widgets/home_tab_bar_view.dart';
import 'package:mini_ecommerce_app_assignment/features/others/widgets/notification_icon.dart';
import 'package:mini_ecommerce_app_assignment/features/product/presentation/providers/product_provider.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Discover",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const NotificationIcon(),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed('/search');
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Theme.of(context).splashColor,
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          "Search anything",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  showBottomSheet(
                    context: context,
                    builder: (_) => Consumer<ProductsProvider>(
                      builder: (context, provider, _) {
                        return Container(
                          padding: const EdgeInsets.all(8),
                          height: MediaQuery.of(context).size.height * 0.9,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.5),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(8),
                              bottomLeft: Radius.circular(8),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Filter by",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              Container(
                                margin: const EdgeInsets.symmetric(vertical: 8),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                color: Colors.white,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Category",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                              fontWeight: FontWeight.bold),
                                    ),
                                    provider.productCategory?.isEmpty == true
                                        ? const SizedBox()
                                        : DropdownButton(
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge,
                                            value: provider.dropDownValue == ''
                                                ? provider.productCategory![0]
                                                : provider.dropDownValue,
                                            isExpanded: true,
                                            items: provider.productCategory
                                                ?.map(
                                                  (e) => DropdownMenuItem(
                                                    value: e,
                                                    child: Text(
                                                      e.toString(),
                                                    ),
                                                  ),
                                                )
                                                .toList(),
                                            onChanged:
                                                provider.onDropDownChange,
                                          ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.symmetric(vertical: 4),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                color: Colors.white,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Rating",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                              fontWeight: FontWeight.bold),
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Slider(
                                            value: provider.ratingSliderValue,
                                            onChanged:
                                                provider.onRatingSliderChange,
                                          ),
                                        ),
                                        Text(
                                            "${(provider.ratingSliderValue * 10).toString().substring(0, 2)} %"),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.symmetric(vertical: 4),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                color: Colors.white,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Price",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                  "From \$ ${(provider.priceSliderStartValue * 1000).toString().split('.').first}"),
                                              Text(
                                                  "To \$ ${(provider.priceSliderEndValue * 1000).toString().split('.').first}"),
                                            ],
                                          ),
                                        ),
                                        RangeSlider(
                                          values: RangeValues(
                                            provider.priceSliderStartValue,
                                            provider.priceSliderEndValue,
                                          ),
                                          onChanged:
                                              provider.onPriceSliderChange,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                      Colors.black,
                                    ),
                                  ),
                                  onPressed: () {
                                    provider.filterProduct();
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    "Done",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                },
                child: Container(
                  width: 52,
                  height: 52,
                  margin: const EdgeInsets.only(left: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.black,
                  ),
                  child: const Icon(
                    Icons.filter_list,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Consumer<ProductsProvider>(
              builder: (context, provider, _) {
                return provider.allProducts.isEmpty
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : HomeTabBarView(
                        category: provider.productCategory ?? [],
                      );
              },
            ),
          ),
        ],
      ),
    );
  }
}
