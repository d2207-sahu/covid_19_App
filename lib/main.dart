import 'package:covid19/Constant/Constant.dart';
import 'package:covid19/Model/User.dart';
import 'package:covid19/Routes/Router.dart';
import 'package:covid19/Services/LoginService.dart';
import 'package:covid19/Services/NavigatorService.dart';
import 'package:covid19/locator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ViewModel/BaseModel.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      child: MaterialApp(
        onGenerateRoute: Router.onGenerateRoute,
        initialRoute: initialRoute,
        navigatorKey: locator<NavigatorService>().globalKey,
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
      ),
      providers: [
        StreamProvider<User>.value(
          value: LoginService().user,
        ),
        Provider<BaseModel>(create: (_) => BaseModel()),
      ],
    );
  }
}
