import 'package:auto_route/annotations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_to_do_ddd/presentation/sign_in/sign_in_page.dart';
import 'package:flutter_to_do_ddd/presentation/splash/splash_page.dart';

@MaterialAutoRouter(
  generateNavigationHelperExtension: true,
  routes: [
    AutoRoute(page: SplashPage, initial: true, path: '/'),
    AutoRoute(page: SignInPage, path: '/sign-in-page'),
  ],
)
class $AppRouter {}

class RouteProvider extends InheritedWidget {
  const RouteProvider({required Widget child}) : super(child: child);

  @override
  bool updateShouldNotify(_) {
    return false;
  }
}
