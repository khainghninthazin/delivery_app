import 'package:delivery_app/pages/food.dart';
import 'package:delivery_app/pages/mybutton.dart';
import 'package:delivery_app/pages/restaurants.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class FoodPage extends StatefulWidget {
  final Food food;

  FoodPage({super.key, required this.food});

  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  late Map<Addon, bool> selectedAddons; // Use late for initialization in initState

  @override
  void initState() {
    super.initState();
    // Initialize the selectedAddons map
    selectedAddons = {
      for (Addon addon in widget.food.availableAddons) addon: false,
    };
  }

  void addToCart(Food food, Map<Addon, bool> selectedAddons) {
    List<Addon> currentlySelectedAddons = [];

    // Collect selected addons
    selectedAddons.forEach((addon, isSelected) {
      if (isSelected) currentlySelectedAddons.add(addon);
    });

    // Add to cart using the context
    context.read<Restaurant>().addToCart(food, currentlySelectedAddons);

    // Return to the previous screen
    Navigator.pop(context);
  }


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(widget.food.imagePath),
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.food.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Text(
                        '\$${widget.food.price.toStringAsFixed(2)}',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 15),
                      ),
                      const SizedBox(height: 15),
                      Text(widget.food.description),
                      const SizedBox(height: 15),
                      Divider(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      const SizedBox(height: 15),
                      Text(
                        "Add-ons",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color:
                                Theme.of(context).colorScheme.inversePrimary),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: widget.food.availableAddons.length,
                          itemBuilder: (context, index) {
                            // Get individual addon
                            Addon addon = widget.food.availableAddons[index];

                            return CheckboxListTile(
                              title: Text(addon.name),
                              subtitle: Text(
                                '\$${addon.price.toStringAsFixed(2)}',
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary),
                              ),
                              value: selectedAddons[addon],
                              onChanged: (bool? value) {
                                setState(() {
                                  selectedAddons[addon] = value ?? false;
                                });
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                MyButton(
                  text: "Add to cart",
                  // onTap: () {
                  //   addToCart(widget.food,selectedAddons);
                  // },
                  onTap: ()=>addToCart(widget.food, selectedAddons),
                ),
                const SizedBox(height: 25),
              ],
            ),
          ),
        ),
        SafeArea(
          child: Container(
            margin: const EdgeInsets.only(left: 20),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios_outlined),
            ),
          ),
        ),
      ],
    );
  }
}
