import 'package:covid19/Enums/enum.dart';
import 'package:covid19/Model/User.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BaseModel extends ChangeNotifier {
  ViewState _viewState = ViewState.Idle;
  Firestore _fireStore = Firestore.instance;
  FirebaseUser _fireUser;
  User _user;

  User get user => _user;

  ViewState get viewState => _viewState;

  Firestore get fireStore => _fireStore;

  FirebaseUser get fireUser => _fireUser;

  setBusy() {
    _viewState == ViewState.Busy
        ? print("already busy")
        : _viewState = ViewState.Busy;
    notifyListeners();
  }

  setIdle() {
    _viewState == ViewState.Idle
        ? print("already Idle")
        : _viewState = ViewState.Idle;
    notifyListeners();
  }

  setUser(FirebaseUser fireUser) {
    this.fireUser;
    notifyListeners();
  }
}
