import 'package:flutter/material.dart';
import 'package:kedai_tembakau_abah/HomePage.dart';
import 'package:kedai_tembakau_abah/providers/product/product_form_screen.dart';
import 'package:kedai_tembakau_abah/providers/product/product_home_screen.dart';
import 'package:kedai_tembakau_abah/providers/salles/salles_form_screen.dart';
import 'package:kedai_tembakau_abah/providers/salles/salles_home_screen.dart';
import 'package:kedai_tembakau_abah/providers/stock/stock_form_screen.dart';
import 'package:kedai_tembakau_abah/providers/stock/stock_home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/product': (context) => ProductPages(),
        '/add-product': (context) => ProductFormPage(),
        '/stock': (context) => stockPages(),
        '/add-stock': (context) => StockFormPage(),
        '/reseler': (context) => reselerPages(),
        '/add-reseler': (context) => ReselerFormPage(),
      },
      theme: ThemeData(
        scaffoldBackgroundColor: Color.fromARGB(255, 0, 0, 0),
      ),
      home: const WelcomePage(),
    );
  }
}
