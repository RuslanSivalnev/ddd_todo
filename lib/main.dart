import 'package:flutter/material.dart';
import 'package:flutter_to_do_ddd/injection.dart';
import 'package:injectable/injectable.dart';

void main() {
  configureInjection(Environment.prod);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('app bar'),
        ),
        body: Center(
          child: Container(
            child: const Text('body'),
          ),
        ),
      ),
    );
  }
}

