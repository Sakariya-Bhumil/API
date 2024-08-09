import 'package:api/Home_screen.dart';
import 'package:api/Second_ex.dart';
import 'package:api/Third_example.dart';
import 'package:api/final_example.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(myapp());
}

class myapp extends StatelessWidget {
  const myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Final_example(),
    );
  }
}
