import 'package:covid19/Constant/Constant.dart';
import 'package:covid19/Enums/enum.dart';
import 'package:covid19/Model/User.dart';
import 'package:covid19/ViewModel/SendIssuesViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//TODO: Handle the error in the image pciking and cropping

class SendIssues extends StatefulWidget {
  @override
  _SendIssuesState createState() => _SendIssuesState();
}

class _SendIssuesState extends State<SendIssues> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<User>(context);
    final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
    return ChangeNotifierProvider<SendIssuesViewModel>(
//      TODO: Everytime you create this the new viewmodel creates not previous one have to make it global scope
      create: (BuildContext context) {
        return SendIssuesViewModel();
      },
      child: Consumer<SendIssuesViewModel>(
          builder: (BuildContext context, model, Widget child) {
        return Scaffold(
            appBar: AppBar(
              elevation: 0,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  size: 18,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              brightness: Brightness.light,
              backgroundColor: Colors.white,
              toolbarOpacity: 1.0,
              centerTitle: true,
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.refresh,
                    color: Colors.black,
                  ),
                  onPressed: () {},
                ),
              ],
              title: Text(
                'Send Issuses',
                style: TextStyle(color: Colors.black),
              ),
            ),
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () {
                if (_globalKey.currentState.validate()) {
                  return;
                }
                _globalKey.currentState.save();
                model.publishToFirebase();
              },
              icon: Icon(Icons.publish),
              label: Text("Publish"),
            ),
            body: Form(
              key: _globalKey,
              child: ListView(
                children: <Widget>[
                  //Add Images
                  Container(
                    margin: EdgeInsets.only(
                        top: 20, bottom: 10, right: 10, left: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.grey,
                    ),
                    child: AspectRatio(
                      aspectRatio: 1.778,
                      child: model.image == null
                          ? Center(
                              child: Text(
                              'No Image',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ))
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: Image.file(
                                model.image,
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const Text(
                          'Image',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            model.viewState == ViewState.Busy
                                ? CircularProgressIndicator(
                                    strokeWidth: 2,
                                  )
                                : SizedBox(
                                    width: 2,
                                  ),
                            RaisedButton(
                              textColor: Colors.white,
                              color: Colors.blue,
                              onPressed: () async {
                                model.viewState == ViewState.Busy
                                    ? print("Busy")
                                    : await model.selectImage();
                              },
                              child: model.viewState == ViewState.Busy
                                  ? Text(
                                      'Loading',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  : Text(
                                      'Add Image',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                  BasicDeatils(model),
                  IconDetails(model, context),
                  LocationDeatils(model, _user),
                  //Contact Details
                  PhoneDetails(model, _user),
                  EmailDetails(model, _user),
                ],
              ),
            ));
      }),
    );
  }

  Widget EmailDetails(SendIssuesViewModel model, User _user) {
    //    Email
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Text(
                'Email',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                '*Cannot Change',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
              left: 16.0, bottom: 64.0, top: 16.0, right: 16.0),
          child: TextFormField(
            decoration: textInputDecoration.copyWith(
              enabled: false,
              hintText: 'Email',
              suffixIcon: Icon(Icons.email),
            ),
            initialValue: _user.user.email,
          ),
        ),
      ],
    );
  }

  Widget PhoneDetails(SendIssuesViewModel model, User _user) {
    return //    PhoneNumber
        Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Text(
                'PhoneNumber',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextFormField(
            decoration: textInputDecoration.copyWith(
                hintText: "PhoneNumber", suffixIcon: Icon(Icons.phone)),
            initialValue: _user.user.phoneNumber,
            enabled: true,
            keyboardType: TextInputType.phone,
          ),
        ),
        Divider(
          color: Colors.grey,
        ),
      ],
    );
  }

  Widget LocationDeatils(SendIssuesViewModel model, User _user) {
    return Column(
      children: <Widget>[
        //Location details
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Text(
                'Location',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                '*Compulsory Field',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('User Location'),
              IconButton(
//                TODO: Here add a stream of location and if not enabled then ask here for permission
//                TODO: Change Icons Accordingly
                icon: Icon(Icons.my_location),
                onPressed: () {
                  print('Share Your Location');
                },
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Wrap(
            children: <Widget>[
              Text(
//                TODO: Here add the location of the user form the reverse geocoding '''' multi line
                'Loaction of User Later.',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 13,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Wrap(
            children: <Widget>[
              TextFormField(
                  decoration: textInputDecoration.copyWith(
                      suffixIcon: Icon(Icons.location_city),
                      labelText: 'Extra Information of Location'),
                  enabled: true,
                  maxLines: null,
                  keyboardType: TextInputType.text),
            ],
          ),
        ),
        Divider(
          color: Colors.grey,
        ),
      ],
    );
  }

  Widget BasicDeatils(SendIssuesViewModel model) {
    return Container(
      margin: EdgeInsets.all(5),
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        elevation: 2,
        child: Column(
          children: <Widget>[
            //Title
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
              child: Text(
                'Basic Details',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return "Title cannot be Empty";
                  }
                  if (!(value is String)) {
                    return "Enter A Valid Title";
                  }
                  return null;
                },
                onSaved: (value) {
                  return model.addTitle(value);
                },
                maxLength: 100,
                decoration: textInputDecoration.copyWith(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  labelText: 'Title',
                  suffixIcon: Icon(Icons.title),
                ),
              ),
            ),
            //SubTitle
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                maxLines: 2,
                validator: (value) {
                  if (value.isEmpty) {
                    return "SubTitle cannot be Empty";
                  }
                  if (!(value is String)) {
                    return "Enter A Valid SubTitle";
                  }
                  return null;
                },
                onSaved: (value) {
                  return model.addsubTitle(value);
                },
                maxLength: 200,
                decoration: textInputDecoration.copyWith(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  suffixIcon: Icon(Icons.subject),
                  labelText: 'Subtitle',
                ),
                keyboardType: TextInputType.text,
                enabled: true,
              ),
            ),
            //Description
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                minLines: 5,
                validator: (value) {
                  if (!(value is String)) {
                    return "Enter A Valid Description";
                  }
                  return null;
                },
                onSaved: (value) {
                  return model.addDescription(value);
                },
                decoration: textInputDecoration.copyWith(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  suffixIcon: Icon(Icons.content_paste),
//                  alignLabelWithHint: true,
                  labelText: 'Description',
                ),
                maxLines: null,
                keyboardType: TextInputType.text,
                enabled: true,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget IconDetails(SendIssuesViewModel model, BuildContext context) {
    return Column(
      children: <Widget>[
        //Add Icons
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
          child: Column(
            children: <Widget>[
              Text(
                "Add Icon ",
                textAlign: TextAlign.start,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  DropdownButton(
                    hint: Text(
                      'Choose Icon',
                      style: TextStyle(color: Colors.red),
                    ),
                    onChanged: (Icon value) {},
                    icon: Icon(Icons.arrow_drop_down),
                    items: <Icon>[
                      Icon(Icons.delete_forever),
                      Icon(Icons.my_location),
                      Icon(Icons.my_location),
                      Icon(Icons.delete_forever),
                      Icon(Icons.delete_forever),
                      Icon(Icons.delete_forever),
                      Icon(Icons.my_location),
                      Icon(Icons.delete_forever),
                      Icon(Icons.delete_forever),
                      Icon(Icons.delete_forever),
                      Icon(Icons.my_location),
                      Icon(Icons.my_location),
                      Icon(Icons.my_location),
                    ]
//                TODO: Add a custom model class then add icons and Text side by side
                        .map<DropdownMenuItem<Icon>>((val) => DropdownMenuItem(
                              child: val,
                            ))
                        .toList(),
                  ),
                  IconButton(
                    icon: Icon(Icons.more_vert),
                    onPressed: () {
                      showDialog(
                        context: context,
                        child: new AlertDialog(
                          title: new Text("Request for more."),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        Divider(
          color: Colors.grey,
        ),
      ],
    );
  }
}
