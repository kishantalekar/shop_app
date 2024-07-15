import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart_provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    print(Provider.of<CartProvider>(context).cart.length);
    print(Provider.of<CartProvider>(context).cart);
    return Scaffold(
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: Provider.of<CartProvider>(context).cart.length,
        itemBuilder: (context, index) {
          final cartItem = Provider.of<CartProvider>(context).cart[index];

          return Dismissible(
            key: Key(cartItem.toString()),
            onDismissed: (direction) {
              Provider.of<CartProvider>(context, listen: false)
                  .removeProduct(cartItem);
            },
            direction: DismissDirection.endToStart,
            background: Container(
              color: Colors.red,
              child: Align(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                    Text(
                      " Delete",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.right,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                  ],
                ),
                alignment: Alignment.centerRight,
              ),
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage(cartItem['imageUrl'] as String),
                radius: 30,
              ),
              title: Text(
                cartItem['title'] as String,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              subtitle: Text("Size: ${cartItem['size']}"),
            ),
          );
        },
      ),
    );
  }
}
