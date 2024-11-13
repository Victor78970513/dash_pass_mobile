import 'package:flutter/material.dart';

class DrawerWdiget extends StatelessWidget {
  final String userName;
  const DrawerWdiget({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w500,
      fontSize: 18,
    );
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          decoration: const BoxDecoration(
            color: Color(0xff0B6D6D),
          ),
          child: Column(
            children: [
              const CircleAvatar(
                radius: 50,
              ),
              const SizedBox(height: 10),
              Text(
                userName.toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
        ListTile(
          leading: const Icon(
            Icons.person_outline_rounded,
            size: 35,
          ),
          title: const Text(
            'Mi Perfil',
            style: textStyle,
          ),
          onTap: () {},
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Divider(),
        ),
        ListTile(
          leading: const Icon(
            Icons.help_outline_rounded,
            size: 35,
          ),
          title: const Text(
            'Ayuda y soporte',
            style: textStyle,
          ),
          onTap: () {},
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Divider(),
        ),
        ListTile(
          leading: const Icon(
            Icons.error_outline,
            size: 35,
          ),
          title: const Text(
            'Sobre nosotros',
            style: textStyle,
          ),
          onTap: () {},
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Divider(),
        ),
        ListTile(
          leading: const Icon(
            Icons.logout_outlined,
            size: 35,
          ),
          title: const Text(
            'Cerrar sesion',
            style: textStyle,
          ),
          onTap: () {},
        ),
      ],
    );
  }
}
