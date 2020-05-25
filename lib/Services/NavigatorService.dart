import 'package:flutter/material.dart';

class NavigatorService {
  final GlobalKey<NavigatorState> globalKey = GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(String routeName) {
    return globalKey.currentState.pushNamed(routeName);
  }

  void goBack() {
    return globalKey.currentState.pop();
  }

  Future<dynamic> permanentNavigateTo(String routeName) {
    return globalKey.currentState.pushReplacementNamed(routeName);
  }
}
