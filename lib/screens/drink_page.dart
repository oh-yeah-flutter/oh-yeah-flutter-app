import 'package:flutter/material.dart';

class DrinkPage extends StatelessWidget {
  const DrinkPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("DRINK"),
        backgroundColor: const Color(0xFF7b5a36),
      ),

      body: Container(
        color: const Color(0xFFF5E9DA),
        child: const Center(
          child: Text(
            "Drink Menu",
            style: TextStyle(fontSize: 22),
          ),
        ),
      ),
    );
  }
}