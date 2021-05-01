import 'package:benepet/src/utils/userAnimals.dart';
import 'package:benepet/src/widgets/home_bg.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MascotaDettalles extends StatefulWidget {
 
  String xd="";
  MascotaDettalles(this.xd);

  @override
  _MascotaDettallesState createState() => _MascotaDettallesState();
}

class _MascotaDettallesState extends State<MascotaDettalles> {
   //COLORES--------------------
  final Color primario=Color(0XFF364f6b);
  final Color secundario=Color(0XFF3fc1c9);
  final Color terciario=Color(0XFFfc5185);
  final Color background=Color(0XFFf5f5f5);
  // double _height;
  // double _width;
  final animalHelper = new AnimalsHelper();

  @override
  void initState() {
    String idMascota=widget.xd;
    getDataMascotas(idMascota);
    super.initState();
  }
  String urlT="",nombreT="",madrinaT="";
  bool disponibleT=true;
  String _especieInitT = '';
  String _sexoInitT = '';
  String _edadCorInitT = '';
  String edadControllerT ='';
  bool apJuguetonT=false, apAmorosoT=false, apTranquiloT=false, apEducadoT=false, apActivoT=false, apDormilonT=false, apTimidoT=false;
  String historiaControllerT='';
  String _tamanoInitT = '';
  String _peloInitT = '';
  String _colorPeloInitT = '';
  bool saludDesT=false, saludVacT=false, saludEsteT=false,saludViralesT=false;
  bool aptoNinosT=false, conPerrosT=false, conGatosT=false;
  bool vivCasaT=false,vivAptoT=false,vivFincaT=false;
  bool especialT=false;

  @override
  Widget build(BuildContext context) {
  // _height = MediaQuery.of(context).size.height;
  // _width = MediaQuery.of(context).size.width;
  String idMascota=widget.xd;
    return Scaffold(
      body: HomeBackground(
              child: CustomScrollView(
          slivers: [
            _crearAppbar(idMascota),
            SliverList(
              delegate: SliverChildListDelegate([
                SizedBox(height: 10.0,),
                _posterTitulo(idMascota),
                _descripcion(idMascota),
                _aptitudesMostrar(),
                _saludMostrar(),
                _viviendaMostrar(),
                _compatibilidadesMostrar(),
                SizedBox(height: 5.0,),
                _boton(idMascota),
                SizedBox(height: 10.0,),
              ]
              )
            )
          ]
    ),
      )
    );
  }

_colorAppbar(){
  if (_sexoInitT=="Macho") {
    return secundario;
  } else { return terciario;
  }
}
Widget _crearAppbar(String idMascota){
  return  SliverAppBar(
    elevation: 2.0,
    backgroundColor: _colorAppbar(),
    expandedHeight: 500.0,//Cambiar tamaño de app bar
    
    stretch: true,//test hisone 
    floating: false,
    pinned: true,
    flexibleSpace: FlexibleSpaceBar(
      title: Text(
        "ID: "+idMascota,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 24.0),
      ),
      centerTitle: true,
      background: CachedNetworkImage(
        imageUrl: urlT.isNotEmpty? urlT:'https://res.cloudinary.com/cristiancruz070/image/upload/v1619056653/tqmy8sjozeeu0pda8sr2.png',
        placeholder: (context, url) { return Image(image: AssetImage('assets/img/jar-loading.gif')); },
        //errorWidget: (context, url, error) => Icon(Icons.error),
        fadeInDuration: Duration(milliseconds: 150),
        fit: BoxFit.cover,
      )
    ),
  );
}

