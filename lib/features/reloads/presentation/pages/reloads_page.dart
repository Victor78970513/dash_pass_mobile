import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_pass/core/shared_preferences/preferences.dart';
import 'package:dash_pass/features/my_wallet/pages/my_wallet_page.dart';
import 'package:dash_pass/features/reloads/presentation/pages/qr_page.dart';
import 'package:dash_pass/features/reloads/presentation/widgets/recarga_card_widget.dart';
import 'package:dash_pass/models/recargas_model.dart';
import 'package:dash_pass/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ReloadsPage extends StatelessWidget {
  const ReloadsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final userId = Preferences().userUUID;
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          SvgPicture.asset(
            "assets/logos/dash_pass.svg",
            height: size.height * 0.1,
          ),
          const SizedBox(height: 30),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Mis Recargas",
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 182, 218, 244),
                borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        'Recarga de Saldo',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      const Spacer(),
                      StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection("usuarios")
                              .where('id_usuario', isEqualTo: userId)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                            if (!snapshot.hasData ||
                                snapshot.data!.docs.isEmpty) {
                              return const Center(
                                  child: Text('No hay recargas disponibles'));
                            }
                            final user = UserModel.fromMap(
                                snapshot.data!.docs.first.data());
                            return Text(
                              'Bs. ${user.saldo}',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            );
                          }),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Row(
                    children: [
                      Column(
                        children: [
                          Text(
                            "Creado en",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            "05/11/2024 22:41",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      Column(
                        children: [
                          Text(
                            "Recarga Expira en:",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            "06/11/2024 22:41",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CreditCardPage(),
                            ),
                          );
                        },
                        child: const Row(
                          children: [
                            Icon(Icons.credit_card,
                                color: Colors.black, size: 35),
                            SizedBox(width: 10),
                            Text(
                              "Pagar",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const QRPage(),
                            ),
                          );
                        },
                        child: const Row(
                          children: [
                            Icon(Icons.qr_code_2_outlined,
                                color: Colors.black, size: 35),
                            SizedBox(width: 10),
                            Text(
                              "Pago QR",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AllReloads(),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Ver Todo",
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(width: 15),
                const Icon(Icons.arrow_right_alt_outlined),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("recargas")
                  .where("id_usuario", isEqualTo: userId)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(
                      child: Text('No hay recargas disponibles'));
                }

                // Convertir los documentos en modelos de recarga
                final recargas = snapshot.data!.docs.map((doc) {
                  return RecargasModel.fromJson(
                      doc.data() as Map<String, dynamic>);
                }).toList();

                // Limitar la cantidad de elementos a 3 como máximo
                final maxRecargas = recargas.take(3).toList();

                return ListView.builder(
                  itemCount: maxRecargas.length,
                  itemBuilder: (context, index) {
                    final color = Colors
                        .primaries[Random().nextInt(Colors.primaries.length)];
                    final recarga = maxRecargas[index];
                    return RecargaCardWidget(recarga: recarga, color: color);
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class AllReloads extends StatelessWidget {
  const AllReloads({super.key});

  @override
  Widget build(BuildContext context) {
    final userId = Preferences().userUUID;
    return Scaffold(
      backgroundColor: const Color(0xffF4F4F4),
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        title: Text(
          "Todas tus Recargas",
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Expanded(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("recargas")
                      .where("id_usuario", isEqualTo: userId)
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return const Center(
                          child: Text('No hay recargas disponibles'));
                    }

                    // Convertir los documentos en modelos de recarga
                    final recargas = snapshot.data!.docs.map((doc) {
                      return RecargasModel.fromJson(
                          doc.data() as Map<String, dynamic>);
                    }).toList();

                    // Limitar la cantidad de elementos a 3 como máximo

                    return ListView.builder(
                      itemCount: recargas.length,
                      itemBuilder: (context, index) {
                        final color = Colors.primaries[
                            Random().nextInt(Colors.primaries.length)];
                        final recarga = recargas[index];
                        return RecargaCardWidget(
                            recarga: recarga, color: color);
                      },
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
