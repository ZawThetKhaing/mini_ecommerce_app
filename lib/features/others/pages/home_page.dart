import 'package:flutter/material.dart';
import 'package:mini_ecommerce_app_assignment/features/auth/presentation/provider/auth_provider.dart';
import 'package:mini_ecommerce_app_assignment/features/others/providers/home_nav_provider.dart';
import 'package:mini_ecommerce_app_assignment/features/others/views/cart_view.dart';
import 'package:mini_ecommerce_app_assignment/features/others/views/home_view.dart';
import 'package:mini_ecommerce_app_assignment/features/others/views/profile_view.dart';
import 'package:mini_ecommerce_app_assignment/features/others/views/wish_list_view.dart';
import 'package:mini_ecommerce_app_assignment/features/payment/presentation/providers/payment_provider.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

List<Widget> _views = [
  const HomeView(),
  const CartView(),
  const WishListView(),
  const ProfileView(),
];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context
        .read<PaymentProvider>()
        .watchOrder(context.read<AuthProvider>().user?.id ?? '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                  icon: Icon(
                    PhosphorIconsRegular.shoppingBag,
                  ),
                  label: "Cart",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite_border),
                  label: "Wishlist",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: "Profile",
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
