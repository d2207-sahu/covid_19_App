import 'package:covid19/Enums/enum.dart';
import 'package:covid19/ViewModel/LoginViewModel.dart';
import 'package:flutter/material.dart';
import 'SharedWidget/BaseView.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<LoginViewModel>(
      onModelReady: (model) => model.checkLoggedIn(),
      builder: (context, model, child) => Scaffold(
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: SizedBox(
                  height: 60,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: RaisedButton(
                    elevation: 5,
                    highlightElevation: 20,
                    onPressed: () {
                      print("Button Pressed");
                      model.viewState == ViewState.Busy
                          ? print("Busy")
                          : model.loginThroughGoogle();
                    },
                    child: model.viewState == ViewState.Busy
                        ? Text("Processing")
                        : Text("Google"),
                  ),
                ),
              ),
              model.viewState == ViewState.Busy
                  ? Column(
                      children: <Widget>[
                        CircularProgressIndicator(),
                        FlatButton(
                          onPressed: () {
                            model.checkLoggedIn();
                            model.navigatetosplashscreen();
                          },
                          child: Text("cancel"),
                        )
                      ],
                    )
                  : Text(""),
            ],
          ),
        ),
      ),
    );
  }
}
