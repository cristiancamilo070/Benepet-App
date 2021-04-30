import 'package:benepet/src/utils/userHelper.dart';
import 'package:benepet/src/widgets/home_bg.dart';
import 'package:benepet/src/widgets/menu_user_widget.dart';
import 'package:benepet/src/widgets/resposive_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
  //Medidas
  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;

  TextEditingController nombreController = TextEditingController();
  TextEditingController numeroController = TextEditingController();

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
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    _large =  ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    _medium =  ResponsiveWidget.isScreenMedium(_width, _pixelRatio);
    return Scaffold(
        appBar: AppBar(
          title: Text('Configuración'),
          elevation: 7,
          centerTitle: true,
          shape: RoundedRectangleBorder(borderRadius:  BorderRadius.only(bottomRight: Radius.circular(30),bottomLeft: Radius.circular(30)),),
          backgroundColor: terciario.withOpacity(0.8),  
        ),
        drawer: MenuUserWidget(),
        body:Container(
        child: HomeBackground(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
              SizedBox(height: 10),
              _titulos("Configuraciones"),
              SizedBox(height: 10),
              _textos("Cambia tu nombre si así lo deseas, recuerda poner tu nombre completo en este campo."),
              SizedBox(height: 20),
              _streamNombre(),
              SizedBox(height: 20),
              _botonActualizar(),
              SizedBox(height: 10),
              _textos("Si quieres postularte como rescatista déjanos tu número y nos contactaremos."),
              SizedBox(height: 10),
              _solicitarRescatista(),
              SizedBox(height: 20),
              _botonEnviarNumeroRescatista(),
              SizedBox(height: 10),
              _textos("Una vez elimines tu cuenta no podrás volver a ingresar a menos que crees una nueva."),
              SizedBox(height: 10),
              _botonEliminar()
              ],
            ),
          ),
         )
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
                fontSize: 38,
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
                fontSize: 25,
                color: primario
              ),
            ),
          ],
        ),
    ),
  );
}

Widget _streamNombre(){
  return StreamBuilder(
  stream:FirebaseFirestore.instance.collection("Users").where("email",isEqualTo: user.email).snapshots(),
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
        return Container(
          child:Material(
        borderRadius: BorderRadius.circular(30.0),
        elevation: _large? 12 : (_medium? 10 : 8),
        child: TextFormField(
          controller: nombreController,
          cursorColor: primario,
          keyboardType: TextInputType.text,
          obscureText: false,
          onSaved: (input) => nombreController.text = input,
          // ignore: missing_return
          validator: (input){
            if(input.isEmpty)
            return 'No puede ser vacio';
          },
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.person, color: primario, size: 20),
            suffixIcon: Icon(Icons.person_pin ,color: primario, size: 15),//added
            hintText: user['name'],
            //labelText: "Nombre y Apellido",//added
            labelStyle: TextStyle(color: primario ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide.none),
            ),
          ),
        ),  
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

Widget _solicitarRescatista(){
  return Container(
    child:Material(
        borderRadius: BorderRadius.circular(30.0),
        elevation: _large? 12 : (_medium? 10 : 8),
        child: TextFormField(
          controller: numeroController,
          cursorColor: primario,
          keyboardType: TextInputType.phone,
          obscureText: false,
          onSaved: (input) => numeroController.text = input,
          // ignore: missing_return
          validator: (input){
            if(input.isEmpty)
            return 'No puede ser vacio';
          },
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.person, color: primario, size: 20),
            suffixIcon: Icon(Icons.person_pin ,color: primario, size: 15),//added
            hintText: "Teléfono",
            labelStyle: TextStyle(color: primario ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide.none),
            ),
          ),
        ),  
      );
}

Widget _botonActualizar(){
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
      UserHelper.cambiarNombre(nombreController.text, user.email);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Su nombre se ha actualizado con éxito."),
                ));  
      },
      child: Ink(
        decoration:BoxDecoration(
        gradient: LinearGradient(colors: [terciario.withOpacity(0.6), terciario]),
        borderRadius: BorderRadius.circular(20)) ,
        child:Container(
          constraints: BoxConstraints.tightFor(width: _width/2, height: _height/18),//tamaño botón
          alignment: Alignment.center,
          child: Text('Actualizar nombre ',style: TextStyle(fontSize: _large? 19: (_medium? 19: 13), fontWeight: FontWeight.bold, color: Colors.white))
        )
      ),
  ),
    );
  
}
Widget _botonEnviarNumeroRescatista(){
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
      showAlertDialog2(context);
      },
      child: Ink(
        decoration:BoxDecoration(
        gradient: LinearGradient(colors: [terciario.withOpacity(0.6), terciario]),
        borderRadius: BorderRadius.circular(20)) ,
        child:Container(
          constraints: BoxConstraints.tightFor(width: _width/2, height: _height/18),//tamaño botón
          alignment: Alignment.center,
          child: Text('Postularme',style: TextStyle(fontSize: _large? 19: (_medium? 19: 13), fontWeight: FontWeight.bold, color: Colors.white))
        )
      ),
    ),
  );
}


showAlertDialog2(BuildContext context) {
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
    onPressed:  () {UserHelper.solicitudRescatista(numeroController.text, user.email);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                       content: Text("Se ha postulado como rescatista con éxito, nos contactaremos."),
                    ));
                    Navigator.of(context).pop();
                  },
  );
  AlertDialog alert = AlertDialog(
    title: Text("Postularme a rescatista",style:TextStyle(fontWeight:FontWeight.bold) ,),
    content: Text("Si ya eres rescatista o quieres serlo, confirma y nos contactaremos a tu número."),
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

Widget _botonEliminar(){
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
       showAlertDialog(context);
      },
      child: Ink(
        decoration:BoxDecoration(
        gradient: LinearGradient(colors: [terciario.withOpacity(0.6), terciario]),
        borderRadius: BorderRadius.circular(20)) ,
        child:Container(
          constraints: BoxConstraints.tightFor(width: _width/2, height: _height/18),//tamaño botón
          alignment: Alignment.center,
          child: Text('Eliminar cuenta ',style: TextStyle(fontSize: _large? 19: (_medium? 19: 13), fontWeight: FontWeight.bold, color: Colors.white))
        )
      ),
  ),
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
