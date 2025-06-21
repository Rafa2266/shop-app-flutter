import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/component/product_grid.dart';
import 'package:shop/models/product_list.dart';

enum FilterOptions { Favorite, All }

class ProductsOverViewPage extends StatefulWidget {
  const ProductsOverViewPage({super.key});

  @override
  State<ProductsOverViewPage> createState() => _ProductsOverViewPageState();
}

class _ProductsOverViewPageState extends State<ProductsOverViewPage> {
  bool _showFavoriteOnly = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minha loja'),
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            itemBuilder: (_) => [
              const PopupMenuItem(
                value: FilterOptions.Favorite,
                child: Text("Somente favoritos"),
              ),
              const PopupMenuItem(
                value: FilterOptions.All,
                child: Text("Todos"),
              ),
            ],
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.Favorite) {
                  _showFavoriteOnly = true;
                } else {
                  _showFavoriteOnly = false;
                }
              });
            },
          )
        ],
      ),
      body: ProductGrid(
        showfavoriteOnly: _showFavoriteOnly,
      ),
    );
  }
}
