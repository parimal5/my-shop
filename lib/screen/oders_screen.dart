import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/widget/app_drawer.dart';
import '/provider/orders.dart' show Orders;
import '/widget/order_items.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: Provider.of<Orders>(context, listen: false).fetchOrders(),
        builder: (ctx, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (dataSnapshot.error != null) {
              // Do Error Handling
              return Center(
                child: Text('Error Occurred'),
              );
            } else {
              return Consumer<Orders>(
                builder: (ctx, ordersData, child) => ListView.builder(
                  itemBuilder: (ctx, i) => OrderItems(ordersData.order[i]),
                  itemCount: ordersData.order.length,
                ),
              );
            }
          }
        },
      ),
    );
  }
}
