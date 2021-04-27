import 'dart:io';
import 'package:benepet/src/utils/userAfinidades.dart';
import 'package:benepet/src/widgets/home_bg.dart';
import 'package:benepet/src/widgets/menu_user_widget.dart';
import 'package:benepet/src/widgets/resposive_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
class AfinidadesUser extends StatefulWidget {
  @override
  _AfinidadesUserState createState() => _AfinidadesUserState();
}

class _AfinidadesUserState extends State<AfinidadesUser> {

  

  @override
  void initState(){
   // checkAuthentication();
    super.initState();
    //this.checkAuthentication();
  }
  //Medidas
  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;
  final formKey     = GlobalKey<FormState>();
  //Colores--------------------
  final Color primario=Color(0XFF364f6b);
  final Color secundario=Color(0XFF3fc1c9);
  final Color terciario=Color(0XFFfc5185);
  final Color background=Color(0XFFf5f5f5);  
  
  List<String> _sino = ['Si','No'];
  //Personalidad------------------------
  String _personalidadR = 'Alegre';
  List<String> _personalidad = ['Alegre','Tranquilo','Social','Sensible','Activo'];
  String _estiloVidaR = 'Deportista';
  List<String> _estiloVida = ['Deportista','Bohemio','Casual','Saludable','Dormilón'];
  String _aficionesR = 'Los deportes';
  List<String> _aficiones = ['Los deportes','Viajar','Estar en familia','Video juegos','La cocina'];

  //Vivienda y familia------------------------
  String _viviendaR = 'casa';
  List<String> _vivienda = ['casa','apto','finca'];
  String _patioR = 'Si';
  String _familiaR = 'Soltero';
  List<String> _familia = ['Soltero','Pareja','Familia','Roomates'];
  String _ninosR = 'Si';
  //Mascotas ------------------------
  String _mascotasactR = 'No';
  String _mascotasactEspR = 'No tengo';
  List<String> _mascotasactEsp = ['No tengo','Perro','Gato','Ambos'];
  String _mascotaantR = 'Si';
  //Mascota ideal
  String _especieR = 'Perro';
  List<String> _especie = ['Perro','Gato'];
  String _sexoR = 'Macho';
  List<String> _sexo = ['Macho','Hembra'];
  String _tamanoR = 'Mediano';
  List<String> _tamano = ['Grande','Mediano','Pequeño'];
  String _rangoEdadR = 'Cachorro';
  List<String> _rangoEdad = ['Cachorro','Adulto','Senior'];
  bool especial=false;

          User usuario=FirebaseAuth.instance.currentUser;
  