_imgHeroTitilo(){
  String asset="";
  if (_sexoInitT=="Macho"&&_especieInitT=="Gato") {
     asset="assets/img/MaleCat.png";
  } else if(_sexoInitT=="Hembra"&&_especieInitT=="Gato"){
      asset="assets/img/FemaleCat.png";
  } else if(_sexoInitT=="Macho"&&_especieInitT=="Perro"){
       asset="assets/img/MaleDog.png";
  } else if(_sexoInitT=="Hembra"&&_especieInitT=="Perro"){
      asset="assets/img/FemaleDog.png";
  }else  asset="assets/img/no-image.png";
  return asset;
}
_colorCardTitulo(){
  if (_sexoInitT=="Macho") {
    return secundario.withOpacity(0.7);
  } else { return terciario.withOpacity(0.7);
  }
}
Widget _posterTitulo(String idMascota){
  return Card(
    elevation: 2,
    shape: BeveledRectangleBorder(borderRadius:  BorderRadius.circular(10.0),side: BorderSide(color: Colors.white, width: 1) ),
    color: _colorCardTitulo(),
      child: Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          Hero(
            tag: idMascota,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image(
                image: AssetImage(_imgHeroTitilo()),//scale: 2),
                width: 80,
                height: 60.0,
              ),),),
          SizedBox(width: 10.0,),
          Flexible(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Nombre: "+nombreT, style: TextStyle(color:Colors.white, fontSize: 20,fontWeight: FontWeight.bold), overflow:TextOverflow.ellipsis),
              Text("Edad aproximada: "+edadControllerT,style: TextStyle(color:Colors.white, fontSize: 15),overflow:TextOverflow.ellipsis),
              Row(children: [
                  Icon(Icons.short_text_sharp,color: background,),
                  Text("Sexo: "+_sexoInitT.toString(), style: TextStyle(color:Colors.white, fontSize: 15,fontStyle: FontStyle.italic))
                ],),
              Row(children: [
                  Icon(Icons.stacked_line_chart_sharp, color: background,),
                  Text("Tamaño: "+_tamanoInitT.toString(), style: TextStyle(color:Colors.white, fontSize: 15,fontStyle: FontStyle.italic))
                ],),
            ],
          )
          )
        ],
      ),
    ),
  );
}

