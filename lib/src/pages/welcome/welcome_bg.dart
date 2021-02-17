import 'package:flutter/material.dart';

class WelcomeBackground extends StatelessWidget {
  final Widget child;
  const WelcomeBackground({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      color: Color(0XFFffc7c7),//COLOR BACKGROUND
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(//Izquierda arriba
            top: 0,
            left: 0,
            child: Image.asset(
              "assets/img/main_top.png",
              color: Color(0XFFf6f6f6),
              width: size.width * 0.4,
            ),
          ),

          Positioned(//Derecha abajo
            right: 0,
            bottom: 0,
            child: Image.asset(
              "assets/img/login_bottom.png",
              color: Color(0XFF30475e),
              
              width: size.width * 0.595,
            ),
          ),

          Positioned(//Izquierda abajo
            bottom: 0,
            left: 0,
            child: Image.asset(
              "assets/img/main_bottom.png",
              width: size.width * 0.3,
              color: Colors.white,
            ),
          ),
          
          child,
        ],
      ),
    );
  }
}
