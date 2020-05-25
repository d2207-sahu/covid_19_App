import 'package:covid19/Screens/HomeScreen.dart';
import 'package:covid19/Screens/IntemediateScreen.dart';
import 'package:covid19/Screens/LoginScreen.dart';
import 'package:covid19/Screens/MapsScreen.dart';
import 'package:covid19/Screens/SendIssues.dart';
import 'package:covid19/Screens/SplashScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:covid19/Constant/Constant.dart';

class Router {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case initialRoute:
        return MaterialPageRoute(builder: (context) => SplashScreen());
      case intemediateRoute:
        return MaterialPageRoute(builder: (context) => IntemediateScreen());
      case homeRoute:
        return MaterialPageRoute(builder: (context) => HomeScreen());
      case loginRoute:
        return MaterialPageRoute(builder: (context) => LoginScreen());
      case mapRoute:
        return MaterialPageRoute(builder: (context) => MapsScreen());
      case sendIssuesRoute:
        return MaterialPageRoute(builder: (context) => SendIssues());
      case menuRoute:
//        return MaterialPageRoute(builder: (context) => MenuScreen());
      default:
        return MaterialPageRoute(builder: (context) => ErrorScreen());
    }
  }
}

class ErrorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ErrorScreen"),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Container(
        child: Center(
          child: Text("Error"),
        ),
        color: Colors.red,
      ),
    );
  }
}
