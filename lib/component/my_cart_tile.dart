import 'package:delivery_app/component/my_quantity_selector.dart';
import 'package:flutter/material.dart';
import 'package:delivery_app/pages/cartitem.dart';

class MyCartTile extends StatelessWidget {
  final CartItem cartitem;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const MyCartTile({
    Key? key,
    required this.cartitem,
    required this.onIncrement,
    required this.onDecrement,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  cartitem.food.imagePath,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Icon(
                    Icons.image_not_supported,
                    size: 60,
                    color: Colors.grey,
                  ),
                ),
              ),
              const SizedBox(width: 12),

              // Product Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cartitem.food.name,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Price: \$${cartitem.food.price.toStringAsFixed(2)}",
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 4),
                    if (cartitem.selectedAddons.isNotEmpty)
                      Wrap(
                        spacing: 8.0,
                        children: cartitem.selectedAddons.map((addon) {
                          return Chip(
                            label: Text(
                              "${addon.name} (\$${addon.price.toStringAsFixed(2)})",
                              style: TextStyle(fontSize: 12),
                            ),
                          );
                        }).toList(),
                      ),
                  ],
                ),
              ),

              // Quantity Selector
              MyQuantitySelector(
                quantity: cartitem.quantity ?? 0,
                onIncrement: onIncrement,
                onDecrement: onDecrement,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
