// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:get/get.dart';
import 'package:rehand/app_routes.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:rehand/consts.dart';
import 'package:rehand/firebase_options.dart';
import 'package:rehand/views/screens/auth/starting_page.dart';

void main() async {
  Gemini.init(apiKey: geminiApiKey);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: appRoutes,
      theme: ThemeData.light(
        useMaterial3: true,
      ),
      home: const StartingPage(),
    );
  }
}
