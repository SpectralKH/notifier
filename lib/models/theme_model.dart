import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences prefs;

class ThemeModel extends Model {
  bool _darkMode = true;
  bool get darkMode => _darkMode;

  TextStyle get appTitleStyle => TextStyle(
        color: darkMode ? blue : Colors.white,
      );
  TextStyle get buttonTextStyle => TextStyle(
        fontWeight: FontWeight.w500,
      );

  Map<int, Color> get grey => <int, Color>{
        1: Color(0xFF121212),
        2: Color(0xFF202124),
        3: Color(0xFF313234),
        4: Color(0xFF43454c),
        5: Color(0xFF54565f),
        6: Color(0xFF676974),
        7: Colors.grey[500],
        8: Colors.grey[400],
        9: Colors.grey[100],
      };
  Map<int, Color> get white => <int, Color>{
        1: Colors.grey[100],
        2: Colors.grey[200],
        3: Colors.grey[300],
        4: Colors.grey[400],
        5: Colors.grey[500],
        6: Colors.grey[600],
        7: Colors.grey[700],
        8: Colors.grey[800],
        9: Colors.grey[900],
      };
  Map<int, Color> color;
  Color textColor, backgroundColor, splashColor, highlightColor, appBarBackgroundColor, descriptionColor, primaryButtonColor, primaryButtonDisabledColor, errorText, checkboxEnabledColor, checkboxDisabledColor;
  Color get blue => Color(0xFF000B0FF);

  ThemeData appTheme;
  ThemeData pickerTheme;

  static loadPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  ThemeModel() {
    bool darkModePreference = prefs.getBool('darkMode') ?? true;
    _setDarkMode(darkMode: darkModePreference);
  }

  toggleDarkMode() async {
    prefs.setBool('darkMode', !_darkMode);
    _setDarkMode(darkMode: !_darkMode);
    notifyListeners();
  }

  void _setDarkMode({bool darkMode}) {
    _darkMode = darkMode;
    print('[notifier] ThemeModel _setDarkMode() to $darkMode');

    color = darkMode ? grey : white;
    textColor = darkMode ? Colors.white : Colors.black;
    errorText = Colors.red[400];
    backgroundColor = color[1];
    descriptionColor = color[6];
    primaryButtonColor = darkMode ? color[4] : blue;
    primaryButtonDisabledColor = color[4].withOpacity(0.5);
    checkboxEnabledColor = darkMode ? color[8] : blue;
    checkboxDisabledColor = darkMode ? color[5] : color[6];
    splashColor = color[6].withOpacity(0.3);
    highlightColor = darkMode ? color[6].withOpacity(0.3) : color[6].withOpacity(0.2);
    appBarBackgroundColor = darkMode ? color[2] : blue;

    appTheme = ThemeData(
      fontFamily: 'Jost',
      brightness: darkMode ? Brightness.dark : Brightness.light,
      scaffoldBackgroundColor: backgroundColor,
      textSelectionColor: Colors.white24,
      textSelectionHandleColor: blue,
      accentColor: Colors.white,
      toggleableActiveColor: blue,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        foregroundColor: Colors.white,
        backgroundColor: darkMode ? color[3] : blue,
      ),
      buttonColor: Colors.yellowAccent,
      highlightColor: highlightColor,
      splashColor: splashColor,
      buttonTheme: ButtonThemeData(
        minWidth: 85,
        height: 35,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      cardTheme: CardTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      dialogTheme: DialogTheme(
        backgroundColor: darkMode ? color[2] : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );

    pickerTheme = ThemeData(
      accentColor: Colors.blue,
      brightness: darkMode ? Brightness.dark : Brightness.light,
    );
  }
}
