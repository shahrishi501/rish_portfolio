import 'package:flutter/material.dart';

class MiniIcon extends StatelessWidget {
  final IconData icon;
  final Color color;

  const MiniIcon(this.icon, this.color, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Icon(
        icon,
        color: Colors.white,
        size: 16,
      ),
    );
  }
}