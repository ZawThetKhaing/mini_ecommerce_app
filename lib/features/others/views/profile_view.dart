import 'package:flutter/material.dart';
import 'package:mini_ecommerce_app_assignment/core/routes/route_config.dart';
import 'package:mini_ecommerce_app_assignment/features/auth/data/model/user_model.dart';
import 'package:mini_ecommerce_app_assignment/features/auth/presentation/provider/auth_provider.dart';
import 'package:mini_ecommerce_app_assignment/features/others/widgets/profile_list_tile.dart';

import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final UserModel userModel = context.read<AuthProvider>().user!;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const PhosphorIcon(
              PhosphorIconsRegular.bell,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: const Center(
                          child: Icon(
                            PhosphorIconsRegular.userCircle,
                            size: 80,
                          ),
                        ),
                      ),
                      Text(
                        userModel.name,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                const Text('Profile'),
                const SizedBox(height: 8),
                ProfileListTile(
                  icon: Icons.person_outline_outlined,
                  title: "My Profile",
                  onTap: () {},
                ),
                ProfileListTile(
                  icon: PhosphorIconsRegular.shoppingBagOpen,
                  title: "Orders",
                  onTap: () {},
                ),
                ProfileListTile(
                  icon: PhosphorIconsRegular.gear,
                  title: "Settings",
                  onTap: () {},
                ),
                const SizedBox(height: 8),
                const Text('Others'),
                const SizedBox(height: 8),
                ProfileListTile(
                  icon: PhosphorIconsRegular.shieldStar,
                  title: "Terms and Conditions",
                  onTap: () {},
                ),
                ProfileListTile(
                  icon: PhosphorIconsRegular.phone,
                  title: "Contact Us",
                  onTap: () {},
                ),
                ProfileListTile(
                  icon: PhosphorIconsRegular.info,
                  title: "About",
                  onTap: () {},
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: ElevatedButton(
                onPressed: () async {
                  try {
                    await context.read<AuthProvider>().logout();
                    if (!context.mounted) return;
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        RouteConfig.wrapper, (route) => false);
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Logout Failed!"),
                      ),
                    );
                  }
                },
                child: const Text("Logout"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
