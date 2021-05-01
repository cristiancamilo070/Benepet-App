import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MenuAdminWidget extends StatelessWidget {
      //COLORES--------------------
  final Color primario=Color(0XFF364f6b);
  final Color secundario=Color(0XFF3fc1c9);
  final Color terciario=Color(0XFFfc5185);
  final Color background=Color(0XFFf5f5f5);

  final FirebaseAuth _auth = FirebaseAuth.instance;
  signOut(BuildContext context )async{
    _auth.signOut();
    Navigator.of(context).pushReplacementNamed('home');
  }

  @override
  Widget build(BuildContext context) {
    String foto;
    if (_auth.currentUser.photoURL!=null) {
      foto=_auth.currentUser.photoURL.replaceFirst('s96', 's400');
    }
    return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          child: CircleAvatar(
            backgroundImage:(foto!=null)? NetworkImage(foto):AssetImage("assets/img/gamer.png") ,
            backgroundColor: background,
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
            ),
          ),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/img/menu-img.jpg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(secundario.withOpacity(0.7), BlendMode.color)
            ),            
          ),
        ),
        ListTile(
        leading: Icon(Icons.pets_sharp,color: secundario),
        title: Text('Todas las mascotas'),
        onTap: (){Navigator.pushReplacementNamed(context,'home');},
        ),
        Divider(thickness: 2),
        ListTile(
        leading: Icon(Icons.add_box_outlined,color: secundario),
        title: Text('Añadir/Actualizar mascotas'),
        onTap: (){Navigator.pushReplacementNamed(context,'mascotasAdmin');},
        ),
        Divider(thickness: 2,),
        ListTile(
        leading: Icon(Icons.people_alt_outlined, color: secundario),
        title: Text('Perfiles'),
        onTap: (){Navigator.pushReplacementNamed(context,'perfilesAdmin');},
        ),
        Divider(thickness: 2,),
        ListTile(
        leading: Icon(Icons.verified_user,color: secundario),
        title: Text('Nosotros'),
        onTap: (){Navigator.pushReplacementNamed(context,'conocenos');},
        ),
        Divider(thickness: 2,),
        ListTile(
        leading: Icon(Icons.login_outlined,color: secundario),
        title: Text('Cerrar sesión'),
        onTap: (){signOut(context);},
        ),
        Divider(thickness: 2,),
      ],
    ),
  );
  }
}