import 'package:dash_pass/features/settings/presentation/widgets/profile_item.dart';
import 'package:dash_pass/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatefulWidget {
  final UserModel user;

  const ProfilePage({super.key, required this.user});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late TextEditingController nameCtrl;
  late TextEditingController phoneCtrl;
  late TextEditingController emailCtrl;
  late TextEditingController cICtrl;

  @override
  void initState() {
    nameCtrl = TextEditingController(text: widget.user.name);
    phoneCtrl = TextEditingController(text: "78970513");
    emailCtrl = TextEditingController(text: widget.user.email);
    cICtrl = TextEditingController(text: "7021733");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.logout_outlined,
              color: Colors.white,
              size: 40,
            ),
          )
        ],
        title: Text(
          "Mi Perfil",
          style: GoogleFonts.poppins(
              color: Colors.white, fontSize: 22, fontWeight: FontWeight.w600),
        ),
        backgroundColor: const Color(0xff23395D),
        elevation: 4,
      ),
      body: Column(
        children: [
          const SizedBox(height: 30),
          Container(
            height: 100,
            width: 100,
            child: Stack(
              children: [
                Center(
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                      widget.user.profilePictureUrl,
                    ),
                    radius: 100,
                  ),
                ),
                Positioned(
                  bottom: -10,
                  right: -10,
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.photo_camera),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 20),
          ProfileItem(
            title: "Nombre",
            controller: nameCtrl,
            icon: Icons.person,
          ),
          ProfileItem(
            title: "Numeor de celular",
            controller: phoneCtrl,
            icon: Icons.phone_android_rounded,
          ),
          ProfileItem(
            title: "Correo electronico",
            controller: emailCtrl,
            icon: Icons.email,
          ),
          ProfileItem(
            title: "Carnet de identidad",
            controller: cICtrl,
            icon: Icons.chrome_reader_mode,
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Container(
              height: 55,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xff23395D),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Actualizar Datos",
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
