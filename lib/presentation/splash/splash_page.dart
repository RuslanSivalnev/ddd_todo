import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_to_do_ddd/application/auth/auth_bloc.dart';
import 'package:flutter_to_do_ddd/presentation/routes/router.gr.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        state.map(
          initial: (_) {
            return AutoRouter.of(context).replace(const SignInPageRoute());
          },
          authenticated: (_) {
            return AutoRouter.of(context).replace(const NotesOverviewPageRoute());
          },
          unauthenticated: (_) {
            return AutoRouter.of(context).replace(const SignInPageRoute());
          },
        );
      },
      child: const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
