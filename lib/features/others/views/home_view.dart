import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mini_ecommerce_app_assignment/features/others/widgets/home_tab_bar_view.dart';
import 'package:mini_ecommerce_app_assignment/features/product/presentation/providers/get_product_provider.dart';
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
              Container(
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
            ],
          ),

          Expanded(
            child: Consumer<GetProductsProvider>(
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

          // Center(
          //   child: ElevatedButton(
          //       onPressed: () async {
          //         try {
          //           await authProvider.logout();
          //           if (!context.mounted) return;
          //           Navigator.of(context)
          //               .pushNamedAndRemoveUntil('/login', (route) => false);
          //         } catch (e) {
          //           //  ToDo ::
          //         }
          //       },
          //       child: Text("Logout")),
          // )
        ],
      ),
    );
  }
}
