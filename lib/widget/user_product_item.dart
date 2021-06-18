import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/provider/products.dart';
import '/screen/edit_product_scrren.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  UserProductItem(this.title, this.imageUrl, this.id);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: ListTile(
          title: Text(title),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(imageUrl),
          ),
          trailing: Container(
            width: 100,
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(EditProductScreen.routeName, arguments: id);
                  },
                  icon: Icon(Icons.edit),
                  color: Theme.of(context).primaryColor,
                ),
                IconButton(
                  onPressed: () {
                    Provider.of<ProductsProvider>(context, listen: false)
                        .deleteProducts(id);
                  },
                  icon: Icon(Icons.delete),
                  color: Theme.of(context).errorColor,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
