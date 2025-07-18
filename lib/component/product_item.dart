import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/product.dart';
import 'package:shop/models/product_list.dart';
import 'package:shop/utils/app_routes.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  const ProductItem(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(product.imageUrl),
      ),
      title: Text(product.name),
      trailing: SizedBox(
        width: 100,
        child: Row(children: [
          IconButton(
            icon: const Icon(Icons.edit),
            color: Theme.of(context).colorScheme.primary,
            onPressed: () {
              Navigator.of(context).pushNamed(
                AppRoutes.PRODUCT_FORM,
                arguments: product,
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            color: Theme.of(context).colorScheme.error,
            onPressed: () {
              showDialog<bool>(
                  context: context,
                  builder: (_) {
                    return AlertDialog(
                      title: Text("Deseja excluir o produto ${product.name}?"),
                      actions: [
                        TextButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: const Text("Não")),
                        TextButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            child: const Text("Sim"))
                      ],
                    );
                  }).then((value) {
                if (value ?? false) {
                  Provider.of<ProductList>(context, listen: false)
                      .removeProduct(product);
                }
              });
            },
          )
        ]),
      ),
    );
  }
}
