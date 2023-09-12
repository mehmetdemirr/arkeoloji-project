import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class AcmaAddScreen extends StatefulWidget {
  const AcmaAddScreen({super.key});
  @override
  State<AcmaAddScreen> createState() => _AcmaAddScreenState();
}

class _AcmaAddScreenState extends State<AcmaAddScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Acma Ekle")),
      body: const Column(
        children: [
          Text(""),
        ],
      ),
    );
  }
}
