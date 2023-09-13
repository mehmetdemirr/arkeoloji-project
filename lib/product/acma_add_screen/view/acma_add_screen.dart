import 'package:auto_route/auto_route.dart';
import 'package:demo/core/function/decoration_custom.dart';
import 'package:demo/core/function/show_snackbar.dart';
import 'package:demo/core/navigation/app_router.dart';
import 'package:demo/core/utilty/padding_items.dart';
import 'package:demo/product/acma_screen/service/acma_service.dart';
import 'package:demo/product/general/service/project_dio.dart';
import 'package:flutter/material.dart';

@RoutePage()
class AcmaAddScreen extends StatefulWidget {
  const AcmaAddScreen({super.key, required this.kaziId});
  final int kaziId;
  @override
  State<AcmaAddScreen> createState() => _AcmaAddScreenState();
}

class _AcmaAddScreenState extends State<AcmaAddScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _name = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Acma Ekle")),
      body: Column(
        children: [
          Padding(
            padding: PaddingItem.medium.str(),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: PaddingItem.verticalMedium.str(),
                    child: TextFormField(
                      controller: _name,
                      decoration:
                          customInputDecoration("ad girin", "ad", context),
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Bu alan boş bırakılamaz.';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                bool result = await AcmaService(DioManager.dio).acmaAdd(
                  _name.text,
                  widget.kaziId,
                );
                if (result) {
                  //TODO: auto router ile yap

                  // ignore: use_build_context_synchronously
                  context.replaceRoute(AcmaRoute(kaziId: widget.kaziId));
                } else {
                  // ignore: use_build_context_synchronously
                  showSnackbar(context, "Acma oluşturlamadı !");
                }
              }
            },
            child: const Text("Ekle"),
          )
        ],
      ),
    );
  }
}
