import 'dart:async';
import 'package:benepet/src/bloc/auth_bloc.dart';
import 'package:benepet/src/pages/login/login_page.dart';
import 'package:benepet/src/widgets/home_bg.dart';
import 'package:benepet/src/widgets/menu_admin_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class HomeAdminPage extends StatefulWidget {

  @override
  _HomeAdminPageState createState() => _HomeAdminPageState();

}

class _HomeAdminPageState extends State<HomeAdminPage> {


  final FirebaseAuth _auth = FirebaseAuth.instance;
  User user;
  bool isloggedin= false;
  StreamSubscription<User> loginStateSubscription;//cancelar el listener 
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

    //COLORES--------------------
  final Color primario=Color(0XFF364f6b);
  final Color secundario=Color(0XFF3fc1c9);
  final Color terciario=Color(0XFFfc5185);
  final Color background=Color(0XFFf5f5f5);

  checkAuthentification() async{
    _auth.authStateChanges().listen((user) { 
      if(user !=null){
        Navigator.pushNamed(context, 'home');
      }
      else{ Navigator.pushNamed(context, 'signup');}
    });
  }

  getUser() async{
    User firebaseUser = _auth.currentUser;
    await firebaseUser?.reload();
    firebaseUser = _auth.currentUser;
    if(firebaseUser !=null){
      setState(() {
        this.user =firebaseUser;
        this.isloggedin=true;
      });
    }
  }

  signOut()async{
    _auth.signOut();
  }

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
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Admin"),
        backgroundColor: secundario,
      ),
      drawer: MenuAdminWidget(),
      body: Container(
          child: HomeBackground(
            child: SingleChildScrollView(
            child: Container(
        child: SingleChildScrollView(child: Column(children: [
          ElevatedButton(
              onPressed: (){
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("cargando"),
                ));
              }
              , child: Text("snakebar")
              )
        ],),),
        ),
        )
        )
      )

    );
}
  // Widget _crearListado() {

  //   return FutureBuilder(
  //     future: productosProvider.cargarProductos(),
  //     builder: (BuildContext context, AsyncSnapshot<List<ProductoModel>> snapshot) {
  //       if ( snapshot.hasData ) {

  //         final productos = snapshot.data;

  //         return ListView.builder(
  //           itemCount: productos.length,
  //           itemBuilder: (context, i) => _crearItem(context, productos[i] ),
  //         );

  //       } else {
  //         return Center( child: CircularProgressIndicator());
  //       }
  //     },
  //   );
  // }
// Widget _crearItem(BuildContext context, ProductoModel producto ) {

//     return Dismissible(
//       key: UniqueKey(),
//       background: Container(
//         color: Colors.red,
//       ),
//       onDismissed: ( direccion ){
//         productosProvider.borrarProducto(producto.id);
//       },
//       child: Card(
//         child: Column(
//           children: <Widget>[

//             ( producto.fotoUrl == null ) 
//               ? Image(image: AssetImage('assets/no-image.png'))
//               : FadeInImage(
//                 image: NetworkImage( producto.fotoUrl ),
//                 placeholder: AssetImage('assets/jar-loading.gif'),
//                 height: 300.0,
//                 width: double.infinity,
//                 fit: BoxFit.cover,
//               ),
            
//             ListTile(
//               title: Text('${ producto.titulo } - ${ producto.valor }'),
//               subtitle: Text( producto.id ),
//               onTap: () => Navigator.pushNamed(context, 'producto', arguments: producto ),
//             ),

//           ],
//         ),
//       )
//     );


    

//   }


//   _crearBoton(BuildContext context) {
//     return FloatingActionButton(
//       child: Icon( Icons.add ),
//       backgroundColor: Colors.deepPurple,
//       onPressed: ()=> Navigator.pushNamed(context, 'producto'),
//     );
//   }

}