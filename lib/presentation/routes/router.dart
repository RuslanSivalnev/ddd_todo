import 'package:auto_route/annotations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_to_do_ddd/presentation/notes/note_form/note_form_page.dart';
import 'package:flutter_to_do_ddd/presentation/notes/notes_overview/notes_overview_page.dart';
import 'package:flutter_to_do_ddd/presentation/sign_in/sign_in_page.dart';
import 'package:flutter_to_do_ddd/presentation/splash/splash_page.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    AutoRoute(page: SplashPage, initial: true, path: '/'),
    AutoRoute(page: SignInPage, path: '/sign-in-page'),
    AutoRoute(page: NotesOverviewPage),
    AutoRoute(page: NoteFormPage, fullscreenDialog: true),
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
