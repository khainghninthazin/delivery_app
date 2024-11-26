import 'package:flutter/material.dart';

class DeliveryProgressPage extends StatelessWidget {
  const DeliveryProgressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Delivery Progress"),
        backgroundColor: Colors.green, // Set an appropriate color for your theme
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.green[50], // Soft background color
                borderRadius: BorderRadius.circular(8), // Rounded corners for aesthetics
              ),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      'Thank you!',
                      style: TextStyle(color: Colors.green, fontSize: 30),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Your transaction was successful!',
                    style: TextStyle(
                        color: const Color.fromARGB(255, 76, 175, 127),
                        fontSize: 15),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[100], // Lighter background for the ListTiles
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          title: Text('Date'),
                          subtitle: Text('12 November 2024'),
                          trailing: Text('8:46 PM'),
                        ),
                        ListTile(
                          title: Text('Date'),
                          subtitle: Text('12 November 2024'),
                          trailing: Text('8:46 PM'),
                        ),
                        ListTile(
                          title: Text('Date'),
                          subtitle: Text('12 November 2024'),
                          trailing: Text('8:46 PM'),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  Container(
                    
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Ensure the correct image path for the asset
                        Expanded(
                          child: Container(
                            height: 50,
                            child: Image.asset(
                              'assets/kpay.webp', // Update with your image path
                              // width: 20,
                              // height: 20,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text('Payment Method:'),
                              Text(
                                'Credit/Debit Card',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Go back to the previous page
              },
              child: const Text("Go Back"),
            ),
          ],
        ),
      ),
    );
  }
}
