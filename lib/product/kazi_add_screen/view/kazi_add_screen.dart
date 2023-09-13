import 'package:auto_route/auto_route.dart';
import 'package:demo/core/function/decoration_custom.dart';
import 'package:demo/core/function/show_snackbar.dart';
import 'package:demo/core/navigation/app_router.dart';
import 'package:demo/core/utilty/padding_items.dart';
import 'package:demo/product/general/service/project_dio.dart';
import 'package:demo/product/kazi_screen/service/kazi_service.dart';
import 'package:flutter/material.dart';

@RoutePage()
class KaziAddScreen extends StatefulWidget {
  const KaziAddScreen({super.key});
  @override
  State<KaziAddScreen> createState() => _KaziAddScreenState();
}

class _KaziAddScreenState extends State<KaziAddScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _city = TextEditingController();
  final TextEditingController _town = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Kazı Ekle")),
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
                  Padding(
                    padding: PaddingItem.verticalMedium.str(),
                    child: TextFormField(
                      controller: _city,
                      decoration: customInputDecoration(
                          "şehir girin", "şehir", context),
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Bu alan boş bırakılamaz.';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: PaddingItem.verticalMedium.str(),
                    child: TextFormField(
                      controller: _town,
                      decoration:
                          customInputDecoration("ilçe girin", "ilçe", context),
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
                bool result = await KaziService(DioManager.dio).kaziAdd(
                  _name.text,
                  _city.text,
                  _town.text,
                );
                if (result) {
                  //TODO: auto router ile yap

                  // ignore: use_build_context_synchronously
                  context.router.replaceNamed(RouterItem.home.str());
                } else {
                  // ignore: use_build_context_synchronously
                  showSnackbar(context, "Kazı oluşturlamadı !");
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
