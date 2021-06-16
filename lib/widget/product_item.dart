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
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(
                product.imageUrl,
                fit: BoxFit.cover,
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Consumer<Product>(
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
              ),
            ],
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
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
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Added Item To Cart'),
                  duration: Duration(seconds: 2),
                  action: SnackBarAction(
                    label: 'Undo',
                    onPressed: () => cart.removeSingleItem(product.id),
                  ),
                ),
              );
            },
            icon: Icon(Icons.shopping_cart),
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
    );
  }
}
