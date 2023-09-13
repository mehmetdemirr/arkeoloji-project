import 'package:auto_route/auto_route.dart';
import 'package:demo/core/navigation/app_router.dart';
import 'package:demo/core/theme/dark_theme.dart';
import 'package:demo/core/theme/light_theme.dart';
import 'package:demo/core/theme/theme_view_model.dart';
import 'package:demo/core/utilty/padding_items.dart';
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
      appBar: AppBar(title: const Text("Ayarlar")),
      body: Padding(
        padding: PaddingItem.small.str(),
        child: Column(
          children: [
            // Text(
            //   LocaleKeys.hello.locale,
            //   style: Theme.of(context).textTheme.titleLarge,
            // ),
            Card(
              child: Padding(
                padding: PaddingItem.medium.str() +
                    PaddingItem.horizantalLarge.str(),
                child: Row(
                  children: [
                    Text(
                      "Tema",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const Spacer(),
                    _switchTheme(
                        context, context.watch<ThemeNotifier>().getTheme()),
                  ],
                ),
              ),
            ),
            Card(
              child: Padding(
                padding: PaddingItem.medium.str() +
                    PaddingItem.horizantalLarge.str(),
                child: Row(
                  children: [
                    Text(
                      "Dil Seçenekleri",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const Spacer(),
                    const Text("az kaldı : )")
                  ],
                ),
              ),
            ),
            Card(
              child: Padding(
                padding: PaddingItem.medium.str() +
                    PaddingItem.horizantalLarge.str(),
                child: Row(
                  children: [
                    Text(
                      "Çıkış",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () async {
                        var box = await Hive.openBox<UserLoginModel>(
                            "user"); // Box'u açın
                        // Veriyi silin
                        await box.delete("user");

                        // ignore: use_build_context_synchronously
                        context.router.replaceAll([const LoginRoute()]);
                      },
                      child: const Text("Çıkış"),
                    ),
                  ],
                ),
              ),
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
