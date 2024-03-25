import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mini_ecommerce_app_assignment/core/routes/route_config.dart';
import 'package:mini_ecommerce_app_assignment/features/product/data/models/product_model.dart';
import 'package:mini_ecommerce_app_assignment/features/product/presentation/providers/product_provider.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final StreamController<List<ProductModel>> _streamController =
      StreamController.broadcast();

  final FocusNode _searchFocus = FocusNode();
  final TextEditingController _textEditingController = TextEditingController();

  late ProductsProvider provider;

  @override
  void initState() {
    _searchFocus.requestFocus();
    provider = context.read<ProductsProvider>();
    super.initState();
  }

  @override
  void dispose() {
    _searchFocus.dispose();
    _textEditingController.dispose();
    _streamController.sink.close();
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          splashRadius: 20,
          icon: const Icon(Icons.arrow_back),
          onPressed: Navigator.of(context).pop,
        ),
        leadingWidth: 32,
        title: SizedBox(
          height: 50,
          child: TextField(
            controller: _textEditingController,
            focusNode: _searchFocus,
            decoration: InputDecoration(
              prefixIcon: const Icon(
                Icons.search,
                size: 24,
                color: Colors.grey,
              ),
              suffix: IconButton(
                icon: const Icon(
                  Icons.close,
                  size: 24,
                  color: Colors.grey,
                ),
                onPressed: () {
                  _textEditingController.clear();
                  _streamController.sink.add([]);
                },
              ),
            ),
            onChanged: (value) => _streamController.sink.add(
              provider.search(value),
            ),
          ),
        ),
      ),
      body: StreamBuilder<List<ProductModel>>(
        stream: _streamController.stream,
        builder: (context, snapshot) {
          final searchData = snapshot.data;

          if (searchData == null) return const SizedBox();

          return ListView.builder(
            itemCount: searchData.length,
            itemBuilder: (_, index) {
              return ListTile(
                onTap: () {
                  Navigator.of(context).pushNamed(
                    RouteConfig.details,
                    arguments: searchData[index],
                  );
                },
                title: Text(
                  searchData[index].title,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
