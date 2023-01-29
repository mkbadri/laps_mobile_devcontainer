import 'package:flutter/material.dart';

ThemeData basicTheme() {
  TextTheme _basicTextTheme(TextTheme base) {
    return base.copyWith(
        headline: base.headline.copyWith(
            fontFamily: 'Montserrat', fontSize: 22.0, color: Colors.black),
        title: base.title.copyWith(
            fontFamily: 'Montserrat', fontSize: 18.0, color: Colors.black),
        display1: base.display1.copyWith(
            fontFamily: 'Montserrat',
            fontSize: 18.0,
            color: Colors.blue,
            fontWeight: FontWeight.bold),
        display2: base.display1.copyWith(
            fontFamily: 'Montserrat',
            fontSize: 18.0,
            color: Colors.blue,
            fontWeight: FontWeight.bold),
        button: TextStyle(fontSize: 15, fontWeight: FontWeight.bold));
  }

  final ThemeData base = ThemeData.light();
  return base.copyWith(
    textTheme: _basicTextTheme(base.textTheme),
    primaryColor: Color(0xFF1E5085),
    iconTheme: IconThemeData(color: Color(0xFF1E5085), size: 30.0),
    buttonTheme: ButtonThemeData(
      buttonColor: Color(0xFF1E5085),
      textTheme: ButtonTextTheme.primary,
      padding: EdgeInsets.all(5),
    ),
  );
}

ThemeData appTheme = ThemeData(
    // Define the default brightness and colors.
    brightness: Brightness.light,
    backgroundColor: Colors.grey[600],
    //primarySwatch: Colors.grey[100],
    primaryColor: Color(0xFF1E5085),
    accentColor: Colors.deepOrange,

    // Define the default font family.
    fontFamily: 'Montserrat',

    // Define the default TextTheme. Use this to specify the default
    // text styling for headlines, titles, bodies of text, and more.
    textTheme: TextTheme(
      headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
      title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
      body1: TextStyle(fontSize: 14.0, fontFamily: 'Montserrat'),
    ),
    buttonTheme: ButtonThemeData(
        padding: EdgeInsets.all(5),
        //minWidth: 150,
        height: 40,
        buttonColor: Color(0xFF1E5085),
        textTheme: ButtonTextTheme.primary,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
            side: BorderSide(color: Color(0xFF1E5085)))));
