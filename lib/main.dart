import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_to_do_ddd/injection.dart';
import 'package:flutter_to_do_ddd/presentation/core/app_widget.dart';
import 'package:injectable/injectable.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  configureInjection(Environment.prod);
  runApp(AppWidget());
}
