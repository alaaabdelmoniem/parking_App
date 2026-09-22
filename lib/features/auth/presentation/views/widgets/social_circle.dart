import 'package:flutter/material.dart';

class SocialCircle extends StatelessWidget {
  final Widget icon;
  final VoidCallback onTap;

  const SocialCircle({super.key, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(30),
      onTap: onTap,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(color: const Color(0xFFE3E5EC)),
        ),
        alignment: Alignment.center,
        child: icon,
      ),
    );
  }
}
