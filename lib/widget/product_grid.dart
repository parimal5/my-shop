import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/provider/products.dart';
import '/widget/product_item.dart';

class ProductsGrid extends StatelessWidget {
  final bool showFavourite;

  ProductsGrid(this.showFavourite);

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ProductsProvider>(context);

    final products =
        showFavourite ? productData.favouriteItems : productData.items;

    return GridView.builder(
      padding: EdgeInsets.all(20),
      itemCount: products.length,
      itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
        // create: (ctx) => products[index],
        value: products[index],
        child: ProductItem(),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.5,
        crossAxisSpacing: 10,
        mainAxisSpacing: 50,
      ),
    );
  }
}
