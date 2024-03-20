import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:mini_ecommerce_app_assignment/features/auth/presentation/provider/auth_provider.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.read<AuthProvider>();
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                const Expanded(
                    child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                      size: 24,
                    ),
                    hintText: "Search anything",
                  ),
                )),
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

            TabBar(
              labelColor: Colors.white,
              unselectedLabelColor: Colors.black,
              controller: _tabController,
              indicatorPadding: EdgeInsets.zero,
              indicator: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(8),
              ),
              tabs: [
                Tab(
                  child: Container(
                    width: 72,
                    height: 38,
                    alignment: Alignment.center,
                    child: const Text(
                      "All",
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    width: 72,
                    height: 38,
                    alignment: Alignment.center,
                    child: const Text(
                      "Men",
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    width: 72,
                    height: 38,
                    alignment: Alignment.center,
                    child: const Text(
                      "Women",
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    width: 72,
                    height: 38,
                    alignment: Alignment.center,
                    child: const Text(
                      "Kids",
                    ),
                  ),
                ),
              ],
            )

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
      ),
    );
  }
}
