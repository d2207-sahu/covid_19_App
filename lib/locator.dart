import 'package:covid19/Services/LoginService.dart';
import 'package:covid19/Services/NavigatorService.dart';
import 'package:covid19/Services/SendIssuesService.dart';
import 'package:covid19/ViewModel/LoginViewModel.dart';
import 'package:covid19/ViewModel/SendIssuesViewModel.dart';
import 'package:get_it/get_it.dart';
import 'ViewModel/SplashViewModel.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => NavigatorService());
  locator.registerLazySingleton(() => LoginViewModel());
  locator.registerLazySingleton(() => SplashViewModel());
  locator.registerLazySingleton(() => SendIssuesViewModel());
  locator.registerLazySingleton(() => LoginService());
  locator.registerLazySingleton(() => SendIssuesService());
}
