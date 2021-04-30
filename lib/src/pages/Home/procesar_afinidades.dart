import 'package:benepet/src/utils/userAfinidades.dart';
import 'package:benepet/src/widgets/resposive_widget.dart';
import 'package:flutter/rendering.dart';
import 'package:benepet/src/widgets/home_bg.dart';
import 'package:benepet/src/widgets/menu_user_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:deep_collection/deep_collection.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'lista_mascotas_afines.dart';
class ProcesarAfinidadesUser extends StatefulWidget {
  @override
  _ProcesarAfinidadesUserState createState() => _ProcesarAfinidadesUserState();
}

class _ProcesarAfinidadesUserState extends State<ProcesarAfinidadesUser> {
  
  @override
  void initState() {
    super.initState();
  }
  final List<String> finalList=<String>[];
  
  //COLORES--------------------
  final Color primario=Color(0XFF364f6b);
  final Color secundario=Color(0XFF3fc1c9);
  final Color terciario=Color(0XFFfc5185);
  final Color background=Color(0XFFf5f5f5);
  //Medidas
  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String usuario=FirebaseAuth.instance.currentUser.email.toString(); 
  

@override
Widget build(BuildContext context) {
  _height = MediaQuery.of(context).size.height;
  _width = MediaQuery.of(context).size.width;
  _pixelRatio = MediaQuery.of(context).devicePixelRatio;
  _large =  ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
  _medium =  ResponsiveWidget.isScreenMedium(_width, _pixelRatio);
//print(finalList);
//_evalAfinidades();
return Scaffold(
  appBar: AppBar(
      title: Text('Afinidades'),
      elevation: 7,
      centerTitle: true,
      shape: RoundedRectangleBorder(borderRadius:  BorderRadius.only(bottomRight: Radius.circular(30),bottomLeft: Radius.circular(30)),),
      backgroundColor: terciario.withOpacity(0.8),
    ),
  drawer: MenuUserWidget(),
       body:  Container(
          child: HomeBackground(
            child: SingleChildScrollView(
             child: Container(
               child: SingleChildScrollView(child: 
                Column(
                  children: [
                    SizedBox(height: 30,),
                    _logo('assets/svg/1.svg'),
                    _descriptionText("A continuación podrás conocer tus mascotas afines"),
                    SizedBox(height: 30,),

                    _descriptionText2("Este proceso puede tarder unos seguntos, espere un poco."),
                    SizedBox(height: 30,),

                   _boton(),
                  ],
                ),
              ), 
            ),
          )
        )
      )
     
  );
  
}
Widget _logo(String imagen) {
return Container(
      alignment: Alignment.bottomCenter,
      margin: EdgeInsets.only(right: 15,left: 15),
      child: SvgPicture.asset(
        imagen,
        height: _height/3.3,
        width: _width/3.5,
      ),
  );
}
Widget _descriptionText(String descripcion) {
  return Container(
      margin:EdgeInsets.only(right: 15,left: 15,top: 5,bottom: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            descripcion,
            textAlign: TextAlign.center,
            style: GoogleFonts.frederickaTheGreat(
              fontWeight: FontWeight.bold,
              fontSize: 38,
              color: primario
            ),
          ),
        ],
      ),
  );
  }
  Widget _descriptionText2(String descripcion) {
  return Container(
      margin:EdgeInsets.only(right: 15,left: 15,top: 5,bottom: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            descripcion,
            textAlign: TextAlign.center,
            style: GoogleFonts.spinnaker(
              fontSize: 17,
              color: primario
            ),
          ),
        ],
      ),
  );
  }
  Widget _boton() {
    return Center(
      child: ElevatedButton(
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
          child: Text('Continuar',style: TextStyle(fontSize: _large? 19: (_medium? 15: 13), fontWeight: FontWeight.bold, color: Colors.white))
        )
      ),
    ),
  );
}

