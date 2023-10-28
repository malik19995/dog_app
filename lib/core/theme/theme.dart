import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

final themeProvider = ChangeNotifierProvider<AppThemes>((ref) => AppThemes());

class AppThemes extends ChangeNotifier {
  String _currentThemeId = defaultThemeId;

  AppTheme get current => _appThemes[_currentThemeId]!;

  void setCurrentThemeId(String themeId) {
    _currentThemeId = themeId;

    notifyListeners();
  }
}

class AppTheme {
  final String id;

  final ThemeData themeData;

  const AppTheme({
    required this.id,
    required this.themeData,
  });
}

const defaultThemeId = 'default';
const secondaryThemeId = 'secondary';

const _primaryTextColor = Color.fromRGBO(82, 92, 111, 1);
const _primaryColour = Color.fromRGBO(19, 0, 65, 1);

const scaffoldBack = Color(0xff000058);
const scaffoldBackSec = Color(0xff221242);
const _buttonBackground = Color.fromRGBO(29, 36, 52, 1);
const _buttonForeground = Color.fromRGBO(82, 92, 111, 1);

final _appThemes = {
  defaultThemeId: AppTheme(
    id: defaultThemeId,
    themeData: ThemeData.dark().copyWith(
      useMaterial3: true,
      primaryTextTheme: TextTheme(
        titleLarge: GoogleFonts.montserrat(
          color: Colors.white,
          fontSize: 18,
        ),
        bodyLarge: GoogleFonts.montserrat(
          color: _primaryTextColor,
          fontSize: 18,
        ),
        bodyMedium: GoogleFonts.montserrat(
          color: _primaryTextColor,
          fontSize: 16,
        ),
        bodySmall: GoogleFonts.montserrat(
          color: _primaryTextColor,
          fontSize: 14,
        ),
      ),
      primaryColor: _primaryColour,
      navigationBarTheme: const NavigationBarThemeData(
        backgroundColor: _primaryColour,
        elevation: 1,
        surfaceTintColor: Colors.white,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: _primaryColour,
        elevation: 1,
      ),
      scaffoldBackgroundColor: scaffoldBack,
      colorScheme: const ColorScheme.dark(
        primary: Color(0xff17A6FB),
        secondary: Color.fromARGB(255, 40, 44, 113),
        onPrimary: Color.fromARGB(255, 205, 207, 211),
        onSecondary: Color.fromARGB(255, 214, 215, 225),
        background: Color(0xff21216E),
        error: Colors.red,
        onError: Colors.white,
        surface: Colors.white,
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            _buttonBackground,
          ),
          foregroundColor: MaterialStateProperty.all<Color>(
            _buttonForeground,
          ),
        ),
      ),
      textTheme: GoogleFonts.montserratTextTheme(
        TextTheme(
          bodyLarge: GoogleFonts.montserrat(color: _primaryTextColor),
          bodyMedium: GoogleFonts.montserrat(color: _primaryTextColor),
          bodySmall: GoogleFonts.montserrat(color: _primaryTextColor),
          headlineSmall: GoogleFonts.montserrat(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
          titleSmall: GoogleFonts.montserrat(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ),
  ),
  secondaryThemeId: AppTheme(
    id: secondaryThemeId,
    themeData: ThemeData.dark().copyWith(
      useMaterial3: true,
      primaryTextTheme: TextTheme(
        bodyLarge: GoogleFonts.montserrat(
          color: _primaryTextColor,
        ),
        bodyMedium: GoogleFonts.montserrat(
          color: _primaryTextColor,
        ),
      ),
      primaryColor: _primaryColour,
      navigationBarTheme: const NavigationBarThemeData(
        backgroundColor: _primaryColour,
        elevation: 1,
        surfaceTintColor: Colors.white,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: _primaryColour,
        elevation: 1,
      ),
      scaffoldBackgroundColor: scaffoldBackSec,
      colorScheme: const ColorScheme.dark(
        primary: Color(0xffDD5C9C),
        onPrimary: Color(0xffEAAD3A),
        secondary: Color(0xffEAAD3A),
        onSecondary: Color(0x09ccdd5c),
        background: Color(0xff3D3258),
        error: Colors.red,
        onError: Colors.white,
        surface: Colors.white,
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            _buttonBackground,
          ),
          foregroundColor: MaterialStateProperty.all<Color>(
            _buttonForeground,
          ),
        ),
      ),
      textTheme: GoogleFonts.montserratTextTheme(
        TextTheme(
          bodyLarge: GoogleFonts.montserrat(color: _primaryTextColor),
          bodyMedium: GoogleFonts.montserrat(color: _primaryTextColor),
          bodySmall: GoogleFonts.montserrat(color: _primaryTextColor),
          headlineSmall: GoogleFonts.montserrat(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),
          titleSmall: GoogleFonts.montserrat(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ),
  ),
};
