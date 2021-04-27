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
        leading: Icon(Icons.pets,color: terciario),
        title: Text('Mascotas Disponibles'),
        onTap: (){Navigator.pushReplacementNamed(context,'home');},
        ),
        ListTile(
        leading: Icon(Icons.thumbs_up_down_outlined,color: terciario),
        title: Text('Test de concientización'),
        onTap: (){Navigator.pushReplacementNamed(context,'test');},
        ),
        ListTile(
        leading: Icon(Icons.mood_sharp,color: terciario),
        title: Text('Encontrar mascota ideal'),
        onTap: (){Navigator.pushReplacementNamed(context,'afinidades');},
        ),
         ListTile(
        leading: Icon(Icons.person_sharp,color: terciario),
        title: Text('Perfil'),
        onTap: (){Navigator.pushReplacementNamed(context,'perfilusuario');},
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