import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final Function() onTap;
  final Widget child;
  const LoginButton({super.key, required this.onTap, required this.child});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        width: size.width * 0.9,
        decoration: BoxDecoration(
          color: const Color(0xff439A97),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: child,
        ),
      ),
    );
  }
}
