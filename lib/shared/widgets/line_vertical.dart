import 'package:flutter/material.dart';

class LineVertical extends StatelessWidget {
  const LineVertical({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 0.5,
      margin: const EdgeInsets.symmetric(vertical: 0),
      color: const Color.fromARGB(255, 156, 152, 152).withValues(alpha: 0.4),
    );
  }
}
