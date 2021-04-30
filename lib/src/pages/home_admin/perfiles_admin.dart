import 'package:benepet/src/utils/userHelper.dart';
import 'package:benepet/src/widgets/home_bg.dart';
import 'package:benepet/src/widgets/menu_admin_widget.dart';
import 'package:benepet/src/widgets/resposive_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expansion_card/expansion_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class PerfilesAdmin extends StatefulWidget {
  @override
  _PerfilesAdminState createState() => _PerfilesAdminState();
}

class _PerfilesAdminState extends State<PerfilesAdmin> {
  
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
  
  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    _large =  ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    _medium =  ResponsiveWidget.isScreenMedium(_width, _pixelRatio);
return Scaffold(
  appBar: AppBar(
  title: Text('Perfiles registrados'),
  elevation: 7,
      centerTitle: true,
      shape: RoundedRectangleBorder(borderRadius:  BorderRadius.only(bottomRight: Radius.circular(30),bottomLeft: Radius.circular(30)),),
  backgroundColor: secundario
  ),
  drawer: MenuAdminWidget(),
  body: Container(
    child: HomeBackground(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
          SizedBox(height: 10,),
          _titulos("Estos son los usuarios que actualmente están registrados."),
          _textos("Recuerda que los usuarios de color azul son aquellos que ya son rescatistas, los amarillos son los postulados a rescatistas, y los rosados los usuarios normales."),
          _textos("Si quieres convertir a un usuario en rescatista solo seleccionalo y confirma tu decisión."),
          streamUsuarios()
    ]
    ),
    ),
    ),
)
);
  }

  Widget _titulos(String descripcion) {
  return Center(
    child: Container(
        margin:EdgeInsets.only(right: 15,left: 15,top: 5,bottom: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              descripcion,
              textAlign: TextAlign.center,
              style: GoogleFonts.frederickaTheGreat(
                fontWeight: FontWeight.bold,
                fontSize:30 ,
                color: primario
              ),
            ),
          ],
        ),
    ),
  );
  }
  Widget _textos(String descripcion) {
  return Center(
    child: Container(
        margin:EdgeInsets.only(right: 15,left: 15,top: 5,bottom: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              descripcion,
              textAlign: TextAlign.justify,
              style: GoogleFonts.mako(
                fontSize: 20,
                color: primario
              ),
            ),
          ],
        ),
    ),
  );
}

Widget streamUsuarios(){
  return StreamBuilder(
  stream:FirebaseFirestore.instance.collection("Users").snapshots(),
  builder:(BuildContext context, 
  AsyncSnapshot<QuerySnapshot> snapshot){
  if (snapshot.hasData&&snapshot.data!=null) {
    final docs=snapshot.data.docs;
      return ListView.builder(
          shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: docs.length,
        itemBuilder: (BuildContext context, int index) {
        final user = docs[index].data();                      
        return ExpansionCard(
          background:Image(
            image: AssetImage("assets/img/no-image.png"),
          color: (user['role']=="admin")?Color(0XFF325288):(user["phone"]!=null)?Color(0XFFf0a500):terciario,//:Color(0XFFf21170),
            height: 150.0,
              width: double.infinity,
              fit: BoxFit.cover,) ,
          borderRadius: 30,
          margin: EdgeInsets.all(9),
            title:  
          Container(
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
                Text( user['name'], 
                    style: GoogleFonts.alfaSlabOne(
                      color:Colors.white,
                      fontSize: 25)),
        
        Text( user['email'],
            style: 
            GoogleFonts.macondo (
              color:Colors.white,
            ) ),
        
      ],
      ),
    ),
    children: [
      (user["role"]=="user"&&user["phone"]==null)?
      ElevatedButton(
        style: ElevatedButton.styleFrom(
        primary: primario,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0),),
        elevation: 3,
        textStyle: TextStyle(color: background),
        padding: EdgeInsets.all(0.0)
        ),
        onPressed: (){
          UserHelper.cambiarRol(user['email']);
        }, 
        child: Ink(
          decoration:BoxDecoration(
          gradient: LinearGradient(colors: [Color(0XFF325288), Color(0XFF325288) ]),
          borderRadius: BorderRadius.circular(20)) ,
          child:Container(
            constraints: BoxConstraints.tightFor(width: _width/2.5, height: _height/18),//tamaño botón
            alignment: Alignment.center,
            child: Text("Hacer admin",style: TextStyle(fontSize: _large? 19: (_medium? 15: 13), fontWeight: FontWeight.bold, color: Colors.white))
          )
        ),     
      ):(user["phone"]!=null)?
      Container(
        child: Column(
          children:[
            Text("Teléfono: "+user["phone"],style: TextStyle(fontSize: _large? 19: (_medium? 18: 13), fontWeight: FontWeight.bold, color: Colors.white)),
            
              ElevatedButton(
            style: ElevatedButton.styleFrom(
            primary: primario,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0),),
            elevation: 3,
            textStyle: TextStyle(color: background),
            padding: EdgeInsets.all(0.0)
            ),
            onPressed: (){
              UserHelper.cambiarRol(user['email']);
            }, 
            child: Ink(
              decoration:BoxDecoration(
              gradient: LinearGradient(colors: [Color(0XFF325288), Color(0XFF325288) ]),
              borderRadius: BorderRadius.circular(20)) ,
              child:Container(
                constraints: BoxConstraints.tightFor(width: _width/2.5, height: _height/18),//tamaño botón
                alignment: Alignment.center,
                child: Text("Hacer admin",style: TextStyle(fontSize: _large? 19: (_medium? 15: 13), fontWeight: FontWeight.bold, color: Colors.white))
              )
            ),     
          ),
          ] 
        ),
      )
      :
      Container(
          padding: EdgeInsets.all(10),
            child: Text("Este usuario ya es rescatista.",
              textAlign: TextAlign.justify
                ,style:GoogleFonts.archivoBlack(
                color:Colors.white,
                fontSize: 17
              ) 
            ),
        ),
      SizedBox(height: 30,)
      ],
    );
      
    },  
  );
}
else {
  return Center(
    child: CircularProgressIndicator(),
  );
}
},
);
}
}