import 'package:flutter/material.dart';
import 'package:meeting_app/screens/home_screen.dart';
import 'package:meeting_app/utils/app_theme.dart';

void main() async {
  runApp(const MeetingApp());
}

class MeetingApp extends StatelessWidget {
  const MeetingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meeting App',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: const ColorScheme.dark(
          primary: AppTheme.primaryColor,
          secondary: AppTheme.accentColor,
          surface: AppTheme.surfaceColor,
          error: AppTheme.dangerColor,
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: AppTheme.textPrimary,
        ),
        scaffoldBackgroundColor: AppTheme.backgroundColor,
      ),
      home: const HomeScreen(),
    );
  }
}
