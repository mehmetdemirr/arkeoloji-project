import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

@RoutePage()
class AcmaScreen extends StatefulWidget {
  const AcmaScreen({super.key});
  @override
  State<AcmaScreen> createState() => _AcmaScreenState();
}

class _AcmaScreenState extends State<AcmaScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Acmalar")),
      body: const Column(
        children: [
          Text(""),
        ],
      ),
    );
  }
}
