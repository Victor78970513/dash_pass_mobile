import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:dash_pass/core/shared_preferences/preferences.dart';
import 'package:dash_pass/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:dash_pass/features/home/cubit/navigation_cubit.dart';
import 'package:dash_pass/features/home/presentation/pages/home_view.dart';
import 'package:dash_pass/features/home/presentation/widgets/navigator_item.dart';
import 'package:dash_pass/features/my_vehicles/pages/my_vehicles_page.dart';
import 'package:dash_pass/features/pases/presentation/pages/pases_page.dart';
import 'package:dash_pass/features/reloads/presentation/pages/reloads_page.dart';
import 'package:dash_pass/features/settings/bloc/profile_bloc.dart';
import 'package:dash_pass/features/settings/presentation/pages/settings_page.dart';
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
  late PageController _pageController;
  @override
  void initState() {
    context.read<NavigationCubit>().changeIndexValue(2);
    _pageController =
        PageController(initialPage: context.read<NavigationCubit>().state);
    final uid = Preferences().userUUID;
    context.read<ProfileBloc>().add(OnGetProfileEvent(uid));
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final navigationIndex = context.watch<NavigationCubit>().state;
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
              case ProfileInitial():
              case ProfileLoadingState():
                return Scaffold(
                    backgroundColor: Colors.white,
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
              case ProfileSuccessState(user: final user):
                return Scaffold(
                  // backgroundColor: const Color(0xFFE0E0E0),
                  backgroundColor: const Color(0xffF4F4F4),
                  body: SafeArea(
                    child: PageView(
                      controller: _pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        const ReloadsPage(),
                        MyVehiclesPage(),
                        HomeView(user: user),
                        const PasesPage(),
                        SettingsPage(user: user),
                      ],
                    ),
                  ),
                  bottomNavigationBar: CurvedNavigationBar(
                    index: navigationIndex,
                    backgroundColor: const Color(0xffF4F4F4),
                    // backgroundColor: const Color(0xFFE0E0E0),
                    buttonBackgroundColor: const Color(0xff1C3C63),
                    color: const Color(0xff1C3C63),
                    animationDuration: const Duration(milliseconds: 250),
                    onTap: (value) {
                      context.read<NavigationCubit>().changeIndexValue(value);
                      _pageController.animateToPage(
                        value,
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.easeOut,
                      );
                    },
                    items: const [
                      NavigatorItem(
                          icon: Icons.account_balance_wallet, index: 0),
                      NavigatorItem(icon: Icons.directions_car, index: 1),
                      NavigatorItem(icon: Icons.home_filled, index: 2),
                      NavigatorItem(icon: Icons.receipt, index: 3),
                      NavigatorItem(icon: Icons.person_outline, index: 4),
                    ],
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
            }
          },
        ),
      ),
    );
  }
}
