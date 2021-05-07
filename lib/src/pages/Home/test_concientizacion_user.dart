import 'package:benepet/src/widgets/home_bg.dart';
import 'package:benepet/src/widgets/menu_user_widget.dart';
import 'package:benepet/src/widgets/resposive_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TestConcientizacion extends StatefulWidget {
  @override
  _TestConcientizacionState createState() => _TestConcientizacionState();
}

class _TestConcientizacionState extends State<TestConcientizacion> {

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

  //PREGUNTAS
  String _pregunta1R = 'No';
  List<String> _sino = ['Si','No'];
  String _pregunta2R = 'No';
  String _pregunta3R = 'No';
  String _pregunta4R = 'No';
  String _pregunta5R = 'No';
  String _pregunta6R = 'No';
  String _pregunta7R = 'No';
  String _pregunta8R = 'No';

  @override
Widget build(BuildContext context) {
  _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    _large =  ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    _medium =  ResponsiveWidget.isScreenMedium(_width, _pixelRatio);
  return Scaffold(
    appBar: AppBar(
      title: Text('Test concientización'),
      elevation: 7,
      centerTitle: true,
      shape: RoundedRectangleBorder(borderRadius:  BorderRadius.only(bottomRight: Radius.circular(30),bottomLeft: Radius.circular(30)),),
      backgroundColor: terciario.withOpacity(0.8),        
    ),
    drawer: MenuUserWidget(),
    body:  Container(
            child: HomeBackground(
          child:SingleChildScrollView(
            child: Column(
              children: [
                _logo(),
                _descriptionText(),
                SizedBox(height: 10.0,),
                _textos('¿Estoy en capacidad de adquirir el compromiso para los próximos 5, 10 ó 15 años? ',Icons.timer_outlined)  ,
                _preguntaq1(),
                SizedBox(height: 10.0,),
                _textos('¿En la familia hay problemas de salud como alergias, asma o discapacidades físicas que puedan afectar al recibir a la mascota? ',Icons.family_restroom_rounded), 
                _preguntaq2(),
                SizedBox(height: 10.0,),
                _textos('¿Están todos los miembros de mi hogar de acuerdo en tener un nuevo compañero de vida? ',Icons.family_restroom), 
                _preguntaq3(),
                SizedBox(height: 10.0,),
                _textos('¿Puedo llevarlo a vivir al sitio donde habito y que este cuente con un espacio adecuado?',Icons.home_outlined), 
                _preguntaq4(),
                SizedBox(height: 10.0,),
                _textos('¿Si tengo más mascotas, aceptarían al nuevo miembro de la familia? ',Icons.pets), 
                _preguntaq5(),
                SizedBox(height: 10.0,),
                _textos('¿Puede cubrir económicamente sus necesidades como alimento, veterinario, vacunas, juguetes, medicinas y/o elementos de higiene? ',Icons.attach_money), 
                _preguntaq6(),
                SizedBox(height: 10.0,),
                _textos('¿Sabrías qué hacer con la mascota durante vacaciones y/o viajes no planeados? ',Icons.airplanemode_active), 
                _preguntaq7(),
                SizedBox(height: 10.0,),
                _textos('¿Estoy en condición de afrontar posibles problemas de salud y comportamiento de una mascota? ',Icons.medical_services_outlined), 
                _preguntaq8(),
                SizedBox(height: 5.0,),
                _boton(),
                SizedBox(height: 10.0,)
              ],
            ),
            )
          ),
      ),
  );
  }

Widget _textos(String texto,IconData icon){
  return ListTile(
            leading: Icon(
                icon,
                color: primario,
              ),
            title:Text(texto,style: TextStyle(color:primario,fontWeight:FontWeight.bold,fontSize: 18),textAlign: TextAlign.center),
            );
}

Widget _logo() {
return Container(
      alignment: Alignment.bottomCenter,
      margin: EdgeInsets.only(top: _large? _height/30 : (_medium? _height/25 : _height/20)),
      child: SvgPicture.asset(
        'assets/svg/3.svg',
        height: _height/3.3,
        width: _width/3.5,
      ),
  );
}

Widget _descriptionText() {
  return Container(
    margin:EdgeInsets.all(15),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "Este test te puede ayudar a reflexionar sobre las responsabilidades antes de adoptar",
          textAlign: TextAlign.justify,
          style: TextStyle(
            color: primario,
            fontWeight: FontWeight.bold,
            fontSize: _large? 40 : (_medium? 30 : 20),
          ),
        ),
      ],
    ),
  );
  }

