import 'package:covid19/Screens/SharedWidget/BaseView.dart';
import 'package:covid19/ViewModel/SplashViewModel.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<SplashViewModel>(
      onModelReady: (model) {
        model.navigateToHome();
      },
      builder: (context, model, child) => Scaffold(
        body: Container(
            color: Colors.white,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.live_help,
                    size: 200,
                    color: Colors.blue,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "COVID-19 Help",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
