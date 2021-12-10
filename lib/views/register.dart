import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kronos/constants.dart';
import 'package:kronos/main.dart';
import 'package:kronos/models/user.dart';
import 'package:kronos/repository/db.dart';
import 'package:kronos/views/camera.dart';
import 'package:kronos/views/userListPage.dart';
import 'package:location/location.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  int segmentedControlValue = 0;

  TextEditingController _nameField = TextEditingController();
  TextEditingController _lastnameField = TextEditingController();
  TextEditingController _phoneField = TextEditingController();
  TextEditingController _emailField = TextEditingController();

  bool emailValidator(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return false;
    } else {
      return true;
    }
  }

  late DatabaseHandler handler;

  // late Future<List<User>> futureData;

  Location location = Location();

  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  late LocationData _locationData;

  Future<void> getLocation() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
  }

  @override
  void initState() {
    super.initState();

    ///futureData = fetchUsers();
    handler = DatabaseHandler();
    getLocation();
  }

  @override
  @override
  void dispose() {
    _nameField.dispose();
    _lastnameField.dispose();
    _phoneField.dispose();
    _emailField.dispose();
    imagePath.dispose();
    super.dispose();
  }

  Future<int> addUser() async {
    User user = User(
        name: _nameField.text,
        phone: int.parse(_phoneField.text),
        lastname: _lastnameField.text,
        email: _emailField.text,
        lat: _locationData.latitude!,
        lon: _locationData.longitude!,
        image: imagePath);
    return await handler.insertUser([user]);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          padding: EdgeInsetsDirectional.all(4.0),
          middle: Text("Regístro"),
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const usersListPage(),
                ),
              );
            },
            icon: Icon(Icons.close),
          ),
        ),
        child: SafeArea(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: SingleChildScrollView(
              child: Column(children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 80.0, vertical: 32.0),
                  child: Text(
                    "Bienvenido, ingrese sus datos",
                    style: kronosH3Blue,
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: 26.0),
                  child: Text(
                    "Fotografía",
                    style: kronosH1Black,
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                CupertinoButton(
                  child: Container(
                    // height: 48.0,
                    width: double.infinity,
                    height: 142.0,
                    decoration: BoxDecoration(
                      color: bgLightColor,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding:
                        EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.photo_camera, size: 48, color: Colors.white),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("Tomar fotografía", style: kronosH2White),
                        )
                      ],
                    ),
                  ),
                  onPressed: () {
                    // print("FOTO");
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            TakePictureScreen(camera: cameras.first),
                      ),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: imagePath != null
                      ? Image.file(File(imagePath), fit: BoxFit.cover)
                      : Container(),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: 26.0),
                  child: Text(
                    "Nombre",
                    style: kronosH1Black,
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: CupertinoTextField(
                    controller: _nameField,
                    padding: EdgeInsets.all(12.0),
                    onChanged: (value) => print(value),
                    keyboardType: TextInputType.text,
                    cursorColor: secondaryColor,
                    maxLength: 13,
                    maxLines: 1,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: greyLightColor),
                    ),
                  ),
                ),
                SizedBox(
                  height: 18.0,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: 26.0),
                  child: Text(
                    "Apellidos",
                    style: kronosH1Black,
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: CupertinoTextField(
                    controller: _lastnameField,
                    padding: EdgeInsets.all(12.0),
                    onChanged: (value) => print(value),
                    keyboardType: TextInputType.text,
                    cursorColor: secondaryColor,
                    maxLength: 28,
                    maxLines: 1,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: greyLightColor),
                    ),
                  ),
                ),
                SizedBox(
                  height: 18.0,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: 26.0),
                  child: Text(
                    "Teléfono",
                    style: kronosH1Black,
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: CupertinoTextField(
                    controller: _phoneField,
                    padding: EdgeInsets.all(12.0),
                    onChanged: (value) => print(value),
                    keyboardType: TextInputType.number,
                    cursorColor: secondaryColor,
                    maxLength: 10,
                    maxLines: 1,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: greyLightColor),
                    ),
                  ),
                ),
                SizedBox(
                  height: 18.0,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: 26.0),
                  child: Text(
                    "Correo electrónico",
                    style: kronosH1Black,
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: CupertinoTextField(
                    controller: _emailField,
                    padding: EdgeInsets.all(12.0),
                    onChanged: (value) => print(value),
                    keyboardType: TextInputType.emailAddress,
                    cursorColor: primaryColor,
                    maxLength: 48,
                    maxLines: 1,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: greyLightColor),
                    ),
                  ),
                ),
                SizedBox(
                  height: 18.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 12.0),
                  child: Container(
                    width: double.infinity,
                    child: CupertinoButton(
                      color: secondaryColor,
                      // padding: EdgeInsets.symmetric(horizontal: size.width * 0.25),
                      child: Text("Guardar datos"),
                      onPressed: () {
                        if (imagePath == null) {
                          Fluttertoast.showToast(
                              msg: "Debes tomar una fotografía",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: greyLightColor,
                              textColor: textColor,
                              fontSize: 16.0);
                        } else {
                          if (_nameField.text.isEmpty ||
                              _lastnameField.text.isEmpty ||
                              _phoneField.text.isEmpty ||
                              _emailField.text.isEmpty) {
                            Fluttertoast.showToast(
                                msg: "Llena todos los campos",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: greyLightColor,
                                textColor: textColor,
                                fontSize: 16.0);
                          } else {
                            if (!emailValidator(_emailField.text)) {
                              Fluttertoast.showToast(
                                  msg: "Ingresa un email válido",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: greyLightColor,
                                  textColor: textColor,
                                  fontSize: 16.0);
                            } else {
                              handler.initializeDB().whenComplete(() async {
                                await addUser();
                                setState(() {});
                              });
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const usersListPage(),
                                ),
                              );
                            }
                          }
                        }
                      },
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
