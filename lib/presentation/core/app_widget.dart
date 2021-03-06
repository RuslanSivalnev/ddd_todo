import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_to_do_ddd/application/auth/auth_bloc.dart';
import 'package:flutter_to_do_ddd/presentation/routes/router.dart';
import 'package:flutter_to_do_ddd/presentation/routes/router.gr.dart';

import '../../injection.dart';

class AppWidget extends StatelessWidget {
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<AuthBloc>()..add(const AuthEvent.authCheckRequested())),
      ],
      child: MaterialApp.router(
        title: 'Notes',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light().copyWith(
            primaryColor: Colors.green[800],
            accentColor: Colors.blueAccent,
            floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: Colors.blue[900],
            ),
            inputDecorationTheme: InputDecorationTheme(
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            )),
        routerDelegate: _appRouter.delegate(),
        routeInformationParser: _appRouter.defaultRouteParser(),
        builder: (_, router) {
          return RouteProvider(child: router!);
        },
      ),
    );
  }
}
