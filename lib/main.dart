import 'package:flutter/material.dart';
import 'package:flutter_challenge_2/0/0_basic.dart';
import 'package:flutter_challenge_2/0/0_deepen.dart';
import 'package:flutter_challenge_2/1/basic_1.dart';
import 'package:flutter_challenge_2/1/deepen_1.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const Deepen1Solution(),
    );
  }
}
