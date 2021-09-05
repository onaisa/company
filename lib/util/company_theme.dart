import 'package:flutter/material.dart';

ThemeData MylightTheme() => ThemeData(
      textTheme: TextTheme(
        bodyText1: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        bodyText2: TextStyle(
          fontSize: 18.0,
        ),
      ),
      primaryColor: Colors.teal,
      primarySwatch: Colors.orange,
      appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(
          color: Colors.deepOrange,
        ),
        actionsIconTheme: IconThemeData(color: Colors.orange),
        elevation: 0.0,
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      scaffoldBackgroundColor: Colors.white,
    );
