import 'package:flutter/material.dart';

class CalculatorButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final Color? backgroundColor; // Add this property to control background color

  const CalculatorButton({
    Key? key,
    required this.text,
    this.onTap,
    this.backgroundColor, // Initialize the background color
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: backgroundColor, // Use the provided background color
        child: Center(
          child: Text(
            text,
            style: const TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
