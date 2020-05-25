import 'package:covid19/Model/User.dart';
import 'package:covid19/Screens/HomeScreen.dart';
import 'package:covid19/Screens/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IntemediateScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<User>(context);
    return _user != null ? HomeScreen() : LoginScreen();
  }
}
