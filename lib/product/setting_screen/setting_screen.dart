import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:demo/core/extension/string_extension.dart';
import 'package:demo/core/navigation/app_router.dart';
import 'package:demo/core/theme/dark_theme.dart';
import 'package:demo/core/theme/light_theme.dart';
import 'package:demo/core/theme/theme_view_model.dart';
import 'package:demo/generated/locale_keys.g.dart';
import 'package:demo/product/general/model/user_login_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

@RoutePage()
class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});
  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Setting Screen")),
      body: Column(
        children: [
          Text(
            LocaleKeys.hello.locale,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          _switchTheme(context, context.watch<ThemeNotifier>().getTheme()),
          ElevatedButton(
            onPressed: () async {
              var box =
                  await Hive.openBox<UserLoginModel>("user"); // Box'u açın
              // Veriyi silin
              await box.delete("user");
              // Box'ı kapatmayı unutmayın
              // await box.close();

              // ignore: use_build_context_synchronously
              context.router.replaceAll([const LoginRoute()]);
            },
            child: const Text("Çıkış"),
          ),
          // ElevatedButton(
          //   onPressed: () {
          //     showDatePicker(
          //       context: context,
          //       initialDate: DateTime.now(),
          //       firstDate: DateTime.now(),
          //       lastDate: DateTime.now().add(const Duration(days: 100)),
          //     );
          //   },
          //   child: const Text("takvim"),
          // ),
        ],
      ),
    );
  }

  Switch _switchTheme(BuildContext context, bool result) {
    return Switch(
      value: result,
      onChanged: (value) {
        context.read<ThemeNotifier>().setTheme(value ? darkTheme : lightTheme);
      },
    );
  }
}
