import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_pass/features/settings/presentation/widgets/profile_item.dart';
import 'package:dash_pass/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

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
  XFile? _profileImage;

  @override
  void initState() {
    nameCtrl = TextEditingController(text: widget.user.name);
    phoneCtrl = TextEditingController(text: "78970513");
    emailCtrl = TextEditingController(text: widget.user.email);
    cICtrl = TextEditingController(text: "7021733");
    super.initState();
  }

  Future<void> _pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      setState(() {
        _profileImage = pickedImage;
      });
    }
  }

  Future<String?> _uploadProfileImage(XFile? imageFile) async {
    if (imageFile != null) {
      // String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference ref = FirebaseStorage.instance.ref('images');
      ref = ref.child(Uri.file(imageFile.path).pathSegments.last);
      await ref.putFile(File(imageFile.path));
      print(await ref.getDownloadURL());
      ref = ref.parent!;
    } else {
      return '';
    }
  }

  Future<void> _updateUserData() async {
    try {
      String? imageUrl;
      if (_profileImage != null) {
        imageUrl = await _uploadProfileImage(_profileImage);
      }

      Map<String, dynamic> updatedData = {
        'nombre': nameCtrl.text,
        'correo': emailCtrl.text,
        'carnet_identidad': int.parse(cICtrl.text),
      };

      if (imageUrl != null) {
        updatedData['foto_perfil'] = imageUrl;
      }

      await FirebaseFirestore.instance
          .collection('usuarios')
          .doc(widget.user.uid)
          .update(updatedData);

      Navigator.pop(context);
    } catch (e) {
      print("Error al actualizar usuario: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al actualizar los datos')),
      );
    }
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
          Stack(
            children: [
              CircleAvatar(
                backgroundImage: _profileImage != null
                    ? FileImage(File(_profileImage!.path)) as ImageProvider
                    : NetworkImage(widget.user.profilePicture),
                radius: 50,
              ),
              Positioned(
                bottom: -10,
                right: -10,
                child: IconButton(
                  onPressed: _pickImage,
                  icon: const Icon(Icons.photo_camera),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ProfileItem(
            title: "Nombre",
            controller: nameCtrl,
            icon: Icons.person,
          ),
          ProfileItem(
            title: "Número de celular",
            controller: phoneCtrl,
            icon: Icons.phone_android_rounded,
          ),
          ProfileItem(
            title: "Correo electrónico",
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
            child: GestureDetector(
              // onTap: _updateUserData,
              onTap: () async {
                final path = await _uploadProfileImage(_profileImage);
                print("ESTE ES EL URL DE LA IMAGEN $path");
              },
              child: Container(
                height: 55,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xff23395D),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: Text(
                    "Actualizar Datos",
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
