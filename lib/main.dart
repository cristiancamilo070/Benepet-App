import 'package:benepet/src/pages/home/afinidades_user.dart';
import 'package:benepet/src/pages/home/config_user.dart';
import 'package:benepet/src/pages/home/info_user_page.dart';
import 'package:benepet/src/pages/home/procesar_afinidades.dart';
import 'package:benepet/src/pages/home/test_concientizacion_user.dart';
import 'package:benepet/src/pages/home_admin/info_admin.dart';
import 'package:benepet/src/pages/home_admin/mascotas_admin.dart';
import 'package:benepet/src/pages/home_admin/perfiles_admin.dart';
import 'package:flutter/material.dart';
import 'package:benepet/src/bloc/auth_bloc.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


import 'package:benepet/src/pages/sign_up/signup_page.dart';
import 'package:benepet/src/pages/splash/splash_page.dart';
import 'package:benepet/src/pages/welcome/welcome_page.dart';
import 'package:benepet/src/pages/home/home_page.dart';
import 'package:benepet/src/pages/home_admin/home_admin_page.dart';
import 'package:benepet/src/pages/login/login_page.dart';
import 'package:benepet/src/pages/reset_password/reset_pass_page.dart';


import 'package:firebase_core/firebase_core.dart';

import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
   }
 
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Provider(
      create: (context)=>AuthBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Benepet',
        theme: ThemeData(primaryColor: Color(0XFFfc5185)),
        initialRoute: 'splash',
        routes:{
          'splash'        :(BuildContext context) =>SplashScreen(),
          '/'             :(BuildContext context) =>ScrollPage(),
          'login'         :(BuildContext context) =>LoginScreen(),
          'signin'        :(BuildContext context) =>SignUpScreen(),
          'home'          :(BuildContext context) =>MainScreen(), 
          'reset'         :(BuildContext context) =>ResetPasswordScreen(),

          'mascotasAdmin' :(BuildContext context) =>MascotasAdmin(),  
          'perfilesAdmin' :(BuildContext context) =>PerfilesAdmin(), 
          'conocenos' :(BuildContext context) =>InformacionAdmin(),     

          'test'          :(BuildContext context) => TestConcientizacion(),  
          'afinidades'    :(BuildContext context) => AfinidadesUser(), 
          'conocenosUser'    :(BuildContext context) => InformacionUser(),  
          'mascotasAfines'    :(BuildContext context) => ProcesarAfinidadesUser(), 
          'configUser'    :(BuildContext context) =>ConfigUser(),           
        }
      ),
      
    );
  }
}

class MainScreen extends StatelessWidget
{
    @override
  Widget build(BuildContext context) {

    return StreamBuilder(//<user>>
      stream: FirebaseAuth.instance.authStateChanges(),
      builder:(BuildContext context,AsyncSnapshot snapshot){
        if (snapshot.hasData&&snapshot.data!=null) {
          return StreamBuilder(
            stream: FirebaseFirestore.instance.collection("Users").doc(snapshot.data.email).snapshots() ,
            builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
              if (snapshot.hasData&&snapshot.data!=null) {
                final user=snapshot.data.data();
                if(user['role']=='admin'){
                  return HomeAdminPage();
                }else{
                   return HomePage();
                }
              }
              return Material(child: Center(child: CircularProgressIndicator(),),);
            },
          );
        }
        return HomePage();
      }
    );
  }

}