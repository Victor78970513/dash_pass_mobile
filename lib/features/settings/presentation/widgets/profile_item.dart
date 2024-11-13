import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileItem extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final IconData icon;
  const ProfileItem({
    super.key,
    required this.title,
    required this.controller,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon),
              const SizedBox(width: 10),
              Text(
                title,
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xffE1EBF5),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(4, 4),
                  blurRadius: 20,
                  color: Colors.black.withOpacity(0.1),
                )
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                controller: controller,
                style: GoogleFonts.poppins(color: Colors.black),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
