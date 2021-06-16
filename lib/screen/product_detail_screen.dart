import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/provider/products.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product-detail';

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as String;
    final loadedProduct = Provider.of<ProductsProvider>(
      context,
      listen: false,
    ).findByID(productId);

    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              height: 300,
              width: double.infinity,
              child: Image.network(
                loadedProduct.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Rs. ${loadedProduct.price}',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              width: 340,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black12,
                  width: 3,
                ),
              ),
              child: Text(
                '${loadedProduct.description}',
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
