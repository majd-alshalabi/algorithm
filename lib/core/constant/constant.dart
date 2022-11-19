import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

enum ThemeType {
  light,
  dark,
}

class AppTheme {
  static ThemeType defaultTheme = ThemeType.dark;

  bool isDark;
  Color bg1; //
  Color surface; //
  Color bg2;
  Color accent1;
  Color accent1Dark;
  Color accent1Darker;
  Color green;
  Color accent2;
  Color accent3;
  Color grey;
  Color greyStrong;
  Color greyWeak;
  Color error;
  Color focus;
  Color txt;
  Color accentTxt;
  Color primeColor;
  Color red;
  Color activeSwitchColor;
  Color inactiveSwitchColor;
  Color textFieldGreyColor;
  InputDecorationTheme inputDecorationTheme;
  Color calendarIcon;
  Color lightGrey;

  /// Default constructor
  AppTheme(
      {required this.inactiveSwitchColor,
      required this.activeSwitchColor,
      required this.isDark,
      required this.green,
      required this.primeColor,
      required this.bg1,
      required this.surface,
      required this.bg2,
      required this.red,
      required this.accent1,
      required this.accent1Dark,
      required this.accent1Darker,
      required this.accent2,
      required this.accent3,
      required this.grey,
      required this.greyStrong,
      required this.greyWeak,
      required this.error,
      required this.focus,
      required this.txt,
      required this.accentTxt,
      required this.inputDecorationTheme,
      required this.textFieldGreyColor,
      required this.calendarIcon,
      required this.lightGrey});

  /// fromType factory constructor
  factory AppTheme.fromType(ThemeType t) {
    switch (t) {
      case ThemeType.light:
        return AppTheme(
          lightGrey: const Color(0xFF979797),
          calendarIcon: const Color(0xffAFC745),
          inputDecorationTheme: const InputDecorationTheme(
            fillColor: Color(0xffE6E6E6),
            filled: true,
            border: InputBorder.none,
            disabledBorder: UnderlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            errorBorder: UnderlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            focusedErrorBorder: UnderlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
          ),
          red: const Color(0xFFD60F0F),
          green: const Color(0xFF628303),
          inactiveSwitchColor: const Color(0xff9E9E9E),
          activeSwitchColor: const Color(0xff52E558),
          primeColor: const Color(0xffAEE80A),
          isDark: false,
          txt: Colors.black,
          accentTxt: Colors.white,
          bg1: const Color(0xfff1f7f0),
          bg2: const Color(0xffc1dcbc),
          surface: Colors.white,
          accent1: const Color(0xff00a086),
          accent1Dark: const Color(0xff00856f),
          accent1Darker: const Color(0xff006b5a),
          // scroll over color
          accent2: const Color(0xff5bc91a),
          accent3: const Color(0xff5bc91a),
          greyWeak: const Color(0xff909f9c),
          grey: const Color(0xff515d5a),
          greyStrong: const Color(0xff151918),
          error: Colors.red.shade900,
          focus: const Color(0xFF0ee2b1),
          textFieldGreyColor: const Color(0xffE6E6E6),
        );

      case ThemeType.dark:
        return AppTheme(
          lightGrey: const Color(0xFF979797),
          calendarIcon: const Color(0xffAFC745),
          textFieldGreyColor: const Color(0xffE6E6E6),
          inputDecorationTheme: const InputDecorationTheme(
            fillColor: Color(0xffE6E6E6),
            filled: true,
            border: InputBorder.none,
            disabledBorder: UnderlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            errorBorder: UnderlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            focusedErrorBorder: UnderlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
          ),
          inactiveSwitchColor: const Color(0xff9E9E9E),
          activeSwitchColor: const Color(0xff52E558),
          green: const Color(0xFF628303),
          primeColor: const Color(0xffAEE80A),
          red: const Color(0xFFD60F0F),
          isDark: true,
          txt: Colors.white,
          accentTxt: Colors.black,
          bg1: const Color(0xff121212),
          bg2: const Color(0xff2c2c2c),
          surface: const Color(0xff252525),
          accent1: const Color(0xff00a086),
          accent1Dark: const Color(0xff00caa5),
          accent1Darker: const Color(0xff00caa5),
          accent2: const Color(0xfff19e46),
          accent3: const Color(0xff5BC91A),
          greyWeak: const Color(0xffa8b3b0),
          grey: const Color(0xffced4d3),
          greyStrong: const Color(0xffffffff),
          error: const Color(0xffe55642),
          focus: const Color(0xff0ee2b1),
        );
      /*
           case ThemeType.twinDark:
        return AppTheme(isDark: true)
          ..bg1 = Color(0xff212529)
          ..surface = Color(0xff2a2e32)
          ..bg2 = Color(0xff272b2f)
          ..accent1 = Color(0xff00a086)
          ..accent1Dark = Color(0xff00856f)
          ..accent1Darker = Color(0xff006b5a)
          ..accent2 = Color(0xfff09433)
          ..accent3 = Color(0xff5bc91a)
          ..greyWeak = Color(0xff151918)
          ..grey = Color(0xff6c6c6c)
          ..greyStrong = Color(0xff909f9c)
          ..error = Colors.red.shade900
          ..focus = Color(0xb30ee2b1);
         */
    }
  }

