import 'package:benepet/src/pages/login/login_bg.dart';
import 'package:benepet/src/widgets/correo_widget.dart';
import 'package:benepet/src/widgets/dropdown_widget.dart';
import 'package:benepet/src/widgets/pwrd_widget.dart';
import 'package:benepet/src/widgets/resposive_widget.dart';
import 'package:benepet/src/widgets/textfild_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


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
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  //COLORES--------------------
  final Color primario=Color(0XFF364f6b);
  final Color secundario=Color(0XFF3fc1c9);
  final Color terciario=Color(0XFFfc5185);
  final Color background=Color(0XFFf5f5f5);

  //DROPDOWN-------------------
  List<String> _opcionesIngreso = ['Adoptante','Rescatista'];
  String _opcionSeleccionada = 'Adoptante';

  //FIREBASE
   FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _nombre="", _apellido="", _email="", _password="";

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
    super.initState();
    this.checkAuthentication();
  }

  signUp()async{
   if(_formKey.currentState.validate()){
     _formKey.currentState.save();
     try{
       UserCredential user =await _auth.createUserWithEmailAndPassword(email: _email, password: _password);
       if(user!= null){
         await _auth.currentUser.updateProfile(displayName: _nombre);
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
    builder: (BuildContext context)
    {
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

    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    _large =  ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    _medium =  ResponsiveWidget.isScreenMedium(_width, _pixelRatio);

      return Scaffold(
       body:Container(
         child: LoginBackground(
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
                socialIconsRow(),
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
              cursorColor: primario,
              keyboardType: TextInputType.text,
              obscureText: false,
              onSaved: (input) => _email = input,
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
              cursorColor: primario,
              keyboardType: TextInputType.text,
              obscureText: false,
              onSaved: (input) => _apellido = input,
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
            //SizedBox(height: _height / 60.0),
            //_crearDropdownR(),
            //SizedBox(height: _height / 60.0),
            //_telefono(),
            SizedBox(height: _height / 60.0),
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
            SizedBox(height: _height / 60.0),
//FORMFIELD PASSWORD CONFIRMATION----------------------------------------------------
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
//-------------------NOMBRES OLD WAY-------------------------------------------------
  // Widget _nombre() {
  //   return Textfild(
  //     keyboardType: TextInputType.text,
  //     icon: Icons.person,
  //     hint: "Nombre",
  //     iconSufix: Icons.person_pin,
  //     fild: _name,
  //   );
  // }
  // Widget _apellido() {
  //   return Textfild(
  //     keyboardType: TextInputType.text,
  //     icon: Icons.person,
  //     hint: "Apellido",
  //     iconSufix: Icons.person_pin,
  //   );
  // }
//-------------------EMAIL-----------------------------------------------------------

  Widget _entermail() {
    return Correofild(
      keyboardType: TextInputType.emailAddress,
      icon: Icons.email,
      iconSufix: Icons.alternate_email,
      hint: "Email",
      correo: _email,
    );
  }

//-------------------DROPDOWN-----------------------------------------------------------

List<DropdownMenuItem<String>> getOpcionesR(){
    List<DropdownMenuItem<String>> lista=[];
    _opcionesIngreso.forEach((item) { 
      lista.add(DropdownMenuItem(
        child: Text(item),
        value: item,
      ));
    });
    return lista;
  }

  Widget _crearDropdownR(){
  return DropdownFild(
    icon:Icons.arrow_drop_down_circle ,
    list: getOpcionesR(),
    initialValue: _opcionSeleccionada, 
    iconSufix: Icons.people_outline,   
  );
//-------------------CELULAR -----------------------------------------------------------
  }
  Widget _telefono() {
    return Textfild(
      keyboardType: TextInputType.number,
      icon: Icons.phone,
      hint: "Mobile Number",
      iconSufix: Icons.textsms,
    );
  }
//-------------------CONTRASEÑAS-----------------------------------------------------------
  Widget _clave() {
    return Textfild(
      keyboardType: TextInputType.text,
      obscureText: true,
      icon: Icons.lock,
      iconSufix: Icons.screen_lock_portrait,
      hint: "Contraseña",
    );
  }
  Widget _claveConfirmacion() {
    return Pwrdfild(
      keyboardType: TextInputType.text,
      obscureText: true,
      icon: Icons.lock,
      iconSufix: Icons.screen_lock_portrait,
      hint: "Confirma contraseña",
      clave: _password,
    );
  }

  // Widget acceptTermsTextRow() {
  //   return Container(
  //     margin: EdgeInsets.only(top: _height / 100.0),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: <Widget>[
  //         Checkbox(
  //             activeColor: Colors.orange[200],
  //             value: checkBoxValue,
  //             onChanged: (bool newValue) {
  //               setState(() {
  //                 checkBoxValue = newValue;
  //               });
  //             }),
  //         Text(
  //           "I accept all terms and conditions",
  //           style: TextStyle(fontWeight: FontWeight.w400, fontSize: _large? 12: (_medium? 11: 10)),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _boton() {
    // ignore: deprecated_member_use
    return RaisedButton(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      onPressed: signUp,
      textColor: Colors.white,
      padding: EdgeInsets.all(0.0),
      child: Container(
        alignment: Alignment.center,
        height: _height / 20,
        width:_large? _width/4 : (_medium? _width/3.75: _width/3.5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          gradient: LinearGradient(
            colors: <Color>[terciario.withOpacity(0.5), terciario],
          ),
        ),
        padding: const EdgeInsets.all(12.0),
        child: Text('Registrar', style: TextStyle(fontSize: _large? 14: (_medium? 12: 10)),),
      ),
    );
  }

  Widget infoTextRow() {
    return Container(
      margin: EdgeInsets.only(top: _height / 40.0),
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

  Widget socialIconsRow() {
    return Container(
      margin: EdgeInsets.only(top: _height / 80.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          CircleAvatar(
            radius: 20,
            child:  GestureDetector(
              onTap: (){
                print('Google');
              },
              child:SvgPicture.asset("assets/svg/google-plus.svg"),)
            
          ),
          SizedBox(
            width: 20,
          ),
          CircleAvatar(
            radius: 20,
            child: GestureDetector(
              onTap: (){
                print('Facebook');
              },
              child:SvgPicture.asset("assets/svg/facebook.svg"),)
              ),
        ],
      ),
    );
  }

  Widget signInTextRow() {
    return Container(
      margin: EdgeInsets.only(top: _height / 45.0),
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