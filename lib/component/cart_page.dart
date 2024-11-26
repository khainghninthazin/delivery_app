import 'package:delivery_app/component/my_cart_tile.dart';
import 'package:delivery_app/pages/mybutton.dart';
import 'package:delivery_app/pages/payment_page.dart';
import 'package:delivery_app/pages/restaurants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Restaurant>(builder: (context, restaurant, child) {
      // Cart
      final userCart = restaurant.cart ?? []; // Use an empty list if cart is null

      // Scaffold UI
      return Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text("Cart"),
          ),
          backgroundColor: Colors.transparent,
          foregroundColor: Theme.of(context).colorScheme.inversePrimary,
          actions: [
            IconButton(
              onPressed: () {
                if (userCart.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Cart is already empty!")),
                  );
                } else {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Are you sure you want to clear the cart?"),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("Cancel"),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            restaurant.clearCart();
                          },
                          child: const Text("Yes"),
                        ),
                      ],
                    ),
                  );
                }
              },
              icon: const Icon(Icons.delete),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: userCart.isEmpty
                  ? const Center(
                      child: Text("Cart is Empty"),
                    )
                  : ListView.builder(
                      itemCount: userCart.length,
                      itemBuilder: (context, index) {
                        // Get individual cart item
                        final cartItem = userCart[index];

                        // Return cart tile UI
                        return MyCartTile(cartitem: cartItem, onIncrement: () {  }, onDecrement: () {  },);
                      },
                    ),
            ),
            MyButton(
              text: "Go to check out",
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PaymentPage()),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      );
    });
  }
}
