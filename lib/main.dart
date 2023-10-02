import 'package:flutter/material.dart';
import 'package:test1/Screens/home_screen.dart';
import 'package:test1/form_pengeluaran.dart';
import 'package:test1/form_screen.dart';
import 'package:test1/form_pemasukan.dart';
import 'package:test1/list_detail.dart';
import 'package:test1/pengaturan.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: FormScreen(),
    );
  }
}