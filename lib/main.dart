import 'package:dash_pass/features/auth/presentation/pages/login_page.dart';
// import 'package:dash_pass/features/home/presentation/pages/home_page.dart';
import 'package:dash_pass/service_locator.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependecies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Material App',
      home: LoginPage(),
      // home: HomePage(),
    );
  }
}
