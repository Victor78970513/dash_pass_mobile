import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_pass/core/shared_preferences/preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

class MyWalletPage extends StatefulWidget {
  const MyWalletPage({super.key});

  @override
  State<MyWalletPage> createState() => _MyWalletPageState();
}

class _MyWalletPageState extends State<MyWalletPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> loadCredit(String method) async {
    setState(() {
      isLoading = true;
    });

    // Simula un delay para cargar crédito
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      isLoading = false;
    });

    // Mostrar mensaje de éxito
    showDialog(
      // ignore: use_build_context_synchronously
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Carga Exitosa'),
          content: Text('Se ha cargado crédito usando $method.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Cargar Crédito"),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(
              icon: Icon(
                Icons.qr_code,
                color: Color(0xff0B6D6D),
              ),
              text: "QR",
            ),
            Tab(
                icon: Icon(
                  Icons.credit_card,
                  color: Color(0xff0B6D6D),
                ),
                text: "Tarjeta de Débito"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Pantalla para cargar con QR
          Column(
            children: [
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.5,
                width: MediaQuery.sizeOf(context).width,
                child: Image.asset(
                  "assets/images/qr_image.png",
                  fit: BoxFit.fill,
                ),
              ),
              Center(
                child: isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton.icon(
                        icon: const Icon(Icons.qr_code),
                        label: const Text("Verificar el pago por qr"),
                        onPressed: () {
                          loadCredit("QR");
                        },
                      ),
              ),
            ],
          ),
          // Pantalla para cargar con Tarjeta de Débito
          GetPremiumPage(),
        ],
      ),
    );
  }
}

class GetPremiumPage extends StatefulWidget {
  const GetPremiumPage({super.key});

  @override
  State<GetPremiumPage> createState() => _GetPremiumPageState();
}

class _GetPremiumPageState extends State<GetPremiumPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController montoController = TextEditingController();
  bool isLoading = false;

  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  String amount = ''; // Campo para el monto
  bool isCvvFocused = false;

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }

  Future<void> loadCredit(String method) async {
    if (!formKey.currentState!.validate()) return;

    setState(() {
      isLoading = true;
    });

    // Simula un delay para cargar crédito
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      isLoading = false;
    });

    // Mostrar mensaje de éxito
    if (mounted) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Carga Exitosa'),
            content: Text('Se ha cargado $amount usando $method.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    const underlineInputBorder =
        UnderlineInputBorder(borderSide: BorderSide(color: Colors.black));
    final uid = Preferences().userUUID;

    return Scaffold(
      backgroundColor: const Color(0xffe7f4f8), // Azul pastel claro
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 16),
                const Text(
                  "Introduce los detalles de tu tarjeta para realizar la recarga correspondiente",
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xff4a90e2),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xffffffff),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        blurRadius: 15,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      CreditCardWidget(
                        cardNumber: cardNumber,
                        expiryDate: expiryDate,
                        cardHolderName: cardHolderName,
                        cvvCode: cvvCode,
                        showBackView: isCvvFocused,
                        onCreditCardWidgetChange: (CreditCardBrand) {},
                        cardBgColor: const Color(0xff4a90e2), // Azul pastel
                        isHolderNameVisible: true,
                      ),
                      CreditCardForm(
                        cardNumber: cardNumber,
                        expiryDate: expiryDate,
                        cardHolderName: cardHolderName,
                        cvvCode: cvvCode,
                        onCreditCardModelChange: onCreditCardModelChange,
                        formKey: formKey,
                        inputConfiguration: const InputConfiguration(
                          cardHolderTextStyle: TextStyle(color: Colors.black),
                          expiryDateTextStyle: TextStyle(color: Colors.black),
                          cvvCodeTextStyle: TextStyle(color: Colors.black),
                          cardNumberTextStyle: TextStyle(color: Colors.black),
                          cardNumberDecoration: InputDecoration(
                            enabledBorder: underlineInputBorder,
                            focusedBorder: underlineInputBorder,
                            labelText: 'Número de tarjeta',
                            hintText: 'XXXX XXXX XXXX XXXX',
                            hintStyle: TextStyle(color: Color(0xff4a90e2)),
                            labelStyle: TextStyle(color: Color(0xff4a90e2)),
                          ),
                          expiryDateDecoration: InputDecoration(
                            enabledBorder: underlineInputBorder,
                            focusedBorder: underlineInputBorder,
                            labelText: 'Fecha de expiración',
                            hintText: 'MM/AA',
                            hintStyle: TextStyle(color: Color(0xff4a90e2)),
                            labelStyle: TextStyle(color: Color(0xff4a90e2)),
                          ),
                          cvvCodeDecoration: InputDecoration(
                            enabledBorder: underlineInputBorder,
                            focusedBorder: underlineInputBorder,
                            labelText: 'CVV',
                            hintText: 'XXX',
                            hintStyle: TextStyle(color: Color(0xff4a90e2)),
                            labelStyle: TextStyle(color: Color(0xff4a90e2)),
                          ),
                          cardHolderDecoration: InputDecoration(
                            enabledBorder: underlineInputBorder,
                            focusedBorder: underlineInputBorder,
                            labelText: 'Nombre del propietario',
                            hintStyle: TextStyle(color: Color(0xff4a90e2)),
                            labelStyle: TextStyle(color: Color(0xff4a90e2)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: TextFormField(
                          controller: montoController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Monto a cargar',
                            labelStyle: TextStyle(color: Color(0xff4a90e2)),
                            hintText: 'Ej. 100.00',
                            enabledBorder: underlineInputBorder,
                            focusedBorder: underlineInputBorder,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, introduce un monto';
                            }
                            if (double.tryParse(value) == null ||
                                double.parse(value) <= 0) {
                              return 'Introduce un monto válido';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              amount = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Color(0xff4a90e2),
                          ),
                        )
                      : ElevatedButton.icon(
                          onPressed: () async {
                            try {
                              FirebaseFirestore.instance
                                  .runTransaction((transaction) async {
                                DocumentReference userRef = FirebaseFirestore
                                    .instance
                                    .collection("usuarios")
                                    .doc(uid);

                                // Obtener el documento actual
                                DocumentSnapshot snapshot =
                                    await transaction.get(userRef);

                                if (!snapshot.exists) {
                                  throw Exception("El usuario no existe.");
                                }

                                // Leer el saldo actual
                                int saldoActual = snapshot.get("saldo");

                                // Actualizar el saldo
                                int nuevoSaldo = saldoActual +
                                    int.parse(montoController.text);

                                // Actualizar el documento en la transacción
                                transaction
                                    .update(userRef, {"saldo": nuevoSaldo});
                              });

                              // Mostrar un mensaje de éxito
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text('Carga Exitosa'),
                                    content: Text(
                                        'Se ha cargado ${montoController.text} al saldo.'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            } catch (e) {
                              // Manejar errores
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text('Error'),
                                    content: Text(
                                        'No se pudo realizar la carga: $e'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          },
                          icon: const Icon(
                            Icons.credit_card,
                            size: 24,
                            color: Colors.white,
                          ),
                          label: const Text(
                            "Pagar con tarjeta",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color(0xff4a90e2), // Azul pastel mediano
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