  ThemeData toThemeData() {
    var t = ThemeData.from(
      // Use the .dark() and .light() constructors to handle the text themes
      textTheme: (isDark ? ThemeData.dark() : ThemeData.light()).textTheme,
      // Use ColorScheme to generate the bulk of the color theme
      colorScheme: ColorScheme(
          brightness: isDark ? Brightness.dark : Brightness.light,
          primary: accent1,
          primaryContainer: shift(accent1, .1),
          secondary: accent1,
          secondaryContainer: shift(accent1, .1),
          background: bg1,
          surface: surface,
          onBackground: txt,
          onSurface: txt,
          onError: txt,
          onPrimary: accentTxt,
          onSecondary: accentTxt,
          error: error),
    );
    // Apply additional styling that is missed by ColorScheme
    t.copyWith(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: accent1,
          selectionHandleColor: Colors.transparent,
          selectionColor: greyWeak,
        ),
        highlightColor: Colors.transparent,
        toggleableActiveColor: accent1);
    // All done, return the ThemeData
    return t;
  }

  ThemeData get themeData {
    var t = ThemeData.from(
      textTheme: (isDark ? ThemeData.dark() : ThemeData.light()).textTheme,
      colorScheme: ColorScheme(
          brightness: isDark ? Brightness.dark : Brightness.light,
          primary: accent1,
          primaryContainer: accent1Darker,
          secondary: accent2,
          secondaryContainer: ColorUtils.shiftHsl(accent2, -.2),
          background: bg1,
          surface: surface,
          onBackground: txt,
          onSurface: txt,
          onError: txt,
          onPrimary: accentTxt,
          onSecondary: accentTxt,
          error: error),
    );

    return t.copyWith(
        appBarTheme: AppBarTheme(
          color: Colors.black,
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 18.sp,

            ///TODO add font family
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          border: InputBorder.none,
          disabledBorder: UnderlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          errorBorder: UnderlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          focusedErrorBorder: UnderlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
        ),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        textSelectionTheme: TextSelectionThemeData(
          selectionColor: greyWeak,
          selectionHandleColor: Colors.transparent,
          cursorColor: accent1,
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: accent1,
        ),
        highlightColor: Colors.transparent,
        toggleableActiveColor: accent1);
  }

  Color shift(Color c, double d) =>
      ColorUtils.shiftHsl(c, d * (isDark ? -1 : 1));
}

class ColorUtils {
  static Color shiftHsl(Color c, [double amt = 0]) {
    var hslc = HSLColor.fromColor(c);
    return hslc.withLightness((hslc.lightness + amt).clamp(0.0, 1.0)).toColor();
  }

  static Color parseHex(String value) =>
      Color(int.parse(value.substring(1, 7), radix: 16) + 0xFF000000);

  static Color blend(Color dst, Color src, double opacity) {
    return Color.fromARGB(
      255,
      (dst.red.toDouble() * (1.0 - opacity) + src.red.toDouble() * opacity)
          .toInt(),
      (dst.green.toDouble() * (1.0 - opacity) + src.green.toDouble() * opacity)
          .toInt(),
      (dst.blue.toDouble() * (1.0 - opacity) + src.blue.toDouble() * opacity)
          .toInt(),
    );
  }
}

class Stack<E> {
  final _list = <E>[];

  void push(E value) => _list.add(value);

  E pop() => _list.removeLast();

  E get peek => _list.last;

  bool get isEmpty => _list.isEmpty;
  bool get isNotEmpty => _list.isNotEmpty;

  List<E> get list => _list;

  @override
  String toString() => _list.toString();
}
