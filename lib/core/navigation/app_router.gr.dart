// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    AcmaAddRoute.name: (routeData) {
      final args = routeData.argsAs<AcmaAddRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: AcmaAddScreen(
          key: args.key,
          kaziId: args.kaziId,
        ),
      );
    },
    AcmaBilgiAddRoute.name: (routeData) {
      final args = routeData.argsAs<AcmaBilgiAddRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: AcmaBilgiAddScreen(
          key: args.key,
          acmaId: args.acmaId,
        ),
      );
    },
    AcmaBilgiDetayRoute.name: (routeData) {
      final args = routeData.argsAs<AcmaBilgiDetayRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: AcmaBilgiDetayScreen(
          key: args.key,
          acmaBilgi: args.acmaBilgi,
        ),
      );
    },
    AcmaBilgiRoute.name: (routeData) {
      final args = routeData.argsAs<AcmaBilgiRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: AcmaBilgiScreen(
          key: args.key,
          acmaId: args.acmaId,
        ),
      );
    },
    AcmaRoute.name: (routeData) {
      final args = routeData.argsAs<AcmaRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: AcmaScreen(
          key: args.key,
          kaziId: args.kaziId,
        ),
      );
    },
    GetImageRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const GetImageScreen(),
      );
    },
    KaziAddRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const KaziAddScreen(),
      );
    },
    KaziRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const KaziScreen(),
      );
    },
    KaziUserAddRoute.name: (routeData) {
      final args = routeData.argsAs<KaziUserAddRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: KaziUserAddScreen(
          key: args.key,
          kaziId: args.kaziId,
        ),
      );
    },
    LoginRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const LoginScreen(),
      );
    },
    RegisterRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const RegisterScreen(),
      );
    },
    SettingRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SettingScreen(),
      );
    },
    SplashRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SplashScreen(),
      );
    },
  };
}

/// generated route for
/// [AcmaAddScreen]
class AcmaAddRoute extends PageRouteInfo<AcmaAddRouteArgs> {
  AcmaAddRoute({
    Key? key,
    required int kaziId,
    List<PageRouteInfo>? children,
  }) : super(
          AcmaAddRoute.name,
          args: AcmaAddRouteArgs(
            key: key,
            kaziId: kaziId,
          ),
          initialChildren: children,
        );

  static const String name = 'AcmaAddRoute';

  static const PageInfo<AcmaAddRouteArgs> page =
      PageInfo<AcmaAddRouteArgs>(name);
}

class AcmaAddRouteArgs {
  const AcmaAddRouteArgs({
    this.key,
    required this.kaziId,
  });

  final Key? key;

  final int kaziId;

  @override
  String toString() {
    return 'AcmaAddRouteArgs{key: $key, kaziId: $kaziId}';
  }
}

/// generated route for
/// [AcmaBilgiAddScreen]
class AcmaBilgiAddRoute extends PageRouteInfo<AcmaBilgiAddRouteArgs> {
  AcmaBilgiAddRoute({
    Key? key,
    required int acmaId,
    List<PageRouteInfo>? children,
  }) : super(
          AcmaBilgiAddRoute.name,
          args: AcmaBilgiAddRouteArgs(
            key: key,
            acmaId: acmaId,
          ),
          initialChildren: children,
        );

  static const String name = 'AcmaBilgiAddRoute';

  static const PageInfo<AcmaBilgiAddRouteArgs> page =
      PageInfo<AcmaBilgiAddRouteArgs>(name);
}

class AcmaBilgiAddRouteArgs {
  const AcmaBilgiAddRouteArgs({
    this.key,
    required this.acmaId,
  });

  final Key? key;

  final int acmaId;

  @override
  String toString() {
    return 'AcmaBilgiAddRouteArgs{key: $key, acmaId: $acmaId}';
  }
}

/// generated route for
/// [AcmaBilgiDetayScreen]
class AcmaBilgiDetayRoute extends PageRouteInfo<AcmaBilgiDetayRouteArgs> {
  AcmaBilgiDetayRoute({
    Key? key,
    required AcmaBilgileri acmaBilgi,
    List<PageRouteInfo>? children,
  }) : super(
          AcmaBilgiDetayRoute.name,
          args: AcmaBilgiDetayRouteArgs(
            key: key,
            acmaBilgi: acmaBilgi,
          ),
          initialChildren: children,
        );

  static const String name = 'AcmaBilgiDetayRoute';

  static const PageInfo<AcmaBilgiDetayRouteArgs> page =
      PageInfo<AcmaBilgiDetayRouteArgs>(name);
}

