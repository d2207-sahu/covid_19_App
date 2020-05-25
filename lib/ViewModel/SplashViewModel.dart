import 'package:covid19/Constant/Constant.dart';
import 'package:covid19/Services/NavigatorService.dart';
import 'package:covid19/ViewModel/BaseModel.dart';
import 'package:covid19/locator.dart';

class SplashViewModel extends BaseModel {
  final _navigatorService = locator<NavigatorService>();

  Future navigateToHome() {
    setBusy();
    return Future.delayed(Duration(seconds: 2), () {
      setIdle();
      fireUser != null
          ? _navigatorService.permanentNavigateTo(homeRoute)
          : _navigatorService.permanentNavigateTo(intemediateRoute);
    });
  }
}
