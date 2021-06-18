import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/screen/edit_product_scrren.dart';

import '/widget/app_drawer.dart';
import '/widget/user_product_item.dart';
import '/provider/products.dart';

class UserProductScreen extends StatelessWidget {
  static const routeName = '/user-products';

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Product'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 2,
        ),
        child: ListView.builder(
          itemBuilder: (ctx, i) {
            return UserProductItem(
              productsData.items[i].title,
              productsData.items[i].imageUrl,
              productsData.items[i].id,
            );
          },
          itemCount: productsData.items.length,
        ),
      ),
    );
  }
}
