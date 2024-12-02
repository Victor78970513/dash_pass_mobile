import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_pass/core/shared_preferences/preferences.dart';
import 'package:flutter/material.dart';

class CreditCardPage extends StatefulWidget {
  const CreditCardPage({super.key});

  @override
  _CreditCardPageState createState() => _CreditCardPageState();
}

class _CreditCardPageState extends State<CreditCardPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  final TextEditingController _montoController = TextEditingController();

  Future<void> actualizarSaldo(String userId, double nuevoSaldo) async {
    try {
      // Obtén la referencia al documento del usuario
      final userRef =
          FirebaseFirestore.instance.collection('usuarios').doc(userId);

      // Obtén el saldo actual del usuario
      final userDoc = await userRef.get();

      if (userDoc.exists) {
        // Si el documento existe, obtiene el saldo actual
        double saldoActual = userDoc.data()?['saldo'] ?? 0.0;

        // Calcula el nuevo saldo sumando el saldo actual con el nuevo saldo
        double saldoFinal = saldoActual + nuevoSaldo;

        // Actualiza el saldo en Firestore
        await userRef.update({
          'saldo': saldoFinal, // Suma el nuevo saldo al saldo actual
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recargar Crédito'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título
            const Text(
              "Detalles de la Tarjeta de Crédito",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),

            // Representación de la tarjeta de crédito
            Center(
              child: Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Logo del banco o texto
                    const Text(
                      "Tarjeta Credito/Debito",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    const Spacer(),
                    // Número de tarjeta (dinámico)
                    Text(
                      _cardNumberController.text.isEmpty
                          ? "1234 5678 9876 5432"
                          : _cardNumberController.text,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const Spacer(),
                    // Fecha de expiración y nombre (dinámico)
                    Row(
                      children: [
                        Text(
                          _expiryController.text.isEmpty
                              ? "Exp: 12/24"
                              : "Exp: ${_expiryController.text}",
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          _nameController.text.isEmpty
                              ? "Juan Pérez"
                              : _nameController.text,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),

            // Nombre del titular
            const Text(
              "Nombre del titular",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            TextField(
              controller: _nameController,
              onChanged: (value) {
                setState(() {});
              },
              decoration: const InputDecoration(
                hintText: "Ejemplo: Juan Pérez",
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
              ),
            ),
            const SizedBox(height: 15),

            // Número de tarjeta
            const Text(
              "Número de tarjeta",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            TextField(
              controller: _cardNumberController,
              onChanged: (value) {
                setState(() {});
              },
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: "1234 5678 1234 5678",
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
              ),
            ),
            const SizedBox(height: 15),

            // Fecha de expiración
            Row(
              children: [
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Fecha de expiración",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: _expiryController,
                    onChanged: (value) {
                      setState(() {});
                    },
                    decoration: const InputDecoration(
                      hintText: "MM/AA",
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                // CVV
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "CVV",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: _cvvController,
                    onChanged: (value) {
                      setState(() {});
                    },
                    obscureText: true,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: "123",
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            const Text(
              "Monto a recargar",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _montoController,
              onChanged: (value) {
                setState(() {});
              },
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: "Ingresa el monto",
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
              ),
            ),
            // Botón para recargar crédito
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  final userId = Preferences().userUUID;
                  await Future.delayed(const Duration(seconds: 2));
                  await actualizarSaldo(
                      userId, double.parse(_montoController.text));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  "Recargar Crédito",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
