import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled3/core/constant/constant.dart';

class ThemeCubit extends Cubit<ThemeData> {
  /// {@macro brightness_cubit}
  ThemeCubit() : super(_lightTheme);
  ThemeData themeGlobal = _lightTheme;
  //later we should read default theme from preferences in init function
  //so we define light or dark
  AppTheme globalAppTheme = AppTheme.fromType(ThemeType.light);
  static final _lightTheme = AppTheme.fromType(ThemeType.light).themeData;
  // ThemeData(
  //   floatingActionButtonTheme: const FloatingActionButtonThemeData(
  //     foregroundColor: Colors.white,
  //   ),
  //   brightness: Brightness.light,
  // );
  static final _darkTheme = AppTheme.fromType(ThemeType.dark).themeData;
  // ThemeData(
  //   floatingActionButtonTheme: const FloatingActionButtonThemeData(
  //     foregroundColor: Colors.black,
  //   ),
  //   brightness: Brightness.dark,
  // );

  /// Toggles the current brightness between light and dark.
  // void toggleTheme() {
  //   emit(state.brightness == Brightness.dark ? _lightTheme : _darkTheme);
  // }
  void toggleTwinTheme() {
    if (state.brightness == Brightness.dark) {
      globalAppTheme = AppTheme.fromType(ThemeType.light);
      themeGlobal = globalAppTheme.themeData;
    } else {
      globalAppTheme = AppTheme.fromType(ThemeType.dark);
      themeGlobal = globalAppTheme.themeData;
    }
    emit(themeGlobal);
    //emit(state.brightness == Brightness.dark ? _lightTheme : _darkTheme);
  }
}
