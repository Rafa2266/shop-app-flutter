import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/component/app_drawer.dart';
import 'package:shop/component/bag.dart';
import 'package:shop/component/product_grid.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/utils/app_routes.dart';

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
            ),
            Consumer<Cart>(
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRoutes.CART);
                },
                icon: const Icon(Icons.shopping_cart),
              ),
              builder: (ctx, cart, child) => Bag(
                value: cart.itemsCount.toString(),
                child: child!,
              ),
            )
          ],
        ),
        body: ProductGrid(
          showfavoriteOnly: _showFavoriteOnly,
        ),
        drawer: AppDrawer());
  }
}
