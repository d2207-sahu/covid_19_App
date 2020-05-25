import 'dart:ui';
import 'package:covid19/Model/User.dart';
import 'package:covid19/ViewModel/HomeViewModel.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

final GlobalKey _scaffoldKey = new GlobalKey();

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _context = context;
    final _user = Provider.of<User>(context);
    return ChangeNotifierProvider(
      create: (BuildContext context) => HomeViewModel(),
      child: Consumer<HomeViewModel>(
        builder: (conte, model, child) => Scaffold(
          key: _scaffoldKey,
          drawer: Container(
            padding: EdgeInsets.all(0),
            width: MediaQuery.of(context).size.width * 0.7,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
//                topRight: Radius.elliptical(90.0, 10.2),
                bottomRight: Radius.elliptical(130.0, 70.2),
              ),
            ),
            child: ListView(
              children: <Widget>[
                SizedBox(
                  height: 300,
                  child: DrawerHeader(
                    padding: EdgeInsets.all(0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 20,
                          ),
                          CircleAvatar(
                            radius: 100,
                            backgroundImage: NetworkImage(_user.user.photoUrl),
                            backgroundColor: Colors.transparent,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Text(
                                _user.user.displayName,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              IconButton(
                                color: Colors.white,
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      child: new AlertDialog(
                                        title:
                                            new Text("Do You Want to Logout"),
//                                        content: new Text("Are You Sure ?"),
                                        semanticLabel: "Are You Sure ?",
                                        actions: <Widget>[
                                          FlatButton(
                                            onPressed: () {
                                              Navigator.pop(context);

//                                              TODO: Had to call From Viewmodel and logout in services
                                            },
                                            child: Text('OK'),
                                          ),
                                          FlatButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text('Cancel'),
                                          ),
                                        ],
                                      ));
                                  print('Logout');
                                },
                                icon: Icon(Icons.exit_to_app),
                              )
                            ],
                          ),
                        ],
                      ),
                      color: Colors.green,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    print('Account');
                  },
                  child: ListTile(
                    leading: Icon(Icons.account_circle),
                    title: Text('Account'),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    print('Settings');
                  },
                  child: ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('Settings'),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    print('ContactUs');
                  },
                  child: ListTile(
                    leading: Icon(Icons.help_outline),
                    title: Text('ContactUs'),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                print("pressed");
                Scaffold.of(context).openDrawer();
              },
            ),
            brightness: Brightness.dark,
            title: Text(
              "COVID-19 Help",
            ),
            centerTitle: true,
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    child: RaisedButton(
                      color: Colors.blue,
                      elevation: 5,
                      child: Text(
                        "See Issues Arround You!",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        model.navigateToMaps();
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    child: RaisedButton(
                      color: Colors.blue,
                      elevation: 5,
                      child: Text(
                        "Report Issues Near You",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        model.navigateToSendIssues();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
