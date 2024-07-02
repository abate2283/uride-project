import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:userapp/authentication/signup_screen.dart';

Future main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
    apiKey: 'key',
    appId: 'id',
    messagingSenderId: 'sendid',
    projectId: 'flutter-uride-with-admin',
    storageBucket: 'flutter-uride-with-admin.appspot.com',
      )
  );

  await Permission.locationWhenInUse.isDenied.then((valueOfPermission)
      {
        if(valueOfPermission)
          {
            Permission.locationWhenInUse.request();
          }
      });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'URide App',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.blue,
      ),
      home: SignupScreen(),
    );
  }
}

