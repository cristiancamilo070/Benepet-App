import 'package:benepet/src/pages/home_page.dart';
import 'package:benepet/src/pages/login/login_page.dart';
import 'package:benepet/src/pages/splash/splash_page.dart';
//import 'package:benepet/src/pages/welcome_page.dart';
import 'package:benepet/src/pages/welcome/welcome_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());
 
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
        'ingreso'       :(BuildContext context) =>HomePage(),
        'login'         :(BuildContext context) =>LoginScreen(),
       // 'detalle' :(BuildContext context) =>PeliculaDetalle(),

      }
    );
  }
}