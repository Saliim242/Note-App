import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'screens/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const XasuuQoreApp());
}

class XasuuQoreApp extends StatelessWidget {
  const XasuuQoreApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Xasuu Qore',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Color(0xffe9e9f3),
      ),
      home: XasuusQore(),
    );
  }
}
