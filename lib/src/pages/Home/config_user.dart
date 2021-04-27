import 'package:benepet/src/widgets/home_bg.dart';
import 'package:benepet/src/widgets/menu_user_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ConfigUser extends StatefulWidget {
  @override
  _ConfigUserState createState() => _ConfigUserState();
}

class _ConfigUserState extends State<ConfigUser> {

  //COLORES--------------------
  final Color primario=Color(0XFF364f6b);
  final Color secundario=Color(0XFF3fc1c9);
  final Color terciario=Color(0XFFfc5185);
  final Color background=Color(0XFFf5f5f5);

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db =FirebaseFirestore.instance;
  var user=FirebaseAuth.instance.currentUser;
  

  deleteAccount(BuildContext context)async{
  
  await _db.collection("Users").doc(FirebaseAuth.instance.currentUser.email).delete();
  await  _db.collection("Users").doc(FirebaseAuth.instance.currentUser.email).collection("Devices").doc("Android").delete();
  await _db.collection("Users").doc(FirebaseAuth.instance.currentUser.email).collection("Devices").doc("Ios").delete();

  _auth.currentUser.delete();
   Navigator.of(context).pushReplacementNamed('login');
  }  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Configuración'),
          elevation: 7,
          centerTitle: true,
          shape: RoundedRectangleBorder(borderRadius:  BorderRadius.circular(20.0)),
          backgroundColor: terciario.withOpacity(0.8),  
        ),
        drawer: MenuUserWidget(),
        body:Container(
        child: HomeBackground(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
              ElevatedButton(onPressed: (){showAlertDialog(context);},
               child: Text("Eliminar cuenta")
               )
              ],
            ),
          ),
         )
        )
    );
  }

showAlertDialog(BuildContext context) {
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
    onPressed:  () {deleteAccount(context);},
  );
  AlertDialog alert = AlertDialog(
    title: Text("¿Quieres eliminar tu cuenta?",style:TextStyle(fontWeight:FontWeight.bold) ,),
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
}
