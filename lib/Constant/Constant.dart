import 'package:flutter/material.dart';

const String initialRoute = '/';
const String homeRoute = '/home';
const String mapRoute = '/map';
const String sendIssuesRoute = '/sendIssue';
const String menuRoute = '/menu';
const String loginRoute = '/login';
const String intemediateRoute = '/intemediate';

const textInputDecoration = InputDecoration(
  fillColor: Colors.black12,
  filled: true,
  labelStyle: TextStyle(color: Colors.black54),
  focusColor: Colors.limeAccent,
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black, width: 2),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black12, width: 2),
  ),
);
