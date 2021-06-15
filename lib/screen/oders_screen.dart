import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/widget/app_drawer.dart';
import '/provider/orders.dart' show Orders;
import '/widget/order_items.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    final ordersData = Provider.of<Orders>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemBuilder: (ctx, i) {
          return OrderItems(ordersData.order[i]);
        },
        itemCount: ordersData.order.length,
      ),
    );
  }
}
