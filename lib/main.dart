import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:authify/pages/login_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(context) {
    return const MaterialApp(
      title: 'Authify',
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
