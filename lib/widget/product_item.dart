import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/screen/product_detail_screen.dart';
import '/provider/cart.dart';
import '/provider/product.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDetailScreen.routeName,
              arguments: product.id,
            );
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: Consumer<Product>(
            builder: (ctx, product, child) => IconButton(
              icon: Icon(
                product.isFavourite
                    ? Icons.favorite_outlined
                    : Icons.favorite_outline,
                color: Theme.of(context).accentColor,
              ),
              onPressed: () {
                product.toggleFavourite();
              },
            ),
          ),
          title: Container(
            height: 15,
            child: FittedBox(
              child: Text(
                product.title,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          trailing: IconButton(
            onPressed: () {
              cart.addItem(product.id, product.price, product.title);
            },
            icon: Icon(Icons.shopping_cart),
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
    );
  }
}