void _subir() async {
      var finalLis=await _evalAfinidades();
      try{
      String usuario=FirebaseAuth.instance.currentUser.email.toString();
      await  AfinidadesHelper.addAfinidades(usuario,finalLis);
      //print(finalLis);
     }
      catch(e){
        showError(e.message);
        print(e);
      }
      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                      return ListaMascotasAfines(finalLis);
                    }) );
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Estas son tus mascotas mas afines!"),
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

_evalAfinidades()async{
  //Map<String,dynamic> afines;
  final db = FirebaseFirestore.instance;
  final List<DocumentSnapshot> documents=<DocumentSnapshot>[];
  final List<String> documentsStrings=<String>[];

  String _personalidadR; String _estiloVidaR;      String _aficionesR;        String _especiecompaPerros; String _especiecompaGatos;
  String _viviendaR;     String _patioR;           String _familiaR;        String _ninos; bool _ninosR;
  String _mascotasactR ; String _mascotasactEsp;   bool _mascotasactEspR;  String _mascotaantR; 
  String _especieR ;     String _sexoR;            String _tamanoR;         String _rangoEdad;String _rangoEdadR; bool especial;

  await db.collection('Afinidades').doc(usuario).get()
  .then((DocumentSnapshot documentSnapshot) {     
    _personalidadR   =documentSnapshot.data()['personalidad'].toString();
    _estiloVidaR     =documentSnapshot.data()['estilo'].toString();
    _aficionesR      =documentSnapshot.data()['aficiones'].toString();

    _viviendaR       =documentSnapshot.data()['vivienda'].toString();
    _patioR          =documentSnapshot.data()['patio'].toString();
    _familiaR        =documentSnapshot.data()['familia'].toString();
    _ninos           =documentSnapshot.data()['ninos'].toString();
    if (_ninos=="Si") {_ninosR=true;}else _ninosR=false;//ninosR es la final

    _mascotasactR    =documentSnapshot.data()['mascAct'].toString();
    _mascotasactEsp  =documentSnapshot.data()['mascActEsp'].toString();
    _mascotaantR     =documentSnapshot.data()['mascAnt'].toString();

    _especieR        =documentSnapshot.data()['especieMas'].toString();
    _sexoR           =documentSnapshot.data()['sexoMas'].toString();
    _tamanoR         =documentSnapshot.data()['tamanoMas'].toString();
    _rangoEdad       =documentSnapshot.data()['edadMas'].toString();
    if (_rangoEdad=="Cachorro") {
      _rangoEdadR="Meses";
    }else if(_rangoEdad=="Aduto"){
      _rangoEdadR="Años";
    }else{ _rangoEdadR="Años";}
    especial         =documentSnapshot.data()['Especial'];
  });
  //personalidad
  var activo=await db.collection('Mascotas').where("activo",whereIn:[true] ).get();
  var juegueton=await db.collection('Mascotas').where("jugueton",whereIn:[true] ).get();
  var amoroso=await db.collection('Mascotas').where("amoroso",whereIn:[true] ).get();
  var dormilon=await db.collection('Mascotas').where("dormilon",whereIn:[true] ).get();
  var tranquilo=await db.collection('Mascotas').where("tranquilo",whereIn:[true] ).get();
  var timido=await db.collection('Mascotas').where("timido",whereIn:[true] ).get();
  var educado=await db.collection('Mascotas').where("educado",whereIn:[true] ).get();
  if (_personalidadR=="Alegre") {//ESTA BIEN
      documents.addAll(juegueton.docs) ;
      documents.addAll(amoroso.docs) ;
      documents.addAll(activo.docs) ;
  }else if (_personalidadR=="Tranquilo") {//ESTA BIEN
      documents.addAll(dormilon.docs) ;
      documents.addAll(tranquilo.docs) ;
      documents.addAll(timido.docs) ;
  }else if (_personalidadR=="Social") {//ESTA BIEN
      documents.addAll(activo.docs) ;
      documents.addAll(educado.docs) ;
      documents.addAll(amoroso.docs) ;
  }else if (_personalidadR=="Sensible") {//ESTA BIEN
      documents.addAll(amoroso.docs) ;
      documents.addAll(tranquilo.docs) ;
      documents.addAll(timido.docs) ;
  }else if (_personalidadR=="Activo") {//ESTA BIEN
      documents.addAll(activo.docs) ;
      documents.addAll(juegueton.docs) ;
      documents.addAll(amoroso.docs) ;
  }
  //Estilo de vida 
  if (_estiloVidaR=="Deportista") {//ESTA BIEN
      documents.addAll(juegueton.docs) ;
      documents.addAll(amoroso.docs) ;
      documents.addAll(activo.docs) ;
  }else if (_estiloVidaR=="Bohemio") {//ESTA BIEN
      documents.addAll(dormilon.docs) ;
      documents.addAll(tranquilo.docs) ;
      documents.addAll(timido.docs) ;
  }else if (_estiloVidaR=="Casual") {//ESTA BIEN
      documents.addAll(juegueton.docs) ;
      documents.addAll(educado.docs) ;
      documents.addAll(amoroso.docs) ;
  }else if (_estiloVidaR=="Saludable") {//ESTA BIEN
      documents.addAll(amoroso.docs) ;
      documents.addAll(juegueton.docs) ;
  }else if (_estiloVidaR=="Dormilón") {//ESTA BIEN
      documents.addAll(educado.docs) ;
      documents.addAll(amoroso.docs) ;
      documents.addAll(dormilon.docs) ;
  }
  //Aficiones  
  if (_aficionesR=="Los deportes") {//ESTA BIEN
      documents.addAll(juegueton.docs) ;
      documents.addAll(amoroso.docs) ;
      documents.addAll(activo.docs) ;
  }else if (_aficionesR=="Viajar") {//ESTA BIEN
      documents.addAll(activo.docs) ;
      documents.addAll(educado.docs) ;
      documents.addAll(juegueton.docs) ;
  }else if (_aficionesR=="Estar en familia") {//ESTA BIEN
      documents.addAll(juegueton.docs) ;
      documents.addAll(amoroso.docs) ;
      documents.addAll(tranquilo.docs) ;
  }else if (_aficionesR=="Video juegos") {//ESTA BIEN
      documents.addAll(tranquilo.docs) ;
      documents.addAll(dormilon.docs) ;
      documents.addAll(timido.docs) ;
  }else if (_aficionesR=="La cocina") {//ESTA BIEN
      documents.addAll(dormilon.docs) ;
      documents.addAll(amoroso.docs) ;
      documents.addAll(educado.docs) ;
  }

//Vivienda y familia 
    var viviendaComp=await db.collection('Mascotas').where(_viviendaR,whereIn:[true] ).get();//ESTA BIEN 
     documents.addAll(viviendaComp.docs) ;
  if (_patioR=="Si") {
    var patioMedianoComp=await db.collection('Mascotas').where("tamano",whereIn:['Grande'] ).get();//ESTA BIEN 
      documents.addAll(patioMedianoComp.docs) ;  
    var patioGrandeComp=await db.collection('Mascotas').where("tamano",whereIn:['Mediano'] ).get();//ESTA BIEN 
      documents.addAll(patioGrandeComp.docs) ;  }
  // if(_familiaR=="Soltero"){
  //   var familiaComp=await db.collection('Mascotas').where("sexo",whereIn:[_familiaR] ).get();//POR AHORA NO 
  //     documents.addAll(familiaComp.docs) ;
  // }
  var ninosComp=await db.collection('Mascotas').where("ninos",whereIn:[_ninosR] ).get();//ESTA BIEN
     documents.addAll(ninosComp.docs) ;

// //Mascotas actuales y anteriores  
  if(_mascotasactR=="Si"){ //ESTA BIEN
  if(_mascotasactEsp=="Perro") {
    _especiecompaPerros="conperros";
    _mascotasactEspR=true;
    var mascotasactCompPerro=await db.collection('Mascotas').where(_especiecompaPerros,whereIn:[_mascotasactEspR] ).get();//ESTA BIEN
      documents.addAll(mascotasactCompPerro.docs) ;
  } else if (_mascotasactEsp=="Gato") {
    _especiecompaGatos="congatos";
    _mascotasactEspR=true;
    var mascotasactCompGato=await db.collection('Mascotas').where(_especiecompaGatos,whereIn:[_mascotasactEspR] ).get();//ESTA BIEN
      documents.addAll(mascotasactCompGato.docs) ;
  } else if(_mascotasactEsp=="Ambos") {
    _especiecompaPerros="conperros";
    _especiecompaGatos="congatos";
    _mascotasactEspR=true;
    var mascotasactCompPerro=await db.collection('Mascotas').where(_especiecompaPerros,whereIn:[_mascotasactEspR] ).get();//ESTA BIEN
      documents.addAll(mascotasactCompPerro.docs) ;
    var mascotasactCompGato=await db.collection('Mascotas').where(_especiecompaGatos,whereIn:[_mascotasactEspR] ).get();//ESTA BIEN
      documents.addAll(mascotasactCompGato.docs) ;
  } else{
    var mascotasactCompPerro=await db.collection('Mascotas').get();//ESTA BIEN
      documents.addAll(mascotasactCompPerro.docs) ;}
  }else{
    var mascotasactCompPerro=await db.collection('Mascotas').get();//ESTA BIEN
      documents.addAll(mascotasactCompPerro.docs) ;}
  // var mascotaantComp=await db.collection('Mascotas').where("sexo",whereIn:[_mascotaantR] ).get();//POR AHORA NO 
  //     documents.addAll(mascotaantComp.docs) ;

//Preferencias 
  var especieComp=await db.collection('Mascotas').where("especie",whereIn:[_especieR] ).get(); //ESTA BIEN
      for (var i = 0; i < 6; i++) {
        documents.addAll(especieComp.docs) ;
      }
  var sexoComp=await db.collection('Mascotas').where("sexo",whereIn:[_sexoR] ).get();//ESTA BIEN
      for (var i = 0; i < 3; i++) {
      documents.addAll(sexoComp.docs) ;
      } 
  var tamanoComp=await db.collection('Mascotas').where("tamano",whereIn:[_tamanoR] ).get();//ESTA BIEN
      for (var i = 0; i < 3; i++) {
      documents.addAll(tamanoComp.docs) ;
      }
  var rangoEdadComp=await db.collection('Mascotas').where("edadComplemento",whereIn:[_rangoEdadR]).get();//ESTA BIEN
      
      for (var i = 0; i < 3; i++) {
      documents.addAll(rangoEdadComp.docs) ;
      }
  var especialComp=await db.collection('Mascotas').where("especial",whereIn:[especial] ).get();
      for (var i = 0; i < 3; i++) {
      documents.addAll(especialComp.docs) ;
      }
 //LISTA DE STRINGS DE MASCOTASID
  var x;
    documents.forEach((data) {    
      x=data.id;
      documentsStrings.add(x);
    });
  var map = Map<String,dynamic>();
  documentsStrings.forEach((element) {
    if(!map.containsKey(element)) {
      map[element] = 1;
    } else { map[element] +=1; }
  });
 // print(map.deepSortByValue().deepReverse());
  var  sorted= map.deepSortByValue().deepReverse();
  final List<String> finalList=<String>[
    sorted.keys.elementAt(0),
    sorted.keys.elementAt(1),
    sorted.keys.elementAt(2),
    sorted.keys.elementAt(3) 
  ];
  return finalList;
  }
  
}