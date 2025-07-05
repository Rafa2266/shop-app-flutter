import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/component/app_drawer.dart';
import 'package:shop/component/product_item.dart';
import 'package:shop/models/product_list.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductList products = Provider.of<ProductList>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerenciar produtos'),
      ),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: products.itemsCount,
          itemBuilder: (ctx, i) => Column(
            children: [ProductItem(products.items[i]), Divider()],
          ),
        ),
      ),
    );
  }
}
