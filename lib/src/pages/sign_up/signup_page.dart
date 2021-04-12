import 'dart:async';

import 'package:benepet/main.dart';
import 'package:benepet/src/bloc/auth_bloc.dart';
import 'package:benepet/src/pages/home/home_page.dart';
import 'package:benepet/src/utils/userHelper.dart';
import 'package:benepet/src/widgets/login_bg.dart';
import 'package:benepet/src/widgets/resposive_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class Signup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SignUpScreen(),
    );
  }
}

class SignUpScreen extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<SignUpScreen> {

  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;

  TextEditingController nombreController = TextEditingController();
  TextEditingController apellidoController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordVerifyController = TextEditingController();

  //COLORES--------------------
  final Color primario=Color(0XFF364f6b);
  final Color secundario=Color(0XFF3fc1c9);
  final Color terciario=Color(0XFFfc5185);
  final Color background=Color(0XFFf5f5f5);
  
  //FIREBASE
   FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  checkAuthentication() async {

    _auth.authStateChanges().
      listen((user) async{
      if(user != null){
       Navigator.pushNamed(context, 'home');
      }
    }
    );
  }
  


  @override
  void initState(){
   // checkAuthentication();
    super.initState();
    //this.checkAuthentication();
  }

  signUp()async{
    String nombreCompleto=nombreController.text+" "+apellidoController.text;
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();
    try{
      UserCredential user =await _auth.createUserWithEmailAndPassword(email: emailController.text, password: passwordController.text);
      User updateUser=FirebaseAuth.instance.currentUser;
      UserHelper.saveUser(user.user, nombreCompleto);
      //poner user como documento en USERHELPER
      if(user!= null){ 
         updateUser.updateProfile(displayName:nombreCompleto);
        Navigator.of(context).pushReplacement(// puse este await posible quitar 
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
      }
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
    builder: (BuildContext context){
      return AlertDialog(
        title: Text('ERROR'),
        content: Text(errormessage),
        actions: <Widget>[
          // ignore: deprecated_member_use
          FlatButton(
            
            onPressed: (){
              Navigator.of(context).pop();
            }, 
          child: Text('OK'))
        ],
      );
    }
   );
  }



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
                SizedBox(height: _height/15,),
                _foto(),
                _welcomeText(),
                form(),
                SizedBox(height: _height/35),
                _boton(),
                infoTextRow(),
                Container(
                  margin: EdgeInsets.only(top: _height / 120.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      CircleAvatar(
                        radius: 20,
                        child:  GestureDetector(
                          onTap: (){authBloc.loginGoogle(); },
                          child:SvgPicture.asset("assets/svg/google-plus.svg"),) ) ] ) ),
                signInTextRow(),
               ],
            ),
          ),
      ),
       ),
    );
  }

  Widget _foto() {
    return Stack(
      children: <Widget>[
       Container(
          height: _height / 5.5,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  spreadRadius: 0.0,
                  color: Colors.black26,
                  offset: Offset(1.0, 10.0),
                  blurRadius: 20.0),
            ],
            color: Colors.white,
            shape: BoxShape.circle,
          ),
  //-------------ADD PHOTO------------
          child: GestureDetector(
              onTap: (){
                print('Adding photo');
              },

              child: Icon(Icons.add_a_photo, size: _large? 40: (_medium? 33: 31),color: primario)
              ),
        ),
      ],
    );
  }

  Widget _welcomeText() {
      return Container(
        margin: EdgeInsets.only(left: _width / 20, top: _height / 100),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Regístrate",
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
  
  Widget form() {
    return Container(
      margin: EdgeInsets.only(
          left:_width/ 12.0,
          right: _width / 12.0,
          top: _height / 20.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
//FORMEDFIELD NOMBRE-------------------------------------------------
      Material(
        borderRadius: BorderRadius.circular(30.0),
        elevation: _large? 12 : (_medium? 10 : 8),
        child: TextFormField(
          controller: nombreController,
          cursorColor: primario,
          keyboardType: TextInputType.text,
          obscureText: false,
          onSaved: (input) => nombreController.text = input,
          // ignore: missing_return
          validator: (input){
            if(input.isEmpty)
            return 'Ingresa tu nombre';
          },
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.person, color: primario, size: 20),
            suffixIcon: Icon(Icons.person_pin ,color: primario, size: 15),//added
            hintText: "Nombre",
            labelText: "Nombre",//added
            labelStyle: TextStyle(color: primario ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide.none),
            ),
          ),
        ),           
        SizedBox(height: _height / 60.0),
//FORMEDFIELD APELLIDO-------------------------------------------------
        Material(
          borderRadius: BorderRadius.circular(30.0),
          elevation: _large? 12 : (_medium? 10 : 8),
          child: TextFormField(
            controller: apellidoController,
            cursorColor: primario,
            keyboardType: TextInputType.text,
            obscureText: false,
            onSaved: (input) => apellidoController.text = input,
            // ignore: missing_return
            validator: (input){
              if(input.isEmpty)
              return 'Ingresa tu apellido';
            },
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.person, color: primario, size: 20),
              suffixIcon: Icon(Icons.person_pin ,color: primario, size: 15),//added
              hintText: "Apellido",
              labelText: "Apellido",//added
              labelStyle: TextStyle(color: primario ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none),
              ),
            ),
          ),
            SizedBox(height: _height/ 60.0),
//FORMFIELD EMAIL----------------------------------------------------
          Material(
            borderRadius: BorderRadius.circular(30.0),
            elevation: _large? 12 : (_medium? 10 : 8),
            child: TextFormField(
              controller: emailController,
              cursorColor: primario,
              keyboardType: TextInputType.emailAddress,
              obscureText: false,
              onSaved: (input) => emailController.text = input,
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
            SizedBox(height: _height / 60.0),
//FORMFIELD PASSWORD----------------------------------------------------
          Material(
            borderRadius: BorderRadius.circular(30.0),
            elevation: _large? 12 : (_medium? 10 : 8),
            child: TextFormField(
              controller: passwordController,
              cursorColor: primario,
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              onSaved: (input) => passwordController.text = input,
              // ignore: missing_return
              validator: (input){
                if (input.isEmpty) {
                  return 'Ingresa una contraseña';
                }else if(input.length < 6)
                {return 'Ingresa un mínimo de 6 caracteres';}
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
            SizedBox(height: _height / 60.0),
//FORMFIELD PASSWORD CONFIRMATION----------------------------------------------------
          Material(
            borderRadius: BorderRadius.circular(30.0),
            elevation: _large? 12 : (_medium? 10 : 8),
            child: TextFormField(
              cursorColor: primario,
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              onSaved: (input) => passwordVerifyController.text = input,
              // ignore: missing_return
              validator: (input){
                if (input.isEmpty) {
                  return 'Ingresa una contraseña';
                }else if(input.length < 6)
                {return 'Ingresa un mínimo de 6 caracteres';
                }else if(input!=passwordController.text){
                  return 'Las contraseñas no coinciden, intentalo de nuevo';
                }
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock, color: primario, size: 20),
                suffixIcon: Icon(Icons.screen_lock_portrait ,color: primario, size: 15),//added
                hintText: "Confirma contraseña",
                labelText: "Confirma contraseña",//added
                labelStyle: TextStyle(color: primario ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide.none),
                ),
              
            ),
          ),
          ],
        ),
      ),
    );
  }
  
  Widget _boton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: primario,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0),),
        elevation: 3,
        textStyle: TextStyle(color: background),
        padding: EdgeInsets.all(0.0)
    ),
    onPressed: ()=>signUp(),
    child: Ink(
      decoration:BoxDecoration(
      gradient: LinearGradient(colors: [secundario.withOpacity(0.5), primario]),
      borderRadius: BorderRadius.circular(20)) ,
      child:Container(
        constraints: BoxConstraints.tightFor(width: _width/2.5, height: _height/18),//tamaño botón
        alignment: Alignment.center,
        child: Text('Registrarse',style: TextStyle(fontSize: _large? 19: (_medium? 15: 13), fontWeight: FontWeight.bold))
      )
    ),
  );
  }

  Widget infoTextRow() {
    return Container(
      margin: EdgeInsets.only(top: _height / 70.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "O puedes crear tu cuenta con : ",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: _large? 12: (_medium? 13: 10),color: primario),
          ),
        ],
      ),
    );
  }

  Widget signInTextRow() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "¿Ya tienes una cuenta?",
            style: TextStyle(fontWeight: FontWeight.w400,color: primario),
          ),
          SizedBox(
            width: 5,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, 'login');
              print("Routing to Sign up screen");
            },
            child: Text(
              "Ingresar",
              style: TextStyle(
                  fontWeight: FontWeight.w800, color: primario, fontSize: _large? 19: (_medium? 17: 15)),
            ),
          )
        ],
      ),
    );
  }
}