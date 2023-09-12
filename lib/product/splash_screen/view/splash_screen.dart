import 'package:auto_route/auto_route.dart';
import 'package:demo/core/navigation/app_router.dart';
import 'package:demo/core/utilty/duration_items.dart';
import 'package:demo/core/utilty/images_items.dart';
import 'package:demo/product/general/model/user_login_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool ilkAcilis = true;
  @override
  void initState() {
    super.initState();
    Future.delayed(DurationItem.small.str()).then((value) async {
      var box = Hive.box<UserLoginModel>("user");
      if (mounted) {
        if (box.get("user") == null) {
          context.router.replaceNamed(RouterItem.login.str());
        } else {
          context.router.replaceNamed(RouterItem.home.str());
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Center(
            child: Text("Splash Screen"),
          ),
          Image.asset(ImageItem.arkeoloji.str()),
        ]),
      ),
    );
  }
}
