import 'dart:async';
import 'package:benepet/src/bloc/auth_bloc.dart';
import 'package:benepet/src/pages/home/mascotas_detalles_user.dart';
import 'package:benepet/src/pages/login/login_page.dart';
import 'package:benepet/src/utils/userAnimals.dart';
import 'package:benepet/src/widgets/home_bg.dart';
import 'package:benepet/src/widgets/menu_user_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {
  //COLORES--------------------
  final Color primario=Color(0XFF364f6b);
  final Color secundario=Color(0XFF3fc1c9);
  final Color terciario=Color(0XFFfc5185);
  final Color background=Color(0XFFf5f5f5);

  final productoProvider = new AnimalsHelper();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User user;
  bool isloggedin= false;
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
    loginStateSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Home "),
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
        child: SingleChildScrollView(child: 
          Column(
           children: [
            _crearListado()
        ],
        ),
        ),
        ),
        )
        )
      )

    );
}


_crearListado() {
return StreamBuilder(
  stream: FirebaseFirestore.instance.collection("Mascotas").snapshots(),
  builder:(BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    if (snapshot.hasData&&snapshot.data!=null) {
      final docs=snapshot.data.docs;
        return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: docs.length,
          itemBuilder: (BuildContext context, int i) {
            final mascota = docs[i].data();                      
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
                  onTap: ()  {
                    //String masId=mascota['id'];
                    //enviarDatos(masId);
                    // String a =mascota['id'];
                    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                      return MascotaDettallesUser(mascota['id']);
                    }) );
                    }
                ),
              ]
              ),
            );
          },  
        );
      }else return CircularProgressIndicator();
    }
  );
}
}