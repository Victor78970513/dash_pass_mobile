import 'package:dash_pass/core/shared_preferences/preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class QRPage extends StatefulWidget {
  const QRPage({super.key});

  @override
  State<QRPage> createState() => _QRPageState();
}

class _QRPageState extends State<QRPage> {
  final TextEditingController _montoController = TextEditingController();

  // Función para actualizar el saldo en Firestore
  Future<void> actualizarSaldo(String userId, int nuevoSaldo) async {
    try {
      final userRef =
          FirebaseFirestore.instance.collection('usuarios').doc(userId);
      final recargasRef =
          FirebaseFirestore.instance.collection('recargas').doc();
      final userDoc = await userRef.get();

      if (userDoc.exists) {
        final saldoActual = userDoc.data()?['saldo'] ?? 0.0;
        final saldoFinal = saldoActual + nuevoSaldo;

        await userRef.update({
          'saldo': saldoFinal,
        });

        await recargasRef.set({
          "fecha_creacion": DateTime.now(),
          "id_recarga": recargasRef.id,
          "id_usuario": userId,
          "monto": nuevoSaldo,
          "tipo_pago": "codigo QR"
        });

        print("Saldo actualizado con éxito. Nuevo saldo: $saldoFinal");
      } else {
        print("El documento del usuario no existe.");
      }
    } catch (e) {
      print("Error al actualizar el saldo: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(240, 240, 240, 1),
      body: SafeArea(
        child: Column(
          children: [
            SvgPicture.asset(
              "assets/logos/dash_pass.svg",
              height: size.height * 0.1,
            ),
            const SizedBox(height: 30),
            const Text(
              "QR de Pago",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                width: size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    Image.asset(
                      "assets/images/qr_image.png",
                      width: size.width * 0.7,
                      fit: BoxFit.fill,
                    ),
                    // Hacemos el monto editable
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: TextField(
                        controller: _montoController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Monto',
                          hintText: 'Ejemplo: 10',
                          border: OutlineInputBorder(),
                        ),
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Valido hasta: ",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          "07/11/2024 02:41:00",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Referencia: ",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          "RECARGA POR QR",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 25,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff62B6B7),
                            ),
                            onPressed: () async {
                              int nuevoSaldo =
                                  int.tryParse(_montoController.text) ?? 0;

                              if (nuevoSaldo > 0) {
                                String userId = Preferences().userUUID;
                                await actualizarSaldo(userId, nuevoSaldo);
                                Navigator.pop(context);
                              }
                            },
                            child: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                children: [
                                  Icon(Icons.share,
                                      color: Colors.white, size: 35),
                                  SizedBox(width: 10),
                                  Text(
                                    "Verificar el pago",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
