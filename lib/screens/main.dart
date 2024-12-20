import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/home_page.dart'; 

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  runApp(const SkipApp()); 
}

class SkipApp extends StatelessWidget {
  const SkipApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Skip App',
      theme: ThemeData(
        primaryColor: const Color(0xFF008000),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF008000),
        ),
        textTheme: GoogleFonts.openSansTextTheme(),
      ),
      home: HomePage(), 
    );
  }
}
