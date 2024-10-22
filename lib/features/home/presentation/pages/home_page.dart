import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff0B6D6D),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage(
                            'assets/profile_image.png'), // imagen de perfil
                        radius: 25,
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hola, Victor 👋',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Bienvenido!',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Colors.white,
                      ),
                      Text(
                        'La Paz-Bolivia',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 10),
                      // Icon(
                      //   Icons.notifications,
                      //   color: Colors.white,
                      // ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            // Services Section
            Expanded(
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Services',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    Expanded(
                      child: GridView.count(
                        crossAxisCount: 2,
                        childAspectRatio: 1.3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        children: [
                          _buildServiceItem(Icons.credit_card, 'Mis tarjetas'),
                          _buildServiceItem(Icons.location_on, 'Peajes'),
                          _buildServiceItem(
                              Icons.directions_car, 'Mis Vehiculos'),
                          // _buildServiceItem(Icons.security, 'Car Insurance'),
                          // _buildServiceItem(Icons.build, 'Road Assistance'),
                          _buildServiceItem(Icons.history, 'Mis recargas'),
                          _buildServiceItem(
                              Icons.history_edu, 'Historial de pases'),
                          _buildServiceItem(
                              Icons.account_balance_wallet, 'Mi Billetera'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildServiceItem(IconData icon, String label) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(icon, size: 70, color: const Color(0xff62B6B7)),
      SizedBox(height: 10),
      Text(
        label,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      ),
    ],
  );
}


// class HomePage extends StatelessWidget {
//   const HomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text('Hello, World!'),
//               BlocProvider(
//                 create: (context) => serviceLocator<AuthBloc>(),
//                 child: BlocConsumer<AuthBloc, AuthState>(
//                   listener: (context, state) {
//                     switch (state) {
//                       case AuthInitial():
//                         Navigator.pushReplacement(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => const LoginPage()));
//                         break;
//                       default:
//                     }
//                   },
//                   builder: (context, state) {
//                     return ElevatedButton(
//                       onPressed: () {
//                         context.read<AuthBloc>().add(AuthLogOut());
//                       },
//                       child: Text("CERRAR SESION"),
//                     );
//                   },
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
