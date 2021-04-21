import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MenuUserWidget extends StatelessWidget {
      //COLORES--------------------
  final Color primario=Color(0XFF364f6b);
  final Color secundario=Color(0XFF3fc1c9);
  final Color terciario=Color(0XFFfc5185);
  final Color background=Color(0XFFf5f5f5);
  
  final FirebaseAuth _auth = FirebaseAuth.instance;
  signOut()async{
    _auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          child: Container(),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/img/menu-img.jpg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(terciario.withOpacity(0.7), BlendMode.color)
            ),            
          ),
        ),
        ListTile(
        leading: Icon(Icons.pages,color: terciario),
        title: Text('Home'),
        onTap: (){Navigator.pushReplacementNamed(context,'home');},
        ),
        ListTile(
        leading: Icon(Icons.pages,color: terciario),
        title: Text('Mascotas'),
        onTap: (){Navigator.pushReplacementNamed(context,'mascotasUser');},
        ),
         ListTile(
        leading: Icon(Icons.pages,color: terciario),
        title: Text('Perfiles'),
        onTap: (){Navigator.pushReplacementNamed(context,'perfilUser');},
        ),
         ListTile(
        leading: Icon(Icons.pages,color: terciario),
        title: Text('Configuraciones'),
        onTap: (){Navigator.pushReplacementNamed(context,'configUser');},
        ),
         ListTile(
        leading: Icon(Icons.pages,color: terciario),
        title: Text('Cerrar sesión'),
        onTap: (){signOut();},
        )
      ],
    ),
  );
  }
}