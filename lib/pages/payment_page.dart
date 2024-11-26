import 'package:delivery_app/pages/delivery_progress_page.dart';
import 'package:delivery_app/pages/my_reciept.dart';
import 'package:delivery_app/pages/mybutton.dart';
import 'package:flutter/material.dart';
 // Assuming you have a MyButton widget

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String selectedPaymentMethod = ''; // Track the selected payment method

  // Function to handle the selected payment method
  void handlePaymentMethod(String method) {
    setState(() {
      selectedPaymentMethod = method;
    });
  }

  // Function to confirm payment
  void userTappedPay() {
    if (selectedPaymentMethod.isNotEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Confirm Payment'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text('Payment Method: $selectedPaymentMethod'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DeliveryProgressPage(),
                  ),
                );
              },
              child: const Text('Confirm'),
            ),
          ],
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a payment method.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Checkout'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Payment options (KPay, WavePay)
            ListTile(
              title: Text('Pay with KPay'),
              leading: Icon(Icons.payment),
              onTap: () => handlePaymentMethod('KPay'),
              selected: selectedPaymentMethod == 'KPay',
            ),
            ListTile(
              title: Text('Pay with WavePay'),
              leading: Icon(Icons.payment),
              onTap: () => handlePaymentMethod('WavePay'),
              selected: selectedPaymentMethod == 'WavePay',
            ),
            const SizedBox(height: 20),
            // Payment confirmation button
            MyButton(
              text: 'Pay Now',
              onTap: userTappedPay,
            ),
            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}