  @override
  Widget build(BuildContext context) {

    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    _large =  ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    _medium =  ResponsiveWidget.isScreenMedium(_width, _pixelRatio);
    
  return Scaffold(
    appBar: AppBar(
      title: Text('Afinidades'),
      elevation: 7,
      centerTitle: true,
      shape: RoundedRectangleBorder(borderRadius:  BorderRadius.circular(20.0)),
      backgroundColor: terciario.withOpacity(0.8),
    ),
    drawer: MenuUserWidget(),
    body: Container(
      child: HomeBackground(
        child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 2.0,),
                Card(child: _descriptionText('Llena esta encuesta para encontrar una mascota afín a tí.'),elevation: 3,
                      shape: BeveledRectangleBorder(borderRadius:  BorderRadius.circular(10.0),
                      side: BorderSide(color: terciario, width: 1.4) ),
                   ),
                //personalidad
                _logo('assets/svg/personality.svg'),
                _descriptionText('Personalidad'),
                _textos('¿Cómo te consideras en cuanto a personalidad?',Icons.person_add_rounded),
                _personalidadDrop(),
                _textos('¿Cómo dirias que es tu estilo de vida?',Icons.sports_basketball_sharp),
                _estiloVidaDrop(),
                _textos('¿Qué haces en tus tiempos libres?',Icons.sports_basketball_sharp),
                _aficionesDrop(),

                //vivienda
                _logo('assets/svg/building.svg'),
                _descriptionText('Vivienda y familia'),
                _textos('¿En donde vives?',Icons.home_work_rounded),
                _viviendaDrop(),
                _textos('¿Su vivienda tiene patio, terraza o jardín?',Icons.home_outlined),
                _patioDrop(),
                _textos('¿Con quién vive? ',Icons.person),
                _familiaDrop(),
                _textos('¿En su casa hay niños?',Icons.family_restroom_rounded),
                _ninosDrop(),
              
                //vivienda
                _logo('assets/svg/dog_walk.svg'),
                _descriptionText('Mascotas actuales y anteriores'),
                _textos('¿Cuenta con mascotas actualmente? ',Icons.pets),
                _mascotasActuales(),
                _textos('Si la respuesta anterior fue sí, ¿Con cuáles? ',Icons.pets),
                _mascotasActualesEspDrop(),
                _textos('¿Ha tenido mascotas anteriormente?  ',Icons.folder_shared_outlined),
                _mascotasAnteriores(),

                //preferencias
                _logo('assets/svg/window_cat.svg'),
                _descriptionText('Preferencias'),
                _textos('¿Qué preferirías adoptar? ',Icons.pets),
                _especieDrop(),
                _textos('¿Cuál quisieras que fuese su sexo?',Icons.pets),
                _sexoDrop(),
                _textos('¿Cuál quisieras que fuese su tamaño?',Icons.folder_shared_outlined),
                _tamanoDrop(),
                _textos('Cuál quisieras que fuese su rango de edad?',Icons.folder_shared_outlined),
                _rangoEdadDrop(),

                _conEspecial(),
                SizedBox(height: 5.0,),
                _boton()
              ],
            ),
          ),
        ),
      ),
      ),
    ),
    );
  }

Widget _textos(String texto,IconData icon){
  return ListTile(
            leading: Icon( icon,  color: secundario, size: 32,),
            title:Text(texto,style: TextStyle(color:primario,fontWeight:FontWeight.bold,fontSize: 18),textAlign: TextAlign.center),
            );
}

Widget _logo(String imagen) {
return Container(
      alignment: Alignment.bottomCenter,
      margin: EdgeInsets.only(right: 15,left: 15),//top: _large? _height/30 : (_medium? _height/25 : _height/20)),
      child: SvgPicture.asset(
        imagen,
        height: _height/3.3,
        width: _width/3.5,
      ),
  );
}

Widget _descriptionText(String descripcion) {
  return Card(
    elevation: 3,
    shape: BeveledRectangleBorder(borderRadius:  BorderRadius.circular(10.0),side: BorderSide(color: secundario, width: 1.4) ),
      child: Container(
      margin:EdgeInsets.only(right: 15,left: 15,top: 5,bottom: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            descripcion,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: primario,
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.italic,
              fontSize: _large? 40 : (_medium? 30 : 20),
            ),
          ),
        ],
      ),
    ),
  );
  }
//--------------------------------DROP PERSONALIDAD-------------------------------
Widget _personalidadDrop(){
  return Row(
    children: [ 
      SizedBox(width: 70.0,),
      Icon(Icons.chevron_right, color: primario,),
      SizedBox(width: 30.0,),
      Expanded(
        child: DropdownButton(
         iconEnabledColor: terciario,
         value: _personalidadR,
         items: getPersonalidad(),
         onChanged: (opt){
          setState(() {
            _personalidadR=opt;
          });}, ), ),
      SizedBox(width: 90.0,),
    ],
  ); 
}
List<DropdownMenuItem<String>> getPersonalidad(){
  List<DropdownMenuItem<String>> lista=[];
  _personalidad.forEach((x) { 
    lista.add(DropdownMenuItem(
      child: Text(x, style: TextStyle(color:terciario,fontWeight:FontWeight.bold)),
      value: x,
    ));
  });
  return lista;
  }
  //--------------------------------DROP ESTILOVIDA-------------------------------
