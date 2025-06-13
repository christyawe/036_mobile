import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

import 'home_screen.dart';
import 'result_screen.dart';
import 'login_screen.dart';
import 'quiz_screen.dart';
import 'name_input_screen.dart';
import 'history_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: MyApp(),
    ),
  );
}

class ThemeProvider extends ChangeNotifier {
  bool isDarkMode = false;

  void toggleTheme() {
    isDarkMode = !isDarkMode;
    notifyListeners();
  }

  ThemeData get currentTheme {
    return isDarkMode ? ThemeData.dark() : ThemeData.light().copyWith(
      primaryColor: Colors.pink,
      scaffoldBackgroundColor: Colors.pink[50],
      textTheme: GoogleFonts.quicksandTextTheme(),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.pinkAccent,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          textStyle: GoogleFonts.quicksand(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  Future<Widget> _getStartScreen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString('username');
    return (username == null || username.isEmpty) ? LoginScreen() : HomeScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        return FutureBuilder(
          future: _getStartScreen(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return MaterialApp(
                title: 'Tes Kepribadian MBTI',
                theme: themeProvider.currentTheme,
                home: snapshot.data as Widget,
                onGenerateRoute: (settings) {
                  if (settings.name == '/result') {
                    final args = settings.arguments as Map;
                    return MaterialPageRoute(
                      builder: (context) => ResultScreen(
                        scores: args['scores'],
                        nama: args['nama'],
                      ),
                    );
                  }
                  return null;
                },
                routes: {
                  '/home': (context) => HomeScreen(),
                  '/quiz': (context) => QuizScreen(nama: ''),
                  '/name_input': (context) => NameInputScreen(),
                  '/history': (context) => HistoryScreen(),
                },
              );
            } else {
              return MaterialApp(home: Center(child: CircularProgressIndicator()));
            }
          },
        );
      },
    );
  }
}
