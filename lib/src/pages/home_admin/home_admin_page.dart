import 'dart:async';
import 'package:benepet/src/bloc/auth_bloc.dart';
import 'package:benepet/src/pages/home_admin/mascotas_detalles_admin.dart';
import 'package:benepet/src/pages/login/login_page.dart';
import 'package:benepet/src/utils/userAnimals.dart';
import 'package:benepet/src/widgets/home_bg.dart';
import 'package:benepet/src/widgets/menu_admin_widget.dart';
import 'package:benepet/src/widgets/resposive_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expansion_card/expansion_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomeAdminPage extends StatefulWidget {

  @override
  _HomeAdminPageState createState() => _HomeAdminPageState();

}


class _HomeAdminPageState extends State<HomeAdminPage> {
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
  
  final productoProvider = new AnimalsHelper();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User user;
  bool isloggedin= false;
  bool cargando=false;//testing 
  StreamSubscription<User> loginStateSubscription;//cancelar el listener 

  @override
  void initState() {
    var authBloc = Provider.of<AuthBloc>(context, listen: false);
    loginStateSubscription = authBloc.currentUser.listen((fbUser) {
      if (fbUser == null) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ),
        );
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    loginStateSubscription.cancel();//add ? to all de dispose's methods 
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    _large =  ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    _medium =  ResponsiveWidget.isScreenMedium(_width, _pixelRatio);
    return Scaffold(
      appBar: AppBar(
        title: Text("Inicio Fundación"),
        elevation: 7,
          centerTitle: true,
          shape: RoundedRectangleBorder(borderRadius:  BorderRadius.only(bottomRight: Radius.circular(30),bottomLeft: Radius.circular(30)),),
        backgroundColor: secundario,
      ),
      drawer: MenuAdminWidget(),
      body: Container(
          child: HomeBackground(
            child: SingleChildScrollView(
            child: Container(
        child: SingleChildScrollView(child: 
          Column(
           children: [
             _titulos("Todos nuestros peluditos"),
             SizedBox(height: 20,),
            _listaCompleta()
        ],
        ),
        ),
      ),
     )
    )
  )

  );
}
_listaCompleta( ){
return StreamBuilder(
  stream: FirebaseFirestore.instance.collection("Mascotas").snapshots(),
  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    if (snapshot.hasData&&snapshot.data!=null) {
      final docs=snapshot.data.docs;
      return  ListView.separated(
        padding: EdgeInsets.all(3.0),
        separatorBuilder: (BuildContext context, int index) => const Divider(height: 10,),
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: docs.length, 
        itemBuilder: (BuildContext context, int index) { 
          SizedBox(height: 10);
          final mascota = docs[index].data(); 
          return ExpansionCard(  
          borderRadius: 30,
          margin: EdgeInsets.all(9),
          background: (mascota['url'] == null )    
                ? Image(image: AssetImage('assets/img/no-image.png'))
                :ClipRRect(
                  child: CachedNetworkImage(
                      imageUrl: mascota['url'],
                      placeholder: (context, url) { return Image(image: AssetImage('assets/img/jar-loading.gif')); },
                      //errorWidget: (context, url, error) => Icon(Icons.error),
                      height:300 ,
                      width:double.infinity ,
                      fit: BoxFit.cover,
                  )
                ),
            title: Container(       
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text( mascota["nombre"] ,
                    style: GoogleFonts.alfaSlabOne(
                      color:Colors.white,
                      fontSize: 19)),
                Text( "id: "+mascota["id"],
                  style: 
                  GoogleFonts.courgette(
                    color:Colors.white,
                  ) ),
              ],
            ),
          ),
          children: <Widget>[
            SizedBox(height: 160,), 
            ElevatedButton(
              style: ElevatedButton.styleFrom(
              primary: primario,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0),),
              elevation: 3,
              textStyle: TextStyle(color: background),
              padding: EdgeInsets.all(0.0)
              ),
              onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                      return MascotaDettalles(mascota['id']);
                     }) );
              }, 
              child: Ink(
                decoration:BoxDecoration(
                gradient: LinearGradient(colors: [secundario.withOpacity(0.6), secundario ]),
                borderRadius: BorderRadius.circular(20)) ,
                child:Container(
                  constraints: BoxConstraints.tightFor(width: _width/2.5, height: _height/18),//tamaño botón
                  alignment: Alignment.center,
                  child: Text('Ver ahora',style: TextStyle(fontSize: _large? 19: (_medium? 15: 13), fontWeight: FontWeight.bold, color: Colors.white))
                )
              ),     
            )       
          ],    
          
        );
      },      
      );
    }else return Center(child: Container(child: Column(children:[
      SizedBox(height: 200,),
      Text("Cargando...",style: GoogleFonts.alegreyaSansSc(),),
      CircularProgressIndicator()

    ] )));
    }
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
                fontSize: 38,
                color: primario
              ),
            ),
          ],
        ),
    ),
  );
}
Widget imagenxd(){
  return CachedNetworkImage(
        imageUrl: "http://via.placeholder.com/350x150",
        placeholder: (context, url) { AssetImage('assets/img/jar-loading.gif');},
        //errorWidget: (context, url, error) => Icon(Icons.error),
        height:300 ,
        width:double.infinity ,
        fit: BoxFit.cover,

     );
}

}