Widget _estiloVidaDrop(){
  return Row(
    children: [
      SizedBox(width: 70.0,),
      Icon(Icons.chevron_right, color: primario,),
      SizedBox(width: 30.0,),
      Expanded(
        child: DropdownButton(
         iconEnabledColor: terciario,
         value: _estiloVidaR,
         items: getEstiloVida(),
         onChanged: (opt){
          setState(() {
            _estiloVidaR=opt;
          });}, ), ),
      SizedBox(width: 90.0,),
    ],
  ); 
}
List<DropdownMenuItem<String>> getEstiloVida(){
  List<DropdownMenuItem<String>> lista=[];
  _estiloVida.forEach((x) { 
    lista.add(DropdownMenuItem(
      child: Text(x, style: TextStyle(color:terciario,fontWeight:FontWeight.bold)),
      value: x,
    ));
  });
  return lista;
  }
  //--------------------------------DROP AFICIONES-------------------------------
Widget _aficionesDrop(){
  return Row(
    children: [
       SizedBox(width: 70.0,),
      Icon(Icons.chevron_right, color: primario,),
      SizedBox(width: 30.0,),
      Expanded(
        child: DropdownButton(
         iconEnabledColor: terciario,
         value: _aficionesR,
         items: getAficiones(),
         onChanged: (opt){
          setState(() {
            _aficionesR=opt;
          });}, ), ),
      SizedBox(width: 90.0,),
    ],
  ); 
}
List<DropdownMenuItem<String>> getAficiones(){
  List<DropdownMenuItem<String>> lista=[];
  _aficiones.forEach((x) { 
    lista.add(DropdownMenuItem(
      child: Text(x, style: TextStyle(color:terciario,fontWeight:FontWeight.bold)),
      value: x,
    ));
  });
  return lista;
  }
//--------------------------------DROP VIVIENDA-------------------------------
Widget _viviendaDrop(){
  return Row(
    children: [ 
      SizedBox(width: 70.0,),
      Icon(Icons.chevron_right, color: primario,),
      SizedBox(width: 30.0,),
      Expanded(
        child: DropdownButton(
         iconEnabledColor: terciario,
         value: _viviendaR,
         items: getVivienda(),
         onChanged: (opt){
          setState(() {
            _viviendaR=opt;
          });}, ), ),
      SizedBox(width: 90.0,),
    ],
  ); 
}
List<DropdownMenuItem<String>> getVivienda(){
  List<DropdownMenuItem<String>> lista=[];
  _vivienda.forEach((x) { 
    lista.add(DropdownMenuItem(
      child: Text(x, style: TextStyle(color:terciario,fontWeight:FontWeight.bold)),
      value: x,
    ));
  });
  return lista;
  }
//--------------------------------DROP PATIO-------------------------------
Widget _patioDrop(){
  return Row(
    children: [ 
      SizedBox(width: 70.0,),
      Icon(Icons.chevron_right, color: primario,),
      SizedBox(width: 30.0,),
      Expanded(
        child: DropdownButton(
         iconEnabledColor: terciario,
         value: _patioR,
         items: getSino(),
         onChanged: (opt){
          setState(() {
            _patioR=opt;
          });}, ), ),
      SizedBox(width: 90.0,),
    ],
  ); 
}
List<DropdownMenuItem<String>> getSino(){
  List<DropdownMenuItem<String>> lista=[];
  _sino.forEach((x) { 
    lista.add(DropdownMenuItem(
      child: Text(x, style: TextStyle(color:terciario,fontWeight:FontWeight.bold)),
      value: x,
    ));
  });
  return lista;
  }
//--------------------------------DROP FAMILIA-------------------------------
Widget _familiaDrop(){
  return Row(
    children: [ 
      SizedBox(width: 70.0,),
      Icon(Icons.chevron_right, color: primario,),
      SizedBox(width: 30.0,),
      Expanded(
        child: DropdownButton(
         iconEnabledColor: terciario,
         value: _familiaR,
         items: getFamilia(),
         onChanged: (opt){
          setState(() {
            _familiaR=opt;
          });}, ), ),
      SizedBox(width: 90.0,),
    ],
  ); 
}
List<DropdownMenuItem<String>> getFamilia(){
  List<DropdownMenuItem<String>> lista=[];
  _familia.forEach((x) { 
    lista.add(DropdownMenuItem(
      child: Text(x, style: TextStyle(color:terciario,fontWeight:FontWeight.bold)),
      value: x,
    ));
  });
  return lista;
  }
