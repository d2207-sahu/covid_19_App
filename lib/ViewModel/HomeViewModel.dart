import 'package:covid19/Constant/Constant.dart';
import 'package:covid19/Services/NavigatorService.dart';
import 'package:covid19/locator.dart';
import 'package:flutter/cupertino.dart';

class HomeViewModel extends ChangeNotifier {
  final NavigatorService _navigatorService = locator<NavigatorService>();

  void navigateToMaps() {
    _navigatorService.navigateTo(mapRoute);
  }

  void navigateToSendIssues() {
    _navigatorService.navigateTo(sendIssuesRoute);
  }
}