Widget _descripcion(String mascota){
  return Card(
    elevation: 2,
    shape: BeveledRectangleBorder(borderRadius:  BorderRadius.circular(10.0),side: BorderSide(color: Colors.white, width: 1) ),
    color: Colors.white,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        child: Column(
          children: [
            ListTile(
            leading: Icon(
                Icons.book,
                color: _colorCardTitulo(),
              ),
            title:Text("Historia de la mascota ",style: TextStyle(color: primario, fontSize: 20,fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 5.0,),
            Text(
            historiaControllerT,
            style: TextStyle(color: primario, fontSize: 17,fontWeight: FontWeight.w400,fontStyle: FontStyle.italic),
            textAlign: TextAlign.justify,
          ),
          ],
      ),
    ),
  );
}

//--------------------------------checkBox aptitudes-------------------------------
Widget _aptitudesMostrar(){
return Card(
  elevation: 2,
  shape: BeveledRectangleBorder(borderRadius:  BorderRadius.circular(10.0),side: BorderSide(color: Colors.white, width: 1) ),
  color: Colors.white,
  child:   Container( 
    child: Column(
      children: [
        ListTile(
          leading: Icon(
              Icons.live_help_rounded,
              color: _colorCardTitulo(),
            ),
        title:Text("Aptitudes",style: TextStyle(color:primario, fontSize: 20,fontWeight: FontWeight.bold)),
        ),
        Container(
          child: Row( mainAxisSize: MainAxisSize.min,
            children:<Widget> [
              Expanded(
                child: CheckboxListTile(
                  value:  apJuguetonT,
                  onChanged: (value)=> setState((){}),
                  dense: false,
                  activeColor: _colorCardTitulo(),
                  title: Text("Juguetón",style: TextStyle(color: primario ,fontWeight:FontWeight.bold)),
                ),
              ),  
              Expanded(
                child: CheckboxListTile(
                  value: apAmorosoT,
                  onChanged: (value)=> setState((){}),
                  dense: false,
                  activeColor: _colorCardTitulo(),
                  title: Text("Amoroso",style: TextStyle(color:primario,fontWeight:FontWeight.bold)),
                ),
              ), 
            ],
          ),
        ),
        Container(
          child: Row( mainAxisSize: MainAxisSize.min,
            children:<Widget> [
              Expanded(
                child: CheckboxListTile(
                  value: apTranquiloT,
                  onChanged: (value)=> setState((){}),
                  dense: false,
                  activeColor: _colorCardTitulo(),
                  title: Text("Tranquilo",style: TextStyle(color:primario,fontWeight:FontWeight.bold)),
                ),
              ),  
              Expanded(
                child: CheckboxListTile(
                  value: apEducadoT,
                  onChanged: (value)=> setState((){}),
                  dense: false,
                  activeColor: _colorCardTitulo(),
                  title: Text("Educado",style: TextStyle(color:primario,fontWeight:FontWeight.bold)),
                ),
              ), 
            ],
          ),
        ),
        Container(
          child: Row( mainAxisSize: MainAxisSize.min,
            children:<Widget> [
              Expanded(
                child: CheckboxListTile(
                  value: apActivoT,
                  onChanged: (value)=> setState((){}),
                  dense: false,
                  activeColor: _colorCardTitulo(),
                  title: Text("Activo",style: TextStyle(color:primario,fontWeight:FontWeight.bold)),
                ),
              ),  
              Expanded(
                child: CheckboxListTile(
                  value: apDormilonT,
                  onChanged: (value)=> setState((){}),
                  dense: false,
                  activeColor: _colorCardTitulo(),
                  title: Text("Dormilon",style: TextStyle(color:primario,fontWeight:FontWeight.bold)),
                ),
              ), 
            ],
          ),
        ),
        Container(
          child: Row( mainAxisSize: MainAxisSize.min,
            children:<Widget> [
              Expanded(
                child: CheckboxListTile(
                  value: apTimidoT,
                  onChanged: (value)=> setState((){}),
                  dense: false,
                  activeColor: _colorCardTitulo(),
                  title: Text("Timido",style: TextStyle(color:primario,fontWeight:FontWeight.bold)),
                ),
              ),   
            ],
          ),
        ),                              
      ],  
    ),
  ),
);
}

//--------------------------------CheckBox salud-------------------------------
Widget _saludMostrar(){
return Card(
  elevation: 2,
  shape: BeveledRectangleBorder(borderRadius:  BorderRadius.circular(10.0),side: BorderSide(color: Colors.white, width: 1) ),
  color: Colors.white,
  child:   Container( 
    child: Column(
      children: [
        ListTile(
          leading: Icon(
              Icons.healing_rounded,
              color: _colorCardTitulo(),
            ),
          title: Text("Estado de salud :",style: TextStyle(color:primario, fontSize: 20,fontWeight: FontWeight.bold)),
        ), 
        Container(
          child: Row( mainAxisSize: MainAxisSize.min,
            children:<Widget> [
              Expanded(
                child: CheckboxListTile(
                  value: saludDesT,
                  onChanged: (value)=> setState((){
                  }),
                  dense: false,
                  activeColor: _colorCardTitulo(),
                  title: Text("Desparasitado",style: TextStyle(color:primario,fontWeight:FontWeight.bold)),
                ),
              ),  
              Expanded(
                child: CheckboxListTile(
                  value: saludVacT,
                  onChanged: (value)=> setState((){
                  }),
                  dense: false,
                  activeColor: _colorCardTitulo(),
                  title: Text("Vacunado",style: TextStyle(color:primario,fontWeight:FontWeight.bold)),
                ),
              ), 
            ],
          ),
        ), 
       Container(
          child: Row( mainAxisSize: MainAxisSize.min,
            children:<Widget> [
              Expanded(
                child: CheckboxListTile(
                  value: saludEsteT,
                  onChanged: (value)=> setState((){
                  }),
                  dense: false,
                  activeColor: _colorCardTitulo(),
                  title: Text("Esterilizado",style: TextStyle(color:primario,fontWeight:FontWeight.bold)),
                ),
              ),  
              Expanded(
                child: CheckboxListTile(
                  value: saludViralesT,
                  onChanged: (value)=> setState((){
                  }),
                  dense: false,
                  activeColor: _colorCardTitulo(),
                  title: Text("P. virales",style: TextStyle(color:primario,fontWeight:FontWeight.bold)),
                ),
              ), 
            ],
          ),
        ),                             
      ],  
    ),
  ),
);
}

//--------------------------------CheckBox vivienda-------------------------------
Widget _viviendaMostrar(){
return Card(
  elevation: 2,
  shape: BeveledRectangleBorder(borderRadius:  BorderRadius.circular(10.0),side: BorderSide(color: Colors.white, width: 1) ),
  color: Colors.white,
  child:   Container( 
    child: Column(
      children: [
        ListTile(
          leading: Icon(
              Icons.home,
              color: _colorCardTitulo(),
            ),
          title: Text("Puede vivir en: ",style: TextStyle(color:primario, fontSize: 20,fontWeight: FontWeight.bold)),
        ), 
        Container(
          child: Row( mainAxisSize: MainAxisSize.min,
            children:<Widget> [
              Expanded(
                child: CheckboxListTile(
                  value: vivAptoT,
                  onChanged: (value)=> setState((){
                  }),
                  dense: false,
                  activeColor: _colorCardTitulo(),
                  title: Text("Apto",style: TextStyle(color:primario,fontWeight:FontWeight.bold)),
                ),
              ),  
              Expanded(
                child: CheckboxListTile(
                  value: vivCasaT,
                  onChanged: (value)=> setState((){
                  }),
                  dense: false,
                  activeColor: _colorCardTitulo(),
                  title: Text("Casa",style: TextStyle(color:primario,fontWeight:FontWeight.bold)),
                ),
              ), 
            ],
          ),
        ),   
        Container(
          child: Row( mainAxisSize: MainAxisSize.min,
            children:<Widget> [
              Expanded(
                child: CheckboxListTile(
                  value: vivFincaT,
                  onChanged: (value)=> setState((){
                  }),
                  dense: false,
                  activeColor: _colorCardTitulo(),
                  title: Text("Finca",style: TextStyle(color:primario,fontWeight:FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),                           
      ],  
    ),
  ),
);
}

Widget _compatibilidadesMostrar(){
return Card(
  elevation: 2,
  shape: BeveledRectangleBorder(borderRadius:  BorderRadius.circular(10.0),side: BorderSide(color: Colors.white, width: 1) ),
  color: Colors.white,
  child:   Container( 
    child: Column(
      children: [
        ListTile(
          leading: Icon(
              Icons.pets_rounded,
              color: _colorCardTitulo(),
            ),
          title: Text("Puede convivir con: ",style: TextStyle(color:primario, fontSize: 20,fontWeight: FontWeight.bold)),
        ), 
        Container(
          child: Row( mainAxisSize: MainAxisSize.min,
            children:<Widget> [
              Expanded(
                child: CheckboxListTile(
                  value: aptoNinosT,
                  onChanged: (value)=> setState((){ }),
                  dense: false,
                  activeColor: _colorCardTitulo(),
                  title: Text("Niños",style: TextStyle(color:primario,fontWeight:FontWeight.bold)),
                ),
              ),  
              Expanded(
                child: CheckboxListTile(
                  value: conPerrosT,
                  onChanged: (value)=> setState((){
                  }),
                  dense: false,
                  activeColor: _colorCardTitulo(),
                  title: Text("Perros",style: TextStyle(color:primario,fontWeight:FontWeight.bold)),
                ),
              ), 
            ],
          ),
        ),   
        Container(
          child: Row( mainAxisSize: MainAxisSize.min,
            children:<Widget> [
              Expanded(
                child: CheckboxListTile(
                  value: conGatosT,
                  onChanged: (value)=> setState((){ }),
                  dense: false,
                  activeColor: _colorCardTitulo(),
                  title: Text("Gatos",style: TextStyle(color:primario,fontWeight:FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),                           
      ],  
    ),
  ),
);
}

Widget  _boton(String mascota) {
    return ElevatedButton.icon(
      icon: Icon(Icons.clear_rounded, color: background),
      label: Text('Eliminar mascota',style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
      style: ElevatedButton.styleFrom(
        
        primary: _colorAppbar(),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0),),
        elevation: 3,
        textStyle: TextStyle(color: background),
        padding: EdgeInsets.all(0.0)
    ),
    onPressed: (){showAlertDialog( context,mascota);
    },
  );
  }


showAlertDialog(BuildContext context,String mascota) {
  Widget cancelButton = ElevatedButton(
    child: Text("Cancelar"),
        style: ElevatedButton.styleFrom(
         primary: primario,
         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0),),
         elevation: 4,
         textStyle: TextStyle(color: background),
         padding: EdgeInsets.all(0.0)
      ),
    onPressed:  () { Navigator.of(context).pop();},
  );
  Widget continueButton = ElevatedButton(
    child: Text("Si",style:TextStyle(fontWeight:FontWeight.bold) ),
    style: ElevatedButton.styleFrom(
         primary: terciario,
         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0),),
         elevation: 4,
         textStyle: TextStyle(color: background),
         padding: EdgeInsets.all(0.0)
      ),
    onPressed:  () {animalHelper.deleteMascota(mascota);Navigator.of(context).pushReplacementNamed('home');},
  );
  AlertDialog alert = AlertDialog(
    title: Text("¿Quieres eliminar a esta mascota?",style:TextStyle(fontWeight:FontWeight.bold) ,),
    content: Text("Esta acción no tiene reversa."),
    elevation: 10,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    
    actions: [
      cancelButton,
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

// ignore: missing_return
Future<String> getDataMascotas(String idMascota ) async{
    String url, nombre, madrina;
    bool disponible;
    String _especieInit ;
    String _sexoInit ;
    String edadController ;
    bool apJugueton, apAmoroso, apTranquilo, apEducado, apActivo, apDormilon, apTimido;
    String historiaController ;
    String _tamanoInit ;
    String _peloInit ;
    String _colorPeloInit ;
    bool saludDes, saludVac, saludEste,saludVirales;
    bool aptoNinos, conPerros, conGatos;
    bool vivCasa,vivApto,vivFinca;
    bool especial;

    //Map mapa;
    final db = FirebaseFirestore.instance;
    
    await db.collection('Mascotas').doc(idMascota).get()
    .then((DocumentSnapshot documentSnapshot) {     
      //mapa=documentSnapshot.data().map((key, value) => null); 
      madrina  =documentSnapshot.data()['usuario'].toString();               
      url =documentSnapshot.data()['url'].toString();
      nombre =documentSnapshot.data()['nombre'].toString();
      disponible=documentSnapshot.data()['disponible'];
      _especieInit=documentSnapshot.data()['especie']; 
      _sexoInit=documentSnapshot.data()['sexo']; 
      edadController =documentSnapshot.data()['edad']+" "+documentSnapshot.data()['edadComplemento'];
          apJugueton=documentSnapshot.data()['jugueton']; apAmoroso=documentSnapshot.data()['amoroso'];
          apTranquilo=documentSnapshot.data()['tranquilo']; apEducado=documentSnapshot.data()['educado'];
          apActivo=documentSnapshot.data()['activo']; apDormilon=documentSnapshot.data()['dormilon']; apTimido=documentSnapshot.data()['timido'];
      historiaController =documentSnapshot.data()['historia'].toString();
      _tamanoInit =documentSnapshot.data()['tamano'].toString();
      _peloInit =documentSnapshot.data()['tipopelo'].toString();
      _colorPeloInit =documentSnapshot.data()['colorpelo'].toString();
          saludDes=documentSnapshot.data()['desparasitado']; saludVac=documentSnapshot.data()['vacunado'];
          saludEste=documentSnapshot.data()['esterilizado'];saludVirales=documentSnapshot.data()['virales'];
          aptoNinos=documentSnapshot.data()['ninos'];conPerros=documentSnapshot.data()['conperros']; conGatos=documentSnapshot.data()['congatos'];
          vivCasa=documentSnapshot.data()['casa'];vivApto=documentSnapshot.data()['apto'];vivFinca=documentSnapshot.data()['finca'];
          especial=documentSnapshot.data()['especial'];
    }
  );
    setState(() {
      urlT=url.toString();
      nombreT=nombre.toString();
      
      disponibleT=disponible;
      _especieInitT = _especieInit.toString();
      _sexoInitT = _sexoInit.toString();
      
      edadControllerT =edadController;
      apJuguetonT=apJugueton; apAmorosoT=apAmoroso; apTranquiloT=apTranquilo; apEducadoT=apEducado; apActivoT=apActivo; apDormilonT=apDormilon; apTimidoT=apTimido;
      historiaControllerT=historiaController;
      _tamanoInitT = _tamanoInit;
      _peloInitT = _peloInit;
      _colorPeloInitT = _colorPeloInit;
      saludDesT=saludDes; saludVacT=saludVac; saludEsteT=saludEste; saludViralesT=saludVirales;
      aptoNinosT=aptoNinos; conPerrosT=conPerros; conGatosT=conGatos;
      vivCasaT=vivCasa; vivAptoT=vivApto; vivFincaT=vivFinca;
      especialT=especial;
      madrinaT=madrina;
    });
  }

}