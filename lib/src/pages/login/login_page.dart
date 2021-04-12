import 'dart:async';

import 'package:benepet/main.dart';
import 'package:benepet/src/bloc/auth_bloc.dart';
import 'package:benepet/src/pages/home/home_page.dart';
import 'package:benepet/src/widgets/login_bg.dart';
import 'package:benepet/src/widgets/resposive_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginScreen> {

  //MEDIDAS--------------------
  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;

  //COLORES--------------------
  final Color primario=Color(0XFF364f6b);
  final Color secundario=Color(0XFF3fc1c9);
  final Color terciario=Color(0XFFfc5185);
  final Color background=Color(0XFFf5f5f5);

  //FIREBASE-------------------
  final FirebaseAuth _auth=FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey= GlobalKey<FormState>() ;
  String _email="", _password="";

  StreamSubscription<User> loginStateSubscription;//cancelar el listener

  checkAuthentication() async{
    _auth.authStateChanges().listen((user) { 
    if(user!= null){
      print(user);
      Navigator.pushNamed(context, 'home');
      }
    }
   );
  }

 @override
  void initState() {
    var authBloc = Provider.of<AuthBloc>(context, listen: false);
    loginStateSubscription = authBloc.currentUser.listen((fbUser) {
      if (fbUser != null) {
       
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => MainScreen(),
          ),
        );
      }
    });
    super.initState();
  }
  
  @override
  void dispose() {
    loginStateSubscription.cancel();
    super.dispose();
  }
  
  login()async{
    if(_formKey.currentState.validate()){  
      _formKey.currentState.save();
      try{
        UserCredential user = await _auth.signInWithEmailAndPassword(email: _email.trim(), password: _password.trim());
      }
      catch(e){
        showError(e.message);
        print(e);
      }
    }
  }

  showError(String errormessage){
   showDialog(
    context: context,
    builder: (BuildContext context)
    {
      return AlertDialog(
        title: Text('ERROR'),
        content: Text(errormessage),
        actions: <Widget>[
          TextButton(
            onPressed: (){
              Navigator.of(context).pop();
            }, 
          child: Text('OK'))
        ],
      );
    }
   );
  }

  navigateToSignUp()async{
    Navigator.pushNamed(context,'/');
  }
  