//--------------------------------DROP PREGUNTA 1-------------------------------
Widget _preguntaq1(){
  return Row(
    children: [
      SizedBox(width: 70.0,),
      Icon(Icons.question_answer_rounded, color: secundario,),
      SizedBox(width: 30.0,),
      Expanded(
        child: DropdownButton(
         iconEnabledColor: terciario,
         value: _pregunta1R,
         items: getsino(),
         onChanged: (opt){
          setState(() {
            _pregunta1R=opt;
          });}, ), ),
      SizedBox(width: 90.0,),
    ],
  ); 
}
List<DropdownMenuItem<String>> getsino(){
  List<DropdownMenuItem<String>> lista=[];
  _sino.forEach((x) { 
    lista.add(DropdownMenuItem(
      child: Text(x, style: TextStyle(color:terciario,fontWeight:FontWeight.bold)),
      value: x,
    ));
  });
  return lista;
}   
//--------------------------------DROP PREGUNTA 2-------------------------------
Widget _preguntaq2(){
  return Row(
    children: [
      SizedBox(width: 70.0,),
      Icon(Icons.question_answer_rounded, color: secundario,),
      SizedBox(width: 30.0,),
      Expanded(
        child: DropdownButton(
         iconEnabledColor: terciario,
         value: _pregunta2R,
         items: getsino(),
         onChanged: (opt){
          setState(() {
            _pregunta2R=opt;
          });}, ), ),
      SizedBox(width: 90.0,),
    ],
  ); 
}
//--------------------------------DROP PREGUNTA 3-------------------------------
Widget _preguntaq3(){
  return Row(
    children: [
      SizedBox(width: 70.0,),
      Icon(Icons.question_answer_rounded, color: secundario,),
      SizedBox(width: 30.0,),
      Expanded(
        child: DropdownButton(
         iconEnabledColor: terciario,
         value: _pregunta3R,
         items: getsino(),
         onChanged: (opt){
          setState(() {
            _pregunta3R=opt;
          });}, ), ),
      SizedBox(width: 90.0,),
    ],
  ); 
}
//--------------------------------DROP PREGUNTA 4-------------------------------
Widget _preguntaq4(){
  return Row(
    children: [
      SizedBox(width: 70.0,),
      Icon(Icons.question_answer_rounded, color: secundario,),
      SizedBox(width: 30.0,),
      Expanded(
        child: DropdownButton(
         iconEnabledColor: terciario,
         value: _pregunta4R,
         items: getsino(),
         onChanged: (opt){
          setState(() {
            _pregunta4R=opt;
          });}, ), ),
      SizedBox(width: 90.0,),
    ],
  ); 
}
//--------------------------------DROP PREGUNTA 5-------------------------------
Widget _preguntaq5(){
  return Row(
    children: [
      SizedBox(width: 70.0,),
      Icon(Icons.question_answer_rounded, color: secundario,),
      SizedBox(width: 30.0,),
      Expanded(
        child: DropdownButton(
         iconEnabledColor: terciario,
         value: _pregunta5R,
         items: getsino(),
         onChanged: (opt){
          setState(() {
            _pregunta5R=opt;
          });}, ), ),
      SizedBox(width: 90.0,),
    ],
  ); 
}
//--------------------------------DROP PREGUNTA 6-------------------------------
Widget _preguntaq6(){
  return Row(
    children: [
      SizedBox(width: 70.0,),
      Icon(Icons.question_answer_rounded, color: secundario,),
      SizedBox(width: 30.0,),
      Expanded(
        child: DropdownButton(
         iconEnabledColor: terciario,
         value: _pregunta6R,
         items: getsino(),
         onChanged: (opt){
          setState(() {
            _pregunta6R=opt;
          });}, ), ),
      SizedBox(width: 90.0,),
    ],
  ); 
}
//--------------------------------DROP PREGUNTA 6-------------------------------
Widget _preguntaq7(){
  return Row(
    children: [
      SizedBox(width: 70.0,),
      Icon(Icons.question_answer_rounded, color: secundario,),
      SizedBox(width: 30.0,),
      Expanded(
        child: DropdownButton(
         iconEnabledColor: terciario,
         value: _pregunta7R,
         items: getsino(),
         onChanged: (opt){
          setState(() {
            _pregunta7R=opt;
          });}, ), ),
      SizedBox(width: 90.0,),
    ],
  ); 
}
//--------------------------------DROP PREGUNTA 6-------------------------------
Widget _preguntaq8(){
  return Row(
    children: [
      SizedBox(width: 70.0,),
      Icon(Icons.question_answer_rounded, color: secundario,),
      SizedBox(width: 30.0,),
      Expanded(
        child: DropdownButton(
         iconEnabledColor: terciario,
         value: _pregunta8R,
         items: getsino(),
         onChanged: (opt){
          setState(() {
            _pregunta8R=opt;
          });}, ), ),
      SizedBox(width: 90.0,),
    ],
  ); 
}

Widget _boton() {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(

        primary: primario,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0),),
        elevation: 4,
        textStyle: TextStyle(color: background),
        padding: EdgeInsets.all(0.0)
    ),
    onPressed: _answer,
    child: Ink(
      decoration:BoxDecoration(
      gradient: LinearGradient(colors: [terciario, primario]),
      borderRadius: BorderRadius.circular(20)) ,
    child:Container(
        constraints: BoxConstraints.tightFor(width: _width/1.8, height: _height/18),//tamaño botón
        alignment: Alignment.center,
        child: Text('Ingresar',style: TextStyle(color: background, fontSize: _large? 19: (_medium? 15: 13), fontWeight: FontWeight.bold))
      )
    ),
  );
}
_answer() {
  Widget continueButton = ElevatedButton(
    child: Text("Vale",style:TextStyle(fontWeight:FontWeight.bold) ),
    style: ElevatedButton.styleFrom(
         primary: terciario,
         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0),),
         elevation: 4,
         textStyle: TextStyle(color: background),
         padding: EdgeInsets.all(0.0)
      ),
    onPressed:  () {
    Navigator.of(context).pushReplacementNamed('home');},//afinidadespage
  );
  AlertDialog alert = AlertDialog(
    title: Text(_answerEval(),style:TextStyle(fontWeight:FontWeight.bold),textAlign: TextAlign.center,),
    //content: Text(),
    elevation: 10,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    
    actions: [
      continueButton,
    ],
  );
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

_answerEval(){
  if (_pregunta1R=="Si"&&_pregunta2R=="Si"&&_pregunta3R=="Si"&&_pregunta4R=="Si"&&_pregunta5R=="Si"&&_pregunta6R=="Si"&&_pregunta7R=="Si"&&_pregunta8R=="Si") {
    return "Eres consciente de las responsabilidades que adquieres al adoptar:) Ahora encuentra tu mascota ideal! ";
  } else {
    return "Quiza deberías pensarlo un poco más antes de adoptar :)";
  }
}
}