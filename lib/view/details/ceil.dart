import 'package:flutter/material.dart';

class Detail1 extends StatefulWidget {
  const Detail1({super.key});

  @override
  State<Detail1> createState() => _Detail1State();
}

class _Detail1State extends State<Detail1> with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.brown,
      body: Text('Page1'),
    );
  }
}
