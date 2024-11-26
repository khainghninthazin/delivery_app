import 'package:delivery_app/pages/restaurants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
 // Replace with your actual Restaurant provider model import

class MyReceipt extends StatelessWidget {
  const MyReceipt({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Receipt'),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 50.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Thank you for your order!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 25),
            Consumer<Restaurant>(
              builder: (context, restaurant, child) => Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).colorScheme.secondary,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(25),
                child: Text(
                  restaurant.displayCartReceipt(),
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 25),
            Text(
              'Estimated delivery time is: ${_getEstimatedDeliveryTime()}',
              style: const TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  String _getEstimatedDeliveryTime() {
    final now = DateTime.now();
    final estimatedTime = now.add(const Duration(minutes: 30)); // Example: 30 minutes delivery estimate
    final hour = estimatedTime.hour % 12 == 0 ? 12 : estimatedTime.hour % 12;
    final minute = estimatedTime.minute.toString().padLeft(2, '0');
    final period = estimatedTime.hour >= 12 ? 'PM' : 'AM';
    return "$hour:$minute $period";
  }
}
