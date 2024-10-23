import 'package:dash_pass/core/shared_preferences/preferences.dart';
import 'package:dash_pass/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:dash_pass/features/my_vehicles/pages/my_vehicles_page.dart';
import 'package:dash_pass/features/profile/bloc/profile_bloc.dart';
import 'package:dash_pass/main.dart';
import 'package:dash_pass/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    final uid = Preferences().userUUID;
    context.read<ProfileBloc>().add(OnGetProfileEvent(uid));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => serviceLocator<AuthBloc>(),
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthInitial) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const ANIAPAGE()));
          }
        },
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            switch (state) {
              case ProfileLoadingState():
                return Scaffold(
                    backgroundColor: const Color(0xff0B6D6D),
                    body: Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        height: size.height * 0.6,
                        width: size.width,
                        child: Lottie.asset(
                          "assets/logos/toll_loading.json",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ));
              case ProfileSuccessState():
                final user = state.user;
                return Scaffold(
                  backgroundColor: const Color(0xff0B6D6D),
                  body: SafeArea(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const CircleAvatar(
                                    // backgroundImage:
                                    //     AssetImage('assets/profile_image.png'),
                                    radius: 25,
                                  ),
                                  const SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Hola, ${user.name} 👋',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const Text(
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
                              const Row(
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
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 20),
                                Expanded(
                                  child: GridView.count(
                                    crossAxisCount: 2,
                                    childAspectRatio: 1.3,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                    children: [
                                      _buildServiceItem(Icons.credit_card,
                                          'Mis tarjetas', () {}),
                                      _buildServiceItem(
                                          Icons.location_on, 'Peajes', () {}),
                                      _buildServiceItem(
                                          Icons.directions_car, 'Mis Vehiculos',
                                          () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    MyVehiclesPage()));
                                      }),
                                      // _buildServiceItem(Icons.security, 'Car Insurance'),
                                      // _buildServiceItem(Icons.build, 'Road Assistance'),
                                      _buildServiceItem(
                                          Icons.history, 'Mis recargas', () {}),
                                      _buildServiceItem(Icons.history_edu,
                                          'Historial de pases', () {}),
                                      _buildServiceItem(
                                          Icons.account_balance_wallet,
                                          'Mi Billetera',
                                          () {}),
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
              case ProfileErrorState():
                return Scaffold(
                    body: Center(
                        child: ElevatedButton(
                            onPressed: () {
                              context.read<AuthBloc>().add(AuthLogOut());
                            },
                            child: const Text("SALIR"))));

              default:
                return const Scaffold(
                  body: Center(
                    child: Text("POR DEFAULT"),
                  ),
                );
            }
          },
        ),
      ),
    );
  }
}

Widget _buildServiceItem(IconData icon, String label, VoidCallback onTap) {
  return GestureDetector(
    onTap: () {
      onTap();
    },
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 70, color: const Color(0xff62B6B7)),
        const SizedBox(height: 10),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ],
    ),
  );
}
