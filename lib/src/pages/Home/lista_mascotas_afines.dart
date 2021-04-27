import 'package:benepet/src/pages/home/mascotas_detalles_user.dart';
import 'package:benepet/src/widgets/home_bg.dart';
import 'package:benepet/src/widgets/menu_user_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
  
  @override
  Widget build(BuildContext context) {
    List listaAfinidades=widget.list;
    String cero=listaAfinidades[0];
    String uno=listaAfinidades[1];
    print(cero);
    print(_lista2(0));
    print(_lista2(1));
    return Scaffold(
        appBar: AppBar(
          title: Text('Perfil'),
          elevation: 7,
          centerTitle: true,
          shape: RoundedRectangleBorder(borderRadius:  BorderRadius.circular(20.0)),
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
                  _lista2(0),
                  _lista2(1),
                  _lista2(2),
                  _lista2(3)
                  ],
                ),
              ), 
            ),
          )
        )
      ),
    );
  }

_lista1(String x)  {
      List listaAfinidades=widget.list;
return StreamBuilder(
  stream: FirebaseFirestore.instance.collection("Mascotas").where("id",isEqualTo: listaAfinidades.contains(widget.list)).get().asStream(),
  builder:(BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    if (snapshot.hasData&&snapshot.data!=null) {
      final docs=snapshot.data.docs;
      snapshot.data.docs;
      return ListView.custom(
        childrenDelegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              listaAfinidades[index];
              final mascota = docs[index].data();
              return Card(
              child: Column(children:[               
              (mascota['url'] == null )    
                ? Image(image: AssetImage('assets/img/no-image.png'))
                : FadeInImage(
                  image: NetworkImage( mascota['url'] ),
                  placeholder: AssetImage('assets/img/jar-loading.gif'),
                  height: 300.0,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                ListTile(  
                  title: Text(mascota['id'] ?? mascota['nombre']),
                  subtitle: Text(mascota['nombre']),
                  // onTap: ()  {
                  //   Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                  //     return MascotaDettallesUser(mascota['id']);
                  //    }) );
                  // }
                ),
              ]
            ),
          );;
            },
        
          )
        );
   
      }else return CircularProgressIndicator();
    
    }
  );
}


_lista2(int i){
  List listaAfinidades=widget.list;
return Container(
  child:   Card(
    child: Column(children:[
       // for (var i = 0; i < listaAfinidades.length; i++) {
          ListTile(
            title:Text(listaAfinidades[i]),
            onTap: ()  {
                    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                      return MascotaDettallesUser(listaAfinidades[i]);
                     }) );
                  }
            )
          ]  
        )
      ),
);
  
}
}