import 'package:demo/core/cache/shared_pref.dart';
import 'package:demo/core/navigation/app_router.dart';
import 'package:demo/core/network_control/no_network_widget.dart';
import 'package:demo/core/theme/dark_theme.dart';
import 'package:demo/core/theme/light_theme.dart';
import 'package:demo/core/theme/theme_view_model.dart';
import 'package:demo/product/acma_bilgi_screen/view_model/acma_bilgi_viewmodel.dart';
import 'package:demo/product/acma_screen/viewmodel/acma_viewmodel.dart';
import 'package:demo/product/general/model/user_login_model.dart';
import 'package:demo/product/kazi_screen/viewmodel/kazi_view_model.dart';
import 'package:demo/product/kazi_user_add_sceen/viewmodel/kazi_user_viewmodel.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Hive.initFlutter('uygulama');
  Hive.registerAdapter(UserLoginModelAdapter());
  await Hive.openBox<UserLoginModel>('user');
  var darkModeOn = await SharedPref().getTheme();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeNotifier>(
          create: (_) => ThemeNotifier(darkModeOn ? darkTheme : lightTheme),
        ),
        ChangeNotifierProvider<KaziViewModel>(
          create: (_) => KaziViewModel(),
        ),
        ChangeNotifierProvider<AcmaViewModel>(
          create: (_) => AcmaViewModel(),
        ),
        ChangeNotifierProvider<AcmaBilgiViewModel>(
          create: (_) => AcmaBilgiViewModel(),
        ),
        ChangeNotifierProvider<KaziUserViewModel>(
          create: (_) => KaziUserViewModel(),
        ),
      ],
      child: EasyLocalization(
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('tr', 'TR'),
        ],
        path:
            'assets/translations', // <-- change the path of the translation files
        fallbackLocale: const Locale('tr', 'TR'),
        saveLocale: true,
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      //local language change example: date picker , time picker
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.deviceLocale,

      debugShowCheckedModeBanner: false,
      title: 'Arkeoloji',
      //theme
      theme: context.watch<ThemeNotifier>().getTheme() ? darkTheme : lightTheme,
      //router
      routerConfig: _appRouter.config(),
      //network control
      builder: (context, child) {
        return Column(
          children: [
            Expanded(
              child: child ?? const SizedBox(),
            ),
            const NoNetworkWidget(),
          ],
        );
      },
    );
  }
}
