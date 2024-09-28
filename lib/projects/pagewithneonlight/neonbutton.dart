import 'dart:math';

import 'package:flutter/material.dart';
class NeonButton extends StatefulWidget {
  const NeonButton({super.key});

  @override
  _NeonButtonState createState() => _NeonButtonState();
}

class _NeonButtonState extends State<NeonButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    // Initialize the AnimationController
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(); // Repeat the animation indefinitely
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is removed
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Set the screen background to black
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: SweepGradient(
                  colors: [
                    Colors.cyan,
                    Colors.purple,
                    Colors.cyan,
                    Colors.purple,
                    Colors.cyan,
                  ],
                  stops: const [0.0,0.25, 0.5, 0.75, 1.0],
                  transform: GradientRotation(_controller.value * 2 * pi),
                ),
                boxShadow: [
                  // Optional: Add glow effects to enhance the neon look
                  BoxShadow(
                    color: Colors.cyan.withOpacity(0.6),
                    spreadRadius: 4,
                    blurRadius: 20,
                  ),
                  BoxShadow(
                    color: Colors.purple.withOpacity(0.6),
                    spreadRadius: 4,
                    blurRadius: 20,
                  ),
                ],
              ),
              padding: const EdgeInsets.all(3), // Border width
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black, // Button background color
                  foregroundColor: Colors.white, // Button text color
                  shadowColor: Colors.transparent, // Remove default shadow
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0, // Remove elevation to use custom border
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                onPressed: () {
                  // Define your onPressed action here
                },
                child: const Text(
                  "Button",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}