//--------------------------------DROP NIÑOS-------------------------------
Widget _ninosDrop(){
  return Row(
    children: [ 
      SizedBox(width: 70.0,),
      Icon(Icons.chevron_right, color: primario,),
      SizedBox(width: 30.0,),
      Expanded(
        child: DropdownButton(
         iconEnabledColor: terciario,
         value: _ninosR,
         items: getSino(),
         onChanged: (opt){
          setState(() {
            _ninosR=opt;
          });}, ), ),
      SizedBox(width: 90.0,),
    ],
  ); 
}

//--------------------------------DROP MASCOTAS ACTUALES sino-------------------------------
Widget _mascotasActuales(){
  return Row(
    children: [ 
      SizedBox(width: 70.0,),
      Icon(Icons.chevron_right, color: primario,),
      SizedBox(width: 30.0,),
      Expanded(
        child: DropdownButton(
         iconEnabledColor: terciario,
         value: _mascotasactR,
         items: getSino(),
         onChanged: (opt){
          setState(() {
            _mascotasactR=opt;
          });}, ), ),
      SizedBox(width: 90.0,),
    ],
  ); 
}
Widget _mascotasActualesEspDrop(){
  return Row(
    children: [ 
      SizedBox(width: 70.0,),
      Icon(Icons.chevron_right, color: primario,),
      SizedBox(width: 30.0,),
      Expanded(
        child: DropdownButton(
         iconEnabledColor: terciario,
         value: _mascotasactEspR,
         items: getMascotaEspe(),
         onChanged: (opt){
          setState(() {
            _mascotasactEspR=opt;
          });}, ), ),
      SizedBox(width: 90.0,),
    ],
  ); 
}
List<DropdownMenuItem<String>> getMascotaEspe(){
  List<DropdownMenuItem<String>> lista=[];
  _mascotasactEsp.forEach((x) { 
    lista.add(DropdownMenuItem(
      child: Text(x, style: TextStyle(color:terciario,fontWeight:FontWeight.bold)),
      value: x,
    ));
  });
  return lista;
  }
Widget _mascotasAnteriores(){
  return Row(
    children: [ 
      SizedBox(width: 70.0,),
      Icon(Icons.chevron_right, color: primario,),
      SizedBox(width: 30.0,),
      Expanded(
        child: DropdownButton(
         iconEnabledColor: terciario,
         value: _mascotaantR,
         items: getSino(),
         onChanged: (opt){
          setState(() {
            _mascotaantR=opt;
          });}, ), ),
      SizedBox(width: 90.0,),
    ],
  ); 
}

//--------------------------------PREFERENCIAS DEL USUARIO-------------------------------
Widget _especieDrop(){
  return Row(
    children: [ 
      SizedBox(width: 70.0,),
      Icon(Icons.chevron_right, color: primario,),
      SizedBox(width: 30.0,),
      Expanded(
        child: DropdownButton(
         iconEnabledColor: terciario,
         value: _especieR,
         items: getEspecie(),
         onChanged: (opt){
          setState(() {
            _especieR=opt;
          });}, ), ),
      SizedBox(width: 90.0,),
    ],
  ); 
}
List<DropdownMenuItem<String>> getEspecie(){
  List<DropdownMenuItem<String>> lista=[];
  _especie.forEach((x) { 
    lista.add(DropdownMenuItem(
      child: Text(x, style: TextStyle(color:terciario,fontWeight:FontWeight.bold)),
      value: x,
    ));
  });
  return lista;
  }
