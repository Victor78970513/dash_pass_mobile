import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

class MyWalletPage extends StatefulWidget {
  const MyWalletPage({super.key});

  @override
  _MyWalletPageState createState() => _MyWalletPageState();
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
          GetPremiumPage(
            onPressed: () {
              loadCredit("tarjeta de débito");
            },
          ),
          // Center(
          //   child: isLoading
          //       ? const CircularProgressIndicator()
          //       : ElevatedButton.icon(
          //           icon: const Icon(Icons.credit_card),
          //           label: const Text("Cargar con Tarjeta de Débito"),
          //           onPressed: () {
          //             loadCredit("tarjeta de débito");
          //           },
          //         ),
          // ),
        ],
      ),
    );
  }
}

class GetPremiumPage extends StatefulWidget {
  final Function() onPressed;
  const GetPremiumPage({super.key, required this.onPressed});

  @override
  State<GetPremiumPage> createState() => _GetPremiumPageState();
}

class _GetPremiumPageState extends State<GetPremiumPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool isLightTheme = false;
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  bool useGlassMorphism = false;
  bool useBackgroundImage = false;
  bool useFloatingAnimation = true;
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
    const underlineInputBorder =
        UnderlineInputBorder(borderSide: BorderSide(color: Colors.black));
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 100),
            CreditCardWidget(
              cardNumber: cardNumber,
              expiryDate: expiryDate,
              cardHolderName: cardHolderName,
              cvvCode: cvvCode,
              showBackView: false,
              // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
              onCreditCardWidgetChange: (CreditCardBrand) {},
              bankName: "BANCO BNB",
              cardBgColor: Colors.black,
              glassmorphismConfig: Glassmorphism.defaultConfig(),
              floatingConfig: const FloatingConfig(
                isGlareEnabled: true,
                isShadowEnabled: true,
                shadowConfig: FloatingShadowConfig(),
              ),
              backgroundImage: "assets/images/card_bg.png",
              labelValidThru: 'VALID\nTHRU',
              obscureCardNumber: true,
              obscureInitialCardNumber: false,
              obscureCardCvv: true,
              cardType: CardType.mastercard,
              isHolderNameVisible: true,
              width: MediaQuery.of(context).size.width,
              isChipVisible: true,
              isSwipeGestureEnabled: true,
              frontCardBorder: Border.all(color: Colors.red),
              backCardBorder: Border.all(color: Colors.yellow),
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
                  labelText: 'Numero de la tarjeta',
                  hintText: 'XXXX XXXX XXXX XXXX',
                  hintStyle: TextStyle(color: Colors.black),
                  labelStyle: TextStyle(color: Colors.black),
                ),
                expiryDateDecoration: InputDecoration(
                  enabledBorder: underlineInputBorder,
                  focusedBorder: underlineInputBorder,
                  labelText: 'Fecha de expiracion',
                  hintText: 'XX/XX',
                  hintStyle: TextStyle(color: Colors.black),
                  labelStyle: TextStyle(color: Colors.black),
                ),
                cvvCodeDecoration: InputDecoration(
                  enabledBorder: underlineInputBorder,
                  focusedBorder: underlineInputBorder,
                  labelText: 'CVV',
                  hintText: 'XXX',
                  hintStyle: TextStyle(color: Colors.black),
                  labelStyle: TextStyle(color: Colors.black),
                ),
                cardHolderDecoration: InputDecoration(
                  enabledBorder: underlineInputBorder,
                  focusedBorder: underlineInputBorder,
                  labelText: 'Nombre del propietario',
                  hintStyle: TextStyle(color: Colors.black),
                  labelStyle: TextStyle(color: Colors.black),
                ),
              ),
            ),
            const Spacer(),
            Container(
              width: 300,
              child: isLoading
                  ? const Center(
                      child:
                          CircularProgressIndicator(color: Color(0xff0B6D6D)))
                  : GestureDetector(
                      onTap: () {
                        loadCredit("tarjeta de debito");
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xff62B6B7),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.credit_card,
                                color: Colors.white,
                                size: 40,
                              ),
                              SizedBox(width: 20),
                              Text(
                                "Pagar con tarjeta",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 24),
                              ),
                            ],
                          ),
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
