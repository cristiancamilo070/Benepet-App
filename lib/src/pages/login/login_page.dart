import 'package:benepet/src/pages/login/login_bg.dart';
import 'package:benepet/src/widgets/dropdown_widget.dart';
import 'package:benepet/src/widgets/resposive_widget.dart';
import 'package:benepet/src/widgets/textfild_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


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

  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> _key = GlobalKey();

  //COLORES--------------------
  final Color primario=Color(0XFF364f6b);
  final Color secundario=Color(0XFF3fc1c9);
  final Color terciario=Color(0XFFfc5185);
  final Color background=Color(0XFFf5f5f5);

  //DROPDOWN-------------------
  List<String> _opcionesIngreso = ['Adoptante','Rescatista'];
  String _opcionSeleccionada = 'Adoptante';

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
                _logo(),
                _welcomeText(),
                _subWelcomeText(),
                _form(),
                _forgetPassTextRow(),
                SizedBox(height: _height*0.05),
                _botonLogin(),
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
          left: _width / 12.0,
          right: _width / 12.0,
          top: _height / 15.0),
      child: Form(
        key: _key,
        child: Column(
          children: <Widget>[
            emailTextFormField(),
            SizedBox(height: _height / 40.0),
            passwordTextFormField(),
            SizedBox(height: _height / 40.0),
            _crearDropdown()
          ],
        ),
      ),
    );
  }

  Widget emailTextFormField() {
    return Textfild(
      keyboardType: TextInputType.emailAddress,
      textEditingController: emailController,
      icon: Icons.email,
      iconSufix: Icons.alternate_email,
      hint: "Email",
    );

  }

  Widget passwordTextFormField() {
    return Textfild(
      keyboardType: TextInputType.visiblePassword,
      textEditingController: passwordController,
      icon: Icons.lock,
      iconSufix: Icons.screen_lock_portrait,
      obscureText: true,
      hint: "Contraseña",
    );
  }
//-------------------DROPDOWN-----------------------------------------------------------

List<DropdownMenuItem<String>> getOpciones(){
    List<DropdownMenuItem<String>> lista=new List();
    _opcionesIngreso.forEach((item) { 
      lista.add(DropdownMenuItem(
        child: Text(item),
        value: item,
      ));
    });
    return lista;
  }

  Widget _crearDropdown(){
  return DropdownFild(
    icon:Icons.arrow_drop_down_circle ,
    list: getOpciones(),
    initialValue: _opcionSeleccionada, 
    iconSufix: Icons.people_outline,   
  );
  }
//------------------------FORGER PASSWORD------------------------------------------------------------
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
              print("Routing");// RUTA OF FORGOTTEN PASSWORD 
            },
            child: Text(
              "Recuperar",
              style: TextStyle(
                  fontWeight: FontWeight.w600, color: secundario)
            ),
          )
        ],
      ),
    );
  }
//------------------------BOTON LOGIN ---------------------------------------------
  Widget _botonLogin() {
    return RaisedButton(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      onPressed: () {
          print("Routing to your account");
          Scaffold
              .of(context)
              .showSnackBar(SnackBar(content: Text('Login Successful')));

      },
      textColor: background,
      padding: EdgeInsets.all(0.0),
      child: Container(
        height:_height /20,
        alignment: Alignment.center,
        width: _large? _width/4 : (_medium? _width/3.75: _width/3.5),

        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          gradient: LinearGradient(
            colors: <Color>[terciario.withOpacity(0.5), terciario],
          ),
        ),
        
        padding: const EdgeInsets.all(12.0),
        child: Text('Ingresar',style: TextStyle(fontSize: _large? 14: (_medium? 12: 10))),
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
