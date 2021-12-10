import 'package:flutter/material.dart';
import 'package:kronos/constants.dart';
import 'package:camera/camera.dart';
import 'package:kronos/views/userListPage.dart';

List<CameraDescription> cameras = [];

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    fontFamily: "Roboto",
    visualDensity: VisualDensity.adaptivePlatformDensity,
    primaryColor: secondaryColor,
    accentColor: primaryColor,
    errorColor: dangerColor,
  );
}

Future<void> main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();
  } on CameraException catch (e) {
    print('Error in fetching the cameras: $e');
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kronos',
      theme: theme(),
      debugShowCheckedModeBanner: false,
      home: const usersListPage(),
    );
  }
}
