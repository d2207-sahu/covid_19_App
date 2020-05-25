import 'package:covid19/Constant/Constant.dart';
import 'package:covid19/Services/LoginService.dart';
import 'package:covid19/Services/NavigatorService.dart';
import 'package:covid19/ViewModel/BaseModel.dart';
import '../locator.dart';

class LoginViewModel extends BaseModel {
  final _loginService = locator<LoginService>();
  final _navigate = locator<NavigatorService>();

  void checkLoggedIn() {
    fireUser == null ? print("No User") : _navigate.navigateTo(homeRoute);
  }

  Future<bool> loginThroughGoogle() async {
    setBusy();
    try {
      dynamic result = await _loginService.loginThroughGoogle();
      print("###" + result);
      if (result is String) {
        print("error" + result);
      } else {
        setUser(result);
        print("User Setted To BaseService");
        _navigate.navigateTo(homeRoute);
        print(fireUser.toString() + " " + fireUser.email);
      }
      setIdle();
      return true;
    } catch (e) {
      setIdle();
      return true;
    }
  }

  void navigatetosplashscreen() {
    _navigate.navigateTo(loginRoute);
  }
}
