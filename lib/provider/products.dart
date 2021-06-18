import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '/provider/product.dart';

class ProductsProvider with ChangeNotifier {
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Fc Barcelona T-Shirt',
      description: 'BARCELONA HOME JERSEY WITH MESSI PRINT 2020-21',
      price: 1500.00,
      imageUrl:
          'https://store.fcbarcelona.com/medias/21100M-MESSI-1.jpg?context=bWFzdGVyfGltYWdlc3wzMDkzMzh8aW1hZ2UvanBlZ3xoNzgvaDdjLzg4NjY4NzI1OTAzNjYvMjExMDBNX01FU1NJXzEuanBnfDY4ZjMxM2Y1ZDk3ZDQzNGI4YWE2YWQzNjNkZGFjNzEwMTJhNTE4NDVlMmI2YTQwYjk1ZDIxZjA0NjQxMTViNDA',
    ),
    Product(
      id: 'p2',
      title: 'Apple MacBook',
      description:
          '2020 Apple MacBook Pro (13-inch, 8GB RAM, 256GB SSD, 1.4GHz Quad-core 8th-Generation Intel Core i5 Processor, Two Thunderbolt 3 Ports) - Space Grey',
      price: 200000.00,
      imageUrl:
          'https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/macbook-pro-13-og-202011?wid=1200&hei=630&fmt=jpeg&qlt=95&.v=1604347427000',
    ),
    Product(
      id: 'p3',
      title: 'Coding T-shirt',
      description: 'Warm and cozy - exactly what you need.',
      price: 1200.00,
      imageUrl:
          'https://images-na.ssl-images-amazon.com/images/I/71xUgLxhY6L.jpg',
    ),
    Product(
      id: 'p4',
      title: 'Rasberry pi',
      description: 'Raspberry Pi 3 Model B+, SoC, IoT, PoE Enabled SBC.',
      price: 10000.00,
      imageUrl:
          'https://images-na.ssl-images-amazon.com/images/I/71IOISwSYZL._AC_SL1400_.jpg',
    ),
  ];

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favouriteItems {
    return _items.where((element) => element.isFavourite).toList();
  }

  Product findByID(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  void addProduct(Product product) {
    final newProduct = Product(
      id: DateTime.now().toString(),
      title: product.title,
      description: product.description,
      price: product.price,
      imageUrl: product.imageUrl,
    );
    _items.add(newProduct);
    notifyListeners();
  }

  void updateProduct(String id, Product newProduct) {
    final prodIndex = _items.indexWhere((element) => element.id == id);
    if (prodIndex >= 0) {
      _items[prodIndex] = newProduct;
      notifyListeners();
    }
  }

  void deleteProducts(String id) {
    _items.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
