import 'package:flutter/material.dart';
import 'package:kitchen_app/provider/cart.dart';
import 'package:kitchen_app/screens/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Cart()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home:  SplashScreen(),
      ),
    );
  }
}
