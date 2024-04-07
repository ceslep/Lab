// ignore_for_file: avoid_print

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lab/pages/home_laboratorio.dart';
import 'package:lab/providers/url_provider.dart';
import 'package:provider/provider.dart';
import 'package:desktop_window/desktop_window.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

const String titleApp = 'Laboratorio';
void main() {
  try {} catch (e) {
    print(e);
  }
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UrlProvider()),

        // Agrega más providers si es necesario
      ],
      child: const MainApp(),
    ),
  );
  if (Platform.isWindows) {
    DesktopWindow.setWindowSize(const Size(480, 1040));
  }
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UrlProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: titleApp,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
          useMaterial3: true,
        ),
        home: const HomeLaboratorio(title: titleApp),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('es'),
          Locale('en'), // English
        ],
      ),
    );
  }
}