Widget _sexoDrop(){
  return Row(
    children: [ 
      SizedBox(width: 70.0,),
      Icon(Icons.chevron_right, color: primario,),
      SizedBox(width: 30.0,),
      Expanded(
        child: DropdownButton(
         iconEnabledColor: terciario,
         value: _sexoR,
         items: getSexo(),
         onChanged: (opt){
          setState(() {
            _sexoR=opt;
          });}, ), ),
      SizedBox(width: 90.0,),
    ],
  ); 
}
List<DropdownMenuItem<String>> getSexo(){
  List<DropdownMenuItem<String>> lista=[];
  _sexo.forEach((x) { 
    lista.add(DropdownMenuItem(
      child: Text(x, style: TextStyle(color:terciario,fontWeight:FontWeight.bold)),
      value: x,
    ));
  });
  return lista;
}
Widget _tamanoDrop(){
  return Row(
    children: [ 
      SizedBox(width: 70.0,),
      Icon(Icons.chevron_right, color: primario,),
      SizedBox(width: 30.0,),
      Expanded(
        child: DropdownButton(
         iconEnabledColor: terciario,
         value: _tamanoR,
         items: getTamano(),
         onChanged: (opt){
          setState(() {
            _tamanoR=opt;
          });}, ), ),
      SizedBox(width: 90.0,),
    ],
  ); 
}
List<DropdownMenuItem<String>> getTamano(){
  List<DropdownMenuItem<String>> lista=[];
  _tamano.forEach((x) { 
    lista.add(DropdownMenuItem(
      child: Text(x, style: TextStyle(color:terciario,fontWeight:FontWeight.bold)),
      value: x,
    ));
  });
  return lista;
}
Widget _rangoEdadDrop(){
  return Row(
    children: [ 
      SizedBox(width: 70.0,),
      Icon(Icons.chevron_right, color: primario,),
      SizedBox(width: 30.0,),
      Expanded(
        child: DropdownButton(
         iconEnabledColor: terciario,
         value: _rangoEdadR,
         items: getRangoEdad(),
         onChanged: (opt){
          setState(() {
            _rangoEdadR=opt;
          });}, ), ),
      SizedBox(width: 90.0,),
    ],
  ); 
}
List<DropdownMenuItem<String>> getRangoEdad(){
  List<DropdownMenuItem<String>> lista=[];
  _rangoEdad.forEach((x) { 
    lista.add(DropdownMenuItem(
      child: Text(x, style: TextStyle(color:terciario,fontWeight:FontWeight.bold)),
      value: x,
    ));
  });
  return lista;
  }

//--------------------------------Condición especial------------------------------
Widget _conEspecial() {
    return Card(
    elevation: 3,
    shape: BeveledRectangleBorder(borderRadius:  BorderRadius.circular(10.0),side: BorderSide(color: secundario, width: 1.4) ),
      
          child: SwitchListTile(
        value: especial,
        title: Text('¿Adoptaria a una mascota en condiciones especiales?',style: TextStyle(color:primario,fontWeight:FontWeight.bold)),
        activeColor: secundario,
        onChanged: (value)=> setState((){
          especial = value;
        }),
      ),
    );
  }
//-------------------------BOTON DEL FINAL ---------------------------------------------------------
  Widget _boton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: primario,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0),),
        elevation: 3,
        textStyle: TextStyle(color: background),
        padding: EdgeInsets.all(0.0)
    ),
    onPressed: (){
     _subir();
    },
    child: Ink(
      decoration:BoxDecoration(
      gradient: LinearGradient(colors: [terciario.withOpacity(0.6), terciario]),
      borderRadius: BorderRadius.circular(20)) ,
      child:Container(
        constraints: BoxConstraints.tightFor(width: _width/2.5, height: _height/18),//tamaño botón
        alignment: Alignment.center,
        child: Text('Enviar',style: TextStyle(fontSize: _large? 19: (_medium? 15: 13), fontWeight: FontWeight.bold, color: Colors.white))
      )
    ),
  );
  }

void _subir() async {
    if ( !formKey.currentState.validate() ) return;
    formKey.currentState.save();
    if ( _sexoR=="Macho"||_sexoR=="Hembra" ) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Enviando... espere unso segundos"),
      ));
      try{
      String usuario=FirebaseAuth.instance.currentUser.email.toString();
      await  AfinidadesHelper.saveAfinidades( usuario, _personalidadR ,_estiloVidaR 
            , _aficionesR , _viviendaR , _patioR ,_familiaR , _ninosR,
            _mascotasactR ,_mascotasactEspR , _mascotaantR, _especieR ,
            _sexoR ,_tamanoR ,_rangoEdadR , especial  ); 
     }
      catch(e){
        showError(e.message);
        print(e);
      }
      }
    Navigator.of(context).pushReplacementNamed('mascotasAfines');
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Estas son tus mascotas mas afines !"),
                ));           
    
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

}