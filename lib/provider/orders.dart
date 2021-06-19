import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/widget/order_items.dart';

import '/provider/cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  var _orders = [];

  List<OrderItem> get order {
    return [..._orders];
  }

  Future<void> addOrder(List<CartItem> cartProduct, double total) async {
    final url =
        Uri.https('my-shop-d249d-default-rtdb.firebaseio.com', '/orders.json');
    final timeStamp = DateTime.now();
    final response = await http.post(
      url,
      body: json.encode({
        'amount': total,
        'dateTime': timeStamp.toIso8601String(),
        'products': cartProduct
            .map((cp) => {
                  'id': cp.id,
                  'title': cp.title,
                  'quantity': cp.quantity,
                  'price': cp.price,
                })
            .toList(),
      }),
    );
    _orders.insert(
      0,
      OrderItem(
        id: json.decode(response.body)['name'],
        amount: total,
        products: cartProduct,
        dateTime: timeStamp,
      ),
    );
    notifyListeners();
  }

  Future<void> fetchOrders() async {
    final url =
        Uri.https('my-shop-d249d-default-rtdb.firebaseio.com', '/orders.json');

    final response = await http.get(url);
    final List<OrderItem> loadedItems = [];
    final extractdData = json.decode(response.body) as Map<String, dynamic>;
    if (extractdData == null) {
      return;
    }
    extractdData.forEach(
      (orderId, orderData) {
        loadedItems.add(
          OrderItem(
            id: orderId,
            amount: orderData['amount'],
            products: (orderData['products'] as List<dynamic>)
                .map(
                  (items) => CartItem(
                    id: items['id'],
                    price: items['price'],
                    quantity: items['quantity'],
                    title: items['title'],
                  ),
                )
                .toList(),
            dateTime: DateTime.parse(
              orderData['dateTime'],
            ),
          ),
        );
      },
    );
    _orders = loadedItems.reversed.toList();
    notifyListeners();
  }
}