class AcmaBilgiDetayRouteArgs {
  const AcmaBilgiDetayRouteArgs({
    this.key,
    required this.acmaBilgi,
  });

  final Key? key;

  final AcmaBilgileri acmaBilgi;

  @override
  String toString() {
    return 'AcmaBilgiDetayRouteArgs{key: $key, acmaBilgi: $acmaBilgi}';
  }
}

/// generated route for
/// [AcmaBilgiScreen]
class AcmaBilgiRoute extends PageRouteInfo<AcmaBilgiRouteArgs> {
  AcmaBilgiRoute({
    Key? key,
    required int acmaId,
    List<PageRouteInfo>? children,
  }) : super(
          AcmaBilgiRoute.name,
          args: AcmaBilgiRouteArgs(
            key: key,
            acmaId: acmaId,
          ),
          initialChildren: children,
        );

  static const String name = 'AcmaBilgiRoute';

  static const PageInfo<AcmaBilgiRouteArgs> page =
      PageInfo<AcmaBilgiRouteArgs>(name);
}

class AcmaBilgiRouteArgs {
  const AcmaBilgiRouteArgs({
    this.key,
    required this.acmaId,
  });

  final Key? key;

  final int acmaId;

  @override
  String toString() {
    return 'AcmaBilgiRouteArgs{key: $key, acmaId: $acmaId}';
  }
}

/// generated route for
/// [AcmaScreen]
class AcmaRoute extends PageRouteInfo<AcmaRouteArgs> {
  AcmaRoute({
    Key? key,
    required int kaziId,
    List<PageRouteInfo>? children,
  }) : super(
          AcmaRoute.name,
          args: AcmaRouteArgs(
            key: key,
            kaziId: kaziId,
          ),
          initialChildren: children,
        );

  static const String name = 'AcmaRoute';

  static const PageInfo<AcmaRouteArgs> page = PageInfo<AcmaRouteArgs>(name);
}

class AcmaRouteArgs {
  const AcmaRouteArgs({
    this.key,
    required this.kaziId,
  });

  final Key? key;

  final int kaziId;

  @override
  String toString() {
    return 'AcmaRouteArgs{key: $key, kaziId: $kaziId}';
  }
}

/// generated route for
/// [GetImageScreen]
class GetImageRoute extends PageRouteInfo<void> {
  const GetImageRoute({List<PageRouteInfo>? children})
      : super(
          GetImageRoute.name,
          initialChildren: children,
        );

  static const String name = 'GetImageRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [KaziAddScreen]
class KaziAddRoute extends PageRouteInfo<void> {
  const KaziAddRoute({List<PageRouteInfo>? children})
      : super(
          KaziAddRoute.name,
          initialChildren: children,
        );

  static const String name = 'KaziAddRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [KaziScreen]
class KaziRoute extends PageRouteInfo<void> {
  const KaziRoute({List<PageRouteInfo>? children})
      : super(
          KaziRoute.name,
          initialChildren: children,
        );

  static const String name = 'KaziRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [KaziUserAddScreen]
class KaziUserAddRoute extends PageRouteInfo<KaziUserAddRouteArgs> {
  KaziUserAddRoute({
    Key? key,
    required int kaziId,
    List<PageRouteInfo>? children,
  }) : super(
          KaziUserAddRoute.name,
          args: KaziUserAddRouteArgs(
            key: key,
            kaziId: kaziId,
          ),
          initialChildren: children,
        );

  static const String name = 'KaziUserAddRoute';

  static const PageInfo<KaziUserAddRouteArgs> page =
      PageInfo<KaziUserAddRouteArgs>(name);
}

class KaziUserAddRouteArgs {
  const KaziUserAddRouteArgs({
    this.key,
    required this.kaziId,
  });

  final Key? key;

  final int kaziId;

  @override
  String toString() {
    return 'KaziUserAddRouteArgs{key: $key, kaziId: $kaziId}';
  }
}

/// generated route for
/// [LoginScreen]
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute({List<PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [RegisterScreen]
class RegisterRoute extends PageRouteInfo<void> {
  const RegisterRoute({List<PageRouteInfo>? children})
      : super(
          RegisterRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegisterRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SettingScreen]
class SettingRoute extends PageRouteInfo<void> {
  const SettingRoute({List<PageRouteInfo>? children})
      : super(
          SettingRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SplashScreen]
class SplashRoute extends PageRouteInfo<void> {
  const SplashRoute({List<PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
