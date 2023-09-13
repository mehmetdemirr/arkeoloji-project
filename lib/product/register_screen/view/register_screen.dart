import 'package:auto_route/auto_route.dart';
import 'package:demo/core/function/decoration_custom.dart';
import 'package:demo/core/function/show_snackbar.dart';
import 'package:demo/core/navigation/app_router.dart';
import 'package:demo/core/utilty/images_items.dart';
import 'package:demo/core/utilty/padding_items.dart';
import 'package:demo/product/general/service/project_dio.dart';
import 'package:demo/product/register_screen/service/register_service.dart';
import 'package:flutter/material.dart';

@RoutePage()
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _mail = TextEditingController();
  final TextEditingController _password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: PaddingItem.horizantalMedium.str() +
                    PaddingItem.verticallLarge.str() * 2,
                child: Image.asset(ImageItem.foto.str()),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: PaddingItem.medium.str(),
                      child: TextFormField(
                        controller: _name,
                        decoration: customInputDecoration(
                          "Adınızı girin",
                          "ad",
                          context,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "boş bırakılmaz";
                          } else if (value.trim().length <= 1) {
                            return "mail";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: PaddingItem.medium.str(),
                      child: TextFormField(
                        controller: _mail,
                        decoration: customInputDecoration(
                          "mail giriniz",
                          "mail",
                          context,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "boş bırakılamaz";
                          } else if (value.trim().length <= 1) {
                            return "geçerli mail giriniz";
                          } // TODO email validator control
                          else if (value.isEmpty) {
                            return "geçerli mail giriniz";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: PaddingItem.medium.str(),
                      child: TextFormField(
                        controller: _password,
                        decoration: customInputDecoration(
                          "parola giriniz",
                          "parola",
                          context,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "boş bırakılamaz";
                          } else if (value.trim().length < 8) {
                            return "en az 8 karakter olsun şifre";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      bool value =
                          await RegisterService(DioManager.dio).register(
                        _name.text,
                        _mail.text,
                        _password.text,
                      );
                      if (value) {
                        // ignore: use_build_context_synchronously
                        context.router.replaceNamed(RouterItem.login.str());
                      } else {
                        // ignore: use_build_context_synchronously
                        showSnackbar(context, "Kayıt tamamlanamadı !");
                      }
                    }
                  },
                  child: const Text("Kayıt ol")),
              Padding(
                padding: PaddingItem.verticalMedium.str(),
                child: GestureDetector(
                  onTap: () {
                    context.router.replaceNamed(RouterItem.login.str());
                  },
                  child: const Text("hesabın var mı?"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
