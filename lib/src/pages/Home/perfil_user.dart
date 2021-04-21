import 'package:benepet/src/widgets/menu_user_widget.dart';
import 'package:flutter/material.dart';
class PerfilUser extends StatefulWidget {
  @override
  _PerfilUserState createState() => _PerfilUserState();
}

class _PerfilUserState extends State<PerfilUser> {
  
  //COLORES--------------------
  final Color primario=Color(0XFF364f6b);
  final Color secundario=Color(0XFF3fc1c9);
  final Color terciario=Color(0XFFfc5185);
  final Color background=Color(0XFFf5f5f5);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Perfil'),
          backgroundColor: terciario.withOpacity(0.8)          
        ),
        drawer: MenuUserWidget(),//CREATE NEW DRAWER FOR USER 
    );
  }
}