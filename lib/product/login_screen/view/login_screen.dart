import 'package:auto_route/auto_route.dart';
import 'package:demo/core/function/decoration_custom.dart';
import 'package:demo/core/function/print_function.dart';
import 'package:demo/core/function/show_snackbar.dart';
import 'package:demo/core/navigation/app_router.dart';
import 'package:demo/core/utilty/images_items.dart';
import 'package:demo/core/utilty/padding_items.dart';
import 'package:demo/product/general/service/project_dio.dart';
import 'package:demo/product/login_screen/service/login_service.dart';
import 'package:flutter/material.dart';

@RoutePage()
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _mail = TextEditingController();
  final TextEditingController _password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                      controller: _mail,
                      decoration: customInputDecoration(
                        "mail giriniz",
                        "mail",
                        context,
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "boş bırakılmaz";
                        }
                        //else if (value.trim().length <= 1) {
                        //   return "geçerli mail giriniz";
                        // } // TODO email validator control
                        // else if (value.isEmpty) {
                        //   return "geçerli mail giriniz";
                        // }
                        else {
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
                          "parola giriniz", "parola", context),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "boş bırakılmaz";
                        }
                        // else if (value.trim().length < 8) {
                        //   return "en az 8 karakter şifre ";
                        // }
                        else {
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
                  bool login = await LoginService(DioManager.dio)
                      .login(_mail.text, _password.text);
                  printf("login:$login");
                  if (login) {
                    // ignore: use_build_context_synchronously
                    context.router.replaceNamed(RouterItem.home.str());
                  } else {
                    // ignore: use_build_context_synchronously
                    showSnackbar(context, "Şifre veya e-mail hatalı!");
                  }
                }
              },
              child: const Text("Giriş Yap"),
            ),
            Padding(
              padding: PaddingItem.verticalMedium.str(),
              child: GestureDetector(
                onTap: () {
                  context.router.replaceNamed(RouterItem.register.str());
                },
                child: const Text("Hesabın yok mu ?"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
