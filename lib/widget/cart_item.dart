import 'package:flutter/material.dart';

class CartItems extends StatelessWidget {
  final String id;
  final String title;
  final double price;
  final int quantity;

  CartItems({
    this.id,
    this.price,
    this.quantity,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(
        vertical: 4,
        horizontal: 15,
      ),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: ListTile(
          leading: CircleAvatar(
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: FittedBox(child: Text('Rs. $price')),
            ),
          ),
          title: Text(title),
          subtitle: Text('Total: Rs. ${price * quantity}'),
          trailing: Text('$quantity x'),
        ),
      ),
    );
  }
}
