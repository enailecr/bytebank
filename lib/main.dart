import 'package:flutter/material.dart';
import 'package:bytebank/models/saldo.dart';
import 'package:bytebank/screens/dashboard/dashboard.dart';
import 'package:provider/provider.dart';

import 'models/transferencias.dart';

void main() {
  runApp(
    MultiProvider(
      child: BytebanckApp(),
      providers: [
        ChangeNotifierProvider(
          create: (context) => Saldo(0),
        ),
        ChangeNotifierProvider(
          create: (context) => Transferencias(),
        ),
      ],
    ),
  );
}

class BytebanckApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Dashboard(),
      theme: ThemeData(
        primaryColor: Colors.green[900],
        accentColor: Colors.blueAccent[700],
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.blueAccent[700],
          textTheme: ButtonTextTheme.primary,
        ),
      ),
    );
  }
}
