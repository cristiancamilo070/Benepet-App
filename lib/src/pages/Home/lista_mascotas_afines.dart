import 'package:benepet/src/pages/home/detalles_afines_mascotas.dart';
import 'package:benepet/src/widgets/home_bg.dart';
import 'package:benepet/src/widgets/menu_user_widget.dart';
import 'package:benepet/src/widgets/resposive_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expansion_card/expansion_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'mascotas_detalles_user.dart';
class ListaMascotasAfines extends StatefulWidget {
  List list;
  ListaMascotasAfines(this.list);
  @override
  _ListaMascotasAfinesState createState() => _ListaMascotasAfinesState();
}

class _ListaMascotasAfinesState extends State<ListaMascotasAfines> {
  

  @override
  void initState() {
    List listaAfinidades=widget.list;
    print(listaAfinidades);
        super.initState();
  }
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
          title: Text('Tus mascotas afines'),
          elevation: 7,
          centerTitle: true,
          shape: RoundedRectangleBorder(borderRadius:  BorderRadius.only(bottomRight: Radius.circular(30),bottomLeft:Radius.circular(30) ),),
          backgroundColor: terciario.withOpacity(0.8),          
        ),
        drawer: MenuUserWidget(),
        body:   Container(
          child: HomeBackground(
            child: SingleChildScrollView(
             child: Container(
               child: SingleChildScrollView(child: 
                Column(
                  children: [
                  //  _lista1(cero),
                  //  _lista1(uno)
                  _descriptionText("Estas son las mascotas más afines a tí "),
                  SizedBox(height: 10,),
                  _lista3(0),
                  SizedBox(height: 10,),
                  _lista3(1),
                  SizedBox(height: 10,),
                  _lista3(2),
                  SizedBox(height: 10,),
                  _lista3(3),
                  SizedBox(height: 20,),
                  ],
                ),
              ), 
            ),
          )
        )
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
              fontSize: 50,
              color: primario
            ),
          ),
        ],
      ),
  );
  }

_lista3(int i){
  List listaAfinidades=widget.list;
  String digito=listaAfinidades[i];
return StreamBuilder(
  stream: FirebaseFirestore.instance.collection("Mascotas").where("id",isEqualTo: digito).snapshots(),
  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    if (snapshot.hasData&&snapshot.data!=null) {
      final docs=snapshot.data.docs;
      return  ListView.builder(
        padding: EdgeInsets.all(3.0),
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: docs.length, 
        itemBuilder: (BuildContext context, int index) { 
          final mascota = docs[index].data(); 
          return ExpansionCard(  
          borderRadius: 50,
          margin: EdgeInsets.all(9),
          background: (mascota['url'] == null )    
                ? Image(image: AssetImage('assets/img/no-image.png'))
                :ClipRRect(
                  child:CachedNetworkImage(
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
                Text(
                    mascota["nombre"] ,
        
                    style: GoogleFonts.alfaSlabOne(
                      color:Colors.white,
                      fontSize: 19)),
                Text(
                  "id: "+digito,
                  style: 
                  GoogleFonts.courgette(
                    color:Colors.white,
                  ) ),
              ],
            ),
          ),
          children: <Widget>[
            // Container(
            //   margin: EdgeInsets.symmetric(horizontal: 7),
            //   child: Text(mascota["historia"],
            //       style: GoogleFonts.cuprum(
            //         color: Colors.white,
            //         fontSize: 19
            //       )),
            //     ),
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
                      return MascotaDettallesAfines(listaAfinidades[i]);
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
    }else return CircularProgressIndicator();
    
    }
  );
}

}