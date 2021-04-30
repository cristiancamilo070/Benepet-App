import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MenuUserWidget extends StatelessWidget {
      //COLORES--------------------
  final Color primario=Color(0XFF364f6b);
  final Color secundario=Color(0XFF3fc1c9);
  final Color terciario=Color(0XFFfc5185);
  final Color background=Color(0XFFf5f5f5);
  
  final FirebaseAuth _auth = FirebaseAuth.instance;
  signOut(BuildContext context) async{
    _auth.signOut();
    Navigator.of(context).pushReplacementNamed('home');
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          child: Container(
            alignment: Alignment.center,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  spreadRadius: 0.0,
                  color: Colors.black26,
                  offset: Offset(1.0, 10.0),
                  blurRadius: 20.0),
            ],
            color: Colors.white,
            shape: BoxShape.circle,
          ),
            child: SvgPicture.asset(
              'assets/svg/profile.svg',
           ),
          ),
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
        Divider(thickness: 2),
        ListTile(
        leading: Icon(Icons.verified_user,color: terciario),
        title: Text('Conócenos'),
        onTap: (){Navigator.pushReplacementNamed(context,'conocenosUser');},
        ),
        Divider(thickness: 2),
        ListTile(
        leading: Icon(Icons.thumbs_up_down_outlined,color: terciario),
        title: Text('Test de concientización'),
        onTap: (){Navigator.pushReplacementNamed(context,'test');},
        ),
        Divider(thickness: 2),
        ListTile(
        leading: Icon(Icons.mood_sharp,color: terciario),
        title: Text('Encontrar mascota ideal'),
        onTap: (){Navigator.pushReplacementNamed(context,'afinidades');},
        ),
        Divider(thickness: 2),
         ListTile(
        leading: Icon(Icons.toggle_on_rounded,color: terciario),
        title: Text('Configuraciones'),
        onTap: (){Navigator.pushReplacementNamed(context,'configUser');},
        ),
        Divider(thickness: 2),
         ListTile(
        leading: Icon(Icons.logout,color: terciario),
        title: Text('Cerrar sesión'),
        onTap: (){signOut(context );},
        ),
        Divider(thickness: 2),
      ],
    ),
  );
  }
}