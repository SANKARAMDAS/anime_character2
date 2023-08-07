import 'package:flutter/material.dart';

import '../consts.dart';

class AppBarButton extends StatelessWidget {
  final IconData icon;
  const AppBarButton({
    super.key,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 45,
      height: 45,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.5), color: white),
      child: Icon(
        icon,
        color: black.withOpacity(0.6),
      ),
    );
  }
}