//-------------------------BUILD--------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    final authBloc=Provider.of<AuthBloc>(context);

    _height = MediaQuery.of(context).size.height;
     _width = MediaQuery.of(context).size.width;
     _pixelRatio = MediaQuery.of(context).devicePixelRatio;
     _large =  ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
     _medium =  ResponsiveWidget.isScreenMedium(_width, _pixelRatio);
    return Scaffold(
       body:Container(
         child: LoginBackground(//BACKGROUND
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _logo(),
                _welcomeText(),
                _subWelcomeText(),
                _form(),
                _botonLoginElevatedButton(),
                SizedBox(height: _height*0.005),
                SignInButton(
                  Buttons.Google,text: "Ingresa con Google", elevation: 4, padding: EdgeInsets.all(0.5), onPressed: () {
                    authBloc.loginGoogle();
                },),
                _forgetPassTextRow(),
                _signUpTextRow(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _logo() {
    //double height = MediaQuery.of(context).size.height;
    return Container(
          alignment: Alignment.bottomCenter,
          margin: EdgeInsets.only(top: _large? _height/30 : (_medium? _height/25 : _height/20)),
          child: SvgPicture.asset(
            'assets/svg/sandbox.svg',
            height: _height/3.5,
            width: _width/3.5,
          ),
        );
  }

  Widget _welcomeText() {
    return Container(
      margin: EdgeInsets.only(left: _width / 20, top: _height / 100),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Bienvenido",
            style: TextStyle(
              color: primario,
              fontWeight: FontWeight.bold,
              fontSize: _large? 60 : (_medium? 50 : 40),
            ),
          ),
        ],
      ),
    );
  }

  Widget _subWelcomeText() {
    return Container(
      margin: EdgeInsets.only(left: _width / 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Ingresa a Benepet!",
            style: TextStyle(
              color: primario,
              fontWeight: FontWeight.w300,
              fontSize: _large? 20 : (_medium? 17.5 : 15),
            ),
          ),
        ],
      ),
    );
  }

  Widget _form() {
    return Container(
      margin: EdgeInsets.only(
          left: _width / 13.0,
          right: _width / 13.0,
          top: _height / 20.0),
      child: Form(
        key: _formKey,
        child: Column(
        children: <Widget>[
//FORMFIELD EMAIL----------------------------------------------------
          Material(
            borderRadius: BorderRadius.circular(30.0),
            elevation: _large? 12 : (_medium? 10 : 8),
            child: TextFormField(
              cursorColor: primario,
              keyboardType: TextInputType.emailAddress,
              obscureText: false,
              onSaved: (input) => _email = input,
              // ignore: missing_return
              validator: (input){
                if(input.isEmpty)
                return 'Ingresa tu Email';
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.email, color: primario, size: 20),
                suffixIcon: Icon(Icons.alternate_email ,color: primario, size: 15),//added
                hintText: "Email",
                labelText: "Email",//added
                labelStyle: TextStyle(color: primario ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide.none),
                ),
            ),
          ),

          SizedBox(height: _height / 50.0),
//FORMFIELD PASSWORD----------------------------------------------------
          Material(
            borderRadius: BorderRadius.circular(30.0),
            elevation: _large? 12 : (_medium? 10 : 8),
            child: TextFormField(
              cursorColor: primario,
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              onSaved: (input) => _password = input,
              // ignore: missing_return
              validator: (input){
                if(input.length < 6)
                return 'Ingresa un mínimo de 6 caracteres';
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock, color: primario, size: 20),
                suffixIcon: Icon(Icons.screen_lock_portrait ,color: primario, size: 15),//added
                hintText: "Contraseña",
                labelText: "Contraseña",//added
                labelStyle: TextStyle(color: primario ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide.none),
                ),
              
            ),
          ),

          SizedBox(height: _height / 50.0),
           
           // _crearDropdown()
          ],
        ),
      ),
    );
  }
//------------------------BOTON LOGIN ELEVATED BUTTON---------------------------------------------
  Widget _botonLoginElevatedButton() {// se tuvo que cambiar con la actualizacion de flutter al 2.0
    return ElevatedButton(
      style: ElevatedButton.styleFrom(

         primary: primario,
         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0),),
         elevation: 4,
         textStyle: TextStyle(color: background),
         padding: EdgeInsets.all(0.0)
      ),
      onPressed: login,
      child: Ink(
       decoration:BoxDecoration(
        gradient: LinearGradient(colors: [secundario.withOpacity(0.5), primario]),
        borderRadius: BorderRadius.circular(20)) ,
      child:Container(
          constraints: BoxConstraints.tightFor(width: _width/1.8, height: _height/18),//tamaño botón
          alignment: Alignment.center,
          child: Text('Ingresar',style: TextStyle(fontSize: _large? 19: (_medium? 15: 13), fontWeight: FontWeight.bold))
        )
      ),
    );
  }

  Widget _forgetPassTextRow() {
    return Container(
      margin: EdgeInsets.only(top: _height / 40.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Olvide mi contraseña",
            style: TextStyle(fontWeight: FontWeight.w400,fontSize: _large? 14: (_medium? 13: 10),color: primario),
          ),
          SizedBox(
            width: 5,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed('reset');
            },
            child: Text(
              "Recuperar",
              style: TextStyle(
                  fontWeight: FontWeight.w800, color: primario, fontSize: _large? 19: (_medium? 17: 15)),
            ),
          )
        ],
      ),
    );
  }

  Widget _signUpTextRow() {
    return Container(
      margin: EdgeInsets.only(top: _height / 120.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "¿No tienes una cuenta?",
            style: TextStyle(fontWeight: FontWeight.w400,fontSize: _large? 14: (_medium? 12: 10),color: primario),
          ),
          SizedBox(
            width: 5,
          ),
          GestureDetector(
            onTap: () {
             Navigator.pushNamed(context,'signin');
              
            },
            child: Text(
              "Registrarme",
              style: TextStyle(
                  fontWeight: FontWeight.w800, color: primario, fontSize: _large? 19: (_medium? 17: 15)),
            ),
          )
        ],
      ),
    );
  }
}
