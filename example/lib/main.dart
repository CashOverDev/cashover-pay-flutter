import 'package:flutter/material.dart';
import 'package:cashover_pay_flutter/cashover_pay_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'CashOver SDK Example', home: const HomePage());
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('CashOver SDK Example')),
      body: Center(
        child: CashOverPayButton(
          merchantUsername: 'salah.eldine.naoushi',
          storeUsername: 'store456',
          amount: 49.99,
          currency: 'USD',
          metadata: {'orderId': 'A1001'},
          //buttonColor: Colors.blue,
          //textColor: Colors.white,
          //borderRadius: 12,
          language: 'en',
        ),
      ),
    );
  }
}
