import 'package:flutter/material.dart';

class ResetPassBackground extends StatelessWidget {
  final Widget child;
  const ResetPassBackground({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color primario=Color(0XFF364f6b);
    final Color secundario=Color(0XFF3fc1c9);
    final Color terciario=Color(0XFFfc5185);
    final Color background=Color(0XFFf5f5f5);
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      color: background,//COLOR BACKGROUND
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(//Izquierda arriba
            top: 0,
            left: 0,
            child: Image.asset(
              "assets/img/main_top.png",
              color: terciario,
              width: size.width * 0.4,
            ),
          ),

          Positioned(//Derecha abajo
            right: 0,
            bottom: 0,
            child: Image.asset(
              "assets/img/login_bottom.png",
              color: secundario.withOpacity(0.5),
              
              width: size.width * 0.595,
            ),
          ),

          Positioned(//Izquierda abajo
            bottom: 0,
            left: 0,
            child: Image.asset(
              "assets/img/main_bottom.png",
              width: size.width * 0.3,
              color: primario,
            ),
          ),
          
          child,
        ],
      ),
    );
  }
}
