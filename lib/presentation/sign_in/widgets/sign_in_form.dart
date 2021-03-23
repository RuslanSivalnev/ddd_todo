import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_to_do_ddd/application/auth/sign_in_form/sign_in_form_bloc.dart';

class SignInForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInFormBloc, SignInFormState>(
      listener: (context, state) {
        state.authFailureOrSuccess.fold(
          () => null,
          (either) => either.fold(
            (failure) => {
              FlushbarHelper.createError(
                message: failure.map(
                  cancelledByUser: (_) => 'Cancelled',
                  serverError: (_) => 'Server error',
                  emailAlreadyInUse: (_) => 'Email already in use',
                  invalidEmailAndPasswordCombination: (_) => 'Invalid email and password combination',
                ),
              ).show(context)
            },
            (_) => null,
          ),
        );
      },
      builder: (context, state) {
        return Form(
          autovalidate: state.showErrorMessages,
          child: ListView(
            children: [
              const Text(
                '📝',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 130),
              ),
              const SizedBox(height: 8),
              TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  labelText: 'Email',
                ),
                autocorrect: false,
                onChanged: (value) =>
                    BlocProvider.of<SignInFormBloc>(context).add(SignInFormEvent.emailChanged(emailStr: value)),
                validator: (_) => BlocProvider.of<SignInFormBloc>(context).state.emailAddress.value.fold(
                      (f) => f.maybeMap(
                        invalidEmail: (_) => 'Invalid Email',
                        orElse: () => null,
                      ),
                      (_) => null,
                    ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  labelText: 'Password',
                ),
                autocorrect: false,
                obscureText: true,
                onChanged: (value) =>
                    BlocProvider.of<SignInFormBloc>(context).add(SignInFormEvent.passwordChanged(passwordStr: value)),
                validator: (_) => BlocProvider.of<SignInFormBloc>(context).state.password.value.fold(
                      (f) => f.maybeMap(
                        shortPassword: (_) => 'Short Password',
                        orElse: () => null,
                      ),
                      (_) => null,
                    ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        BlocProvider.of<SignInFormBloc>(context).add(
                          const SignInFormEvent.signInWithEmailAndPasswordPressed(),
                        );
                      },
                      child: const Text('SIGN IN'),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        BlocProvider.of<SignInFormBloc>(context).add(
                          const SignInFormEvent.registerWithEmailAndPasswordPressed(),
                        );
                      },
                      child: const Text('SIGN IN'),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  BlocProvider.of<SignInFormBloc>(context).add(
                    const SignInFormEvent.signInWithGooglePressed(),
                  );
                },
                style: ElevatedButton.styleFrom(primary: Colors.lightBlue),
                child: const Text(
                  'SIGN IN WITH GOOGLE',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
