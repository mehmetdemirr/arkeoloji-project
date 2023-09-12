import 'package:auto_route/auto_route.dart';
import 'package:demo/product/acma_add_screen/view/acma_add_screen.dart';
import 'package:demo/product/acma_screen/view/acma_screen.dart';
import 'package:demo/product/home_screen/view/home_screen.dart';
import 'package:demo/product/kazi_add_screen/view/kazi_add_screen.dart';
import 'package:demo/product/login_screen/view/login_screen.dart';
import 'package:demo/product/register_screen/view/register_screen.dart';
import 'package:demo/product/setting_screen/setting_screen.dart';
import 'package:demo/product/splash_screen/view/splash_screen.dart';

import '../../product/get_image_screen/view/get_image_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          path: RouterItem.splash.str(),
          page: SplashRoute.page,
          initial: true,
        ),
        AutoRoute(
          path: RouterItem.home.str(),
          page: HomeRoute.page,
        ),
        AutoRoute(
          path: RouterItem.register.str(),
          page: RegisterRoute.page,
        ),
        AutoRoute(
          path: RouterItem.login.str(),
          page: LoginRoute.page,
        ),
        AutoRoute(
          path: RouterItem.setting.str(),
          page: SettingRoute.page,
        ),
        AutoRoute(
          path: RouterItem.getImage.str(),
          page: GetImageRoute.page,
        ),
        AutoRoute(
          path: RouterItem.kaziAdd.str(),
          page: KaziAddRoute.page,
        ),
        AutoRoute(
          path: RouterItem.acmalar.str(),
          page: AcmaRoute.page,
        ),
        AutoRoute(
          path: RouterItem.acmaAdd.str(),
          page: AcmaAddRoute.page,
        ),
      ];
}

enum RouterItem {
  home,
  setting,
  getImage,
  splash,
  register,
  login,
  kaziAdd,
  acmalar,
  acmaAdd,
}

extension RouterItems on RouterItem {
  String str() {
    switch (this) {
      case RouterItem.home:
        return "/home";
      case RouterItem.setting:
        return "/setting";
      case RouterItem.getImage:
        return "/getImage";
      case RouterItem.splash:
        return "/splash";
      case RouterItem.register:
        return "/register";
      case RouterItem.login:
        return "/login";
      case RouterItem.kaziAdd:
        return "/kaziAdd";
      case RouterItem.acmalar:
        return "/acmalar";
      case RouterItem.acmaAdd:
        return "/acmaAdd";
    }
  }
}
