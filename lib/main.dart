import 'package:benepet/src/pages/home_page.dart';
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
      initialRoute: '/',
      routes:{
        '/'             :(BuildContext context) =>ScrollPage(),
        'ingreso'       :(BuildContext context) =>HomePage(),
       // 'detalle' :(BuildContext context) =>PeliculaDetalle(),

      }
    );
  }
}