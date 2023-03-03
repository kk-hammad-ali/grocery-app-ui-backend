import 'package:flutter/material.dart';
import 'package:grocery/screens/cart/components/full_cart.dart';

class BodyCartScreen extends StatelessWidget {
  const BodyCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return const FullCart();
      },
    );
  }
}
