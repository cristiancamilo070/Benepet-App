import 'package:benepet/src/pages/login/login_page.dart';
import 'package:flutter/material.dart';

import 'package:benepet/src/pages/Home/home_page.dart';
import 'package:benepet/src/pages/sign_up/signup_page.dart';
import 'package:benepet/src/pages/splash/splash_page.dart';
import 'package:benepet/src/pages/welcome/welcome_page.dart';

import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
   }
 
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Benepet',
      initialRoute: 'splash',
      routes:{
        'splash'        :(BuildContext context) =>SplashScreen(),
        '/'             :(BuildContext context) =>ScrollPage(),
        'login'         :(BuildContext context) =>LoginScreen(),
        'signin'        :(BuildContext context) =>SignUpScreen(),
        'home'         :(BuildContext context) =>HomePage(),                                       
      }
    );
  }
}