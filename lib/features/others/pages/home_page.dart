import 'package:flutter/material.dart';
import 'package:mini_ecommerce_app_assignment/features/others/providers/home_nav_provider.dart';
import 'package:mini_ecommerce_app_assignment/features/others/views/home_view.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

List<Widget> _views = [
  const HomeView(),
  Container(),
  Container(),
  Container(),
];

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Discover",
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const PhosphorIcon(PhosphorIconsRegular.bell),
          )
        ],
      ),
      body: Consumer<HomeNavProvider>(
        builder: (context, provider, child) => _views[provider.currentIndex],
      ),
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: Consumer<HomeNavProvider>(
        builder: (context, provider, _) {
          return BottomNavigationBar(
            currentIndex: provider.currentIndex,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.grey,
            showUnselectedLabels: true,
            onTap: provider.changeBottomNav,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite_border),
                label: "Wishlist",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  PhosphorIconsRegular.shoppingBag,
                ),
                label: "Cart",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: "Setting",
              ),
            ],
          );
        },
      ),
    );
  }
}
