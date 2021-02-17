
//import 'package:benepet/src/items/welcome_items.dart';
import 'package:benepet/src/pages/home_page.dart';
import 'package:benepet/src/pages/welcome/welcome_bg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class ScrollPage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      body: Container(
        child: PageView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            _pagina1(context),
            _pagina2(context),
            _pagina3(context)
            
          ],
        ),
      )
    );
  }

Widget _pagina1(BuildContext context) {
  Size size = MediaQuery.of(context).size;
return WelcomeBackground(
  child: SingleChildScrollView(
  child: Column(
    children: [
      SizedBox(height: size.height*0.1,),
//-----------------------------------LOGO INICIAL---------------------------------------------------------------      
     SvgPicture.asset(
          'assets/svg/8.svg',
          height: size.height*0.45,
      )
      ,
//-----------------------------------TITULO Y TEXTO--------------------------------------------------------------
       Container(
          padding: EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            children: <Widget>[
              Text('Bienvenido a BENEPET!',
                style: TextStyle(
                  fontSize: 50.0,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w600,//anchura titulo
                  color: Color(0XFF30475e),
                  height: 1,
                  ),
                  textAlign: TextAlign.center,
                  ),

              SizedBox(height: size.height*0.02,),

              Text('BENEPET es una aplicación movil desarrollada para la prevención del abandono animal!',
                style: TextStyle(
                  color: Color(0XFFe8e8e8),
                  letterSpacing: 1.2,
                  fontSize: 16.0,
                  height: 1.3),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      
        
      SizedBox(height: size.height*0.01,),
//-----------------------------------BOTON Y FLECHA---------------------------------------------------------------
      Container(
            child: Row(
              children: <Widget>[
              SizedBox(width: size.height*0.2),
              RaisedButton(
              elevation: 6,
              splashColor: Color(0XFFefbbcf),
              onPressed: ()=> Navigator.push(context, MaterialPageRoute(
              builder: (context) => HomePage()
               )
               ), 
              child: Text('Ingresar!'),
              color: Color(0XFF30475e),
              textColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
              padding: EdgeInsets.all(15) ,
              ),
             
              SizedBox(width: size.height*0.08,),

              SvgPicture.asset('assets/svg/fast-forward.svg',height: size.height*0.09)
              ]
            ),
          )
          ,
          
      SizedBox(height: size.height*0.01,),
     //Subtitulo Botón
       Container(
          // padding: EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            children: <Widget>[
              SizedBox(
                width: size.height*0.25,
                              child: Text(
                  'Ingresar ya!',
                  style: TextStyle(
                      color: Color(0XFFe8e8e8),
                      letterSpacing: 1.2,
                      fontSize: 15.0,
                      height: 1.3
                      ),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
         ],
      ),
    ),
  );
  }

Widget _pagina2(BuildContext context) {
  Size size = MediaQuery.of(context).size;
  return WelcomeBackground(
  child: SingleChildScrollView(
  child: Column(
    children: [
      SizedBox(height: size.height*0.1,),
//-----------------------------------LOGO INICIAL---------------------------------------------------------------      
     SvgPicture.asset(
          'assets/svg/7.svg',
          height: size.height*0.45,
      )
      ,
//-----------------------------------TITULO Y TEXTO--------------------------------------------------------------
       Container(
          padding: EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            children: <Widget>[
              Text('¡Conoce a tu peliduto ideal!',
                style: TextStyle(
                  fontSize: 50.0,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w600,//anchura titulo
                  color: Color(0XFF30475e),
                  height: 1,
                  ),
                  textAlign: TextAlign.center,
                  ),

              SizedBox(height: size.height*0.01,),

              Text('Realiza nuestro proceso de adopción para encontrar compatibilidades entre tu futuro peludito y tú.',
                style: TextStyle(
                  color: Color(0XFFe8e8e8),
                  letterSpacing: 1.2,
                  fontSize: 16.0,
                  height: 1.3),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      
        
      SizedBox(height: size.height*0.02,),
//-----------------------------------BOTON Y FLECHA---------------------------------------------------------------
      Container(
            child: Row(
              children: <Widget>[
              SizedBox(width: size.height*0.2),
              RaisedButton(
              elevation: 6,
              splashColor: Color(0XFFefbbcf),
              onPressed: ()=> Navigator.push(context, MaterialPageRoute(
              builder: (context) => HomePage()
               )
               ), 
              child: Text('Adoptar!'),
              color: Color(0XFF30475e),
              textColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
              padding: EdgeInsets.all(15) ,
              ),
             
              SizedBox(width: size.height*0.08,),

              SvgPicture.asset('assets/svg/fast-forward.svg',height: size.height*0.09)
              ]
            ),
          )
          ,
          
      SizedBox(height: size.height*0.01,),
     //Subtitulo Botón
       Container(
          // padding: EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            children: <Widget>[
              SizedBox(
                width: size.height*0.24,
                              child: Text(
                  'Continuar con el ingreso como adoptante.',
                  style: TextStyle(
                      color: Color(0XFFe8e8e8),
                      letterSpacing: 1.2,
                      fontSize: 15.0,
                      height: 1.3
                      ),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
         ],
      ),
    ),
  );
  }

Widget _pagina3(BuildContext context) {
  Size size = MediaQuery.of(context).size;
  return WelcomeBackground(
  child: SingleChildScrollView(
  child: Column(
    children: [
      SizedBox(height: size.height*0.1,),
//-----------------------------------LOGO INICIAL---------------------------------------------------------------      
     SvgPicture.asset(
          'assets/svg/2.svg',
          height: size.height*0.45,
      )
      ,
//-----------------------------------TITULO Y TEXTO--------------------------------------------------------------
       Container(
          padding: EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            children: <Widget>[
              Text('¿Eres rescatista independiente?',
                style: TextStyle(
                  fontSize: 45.0,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w600,//anchura titulo
                  color: Color(0XFF30475e),
                  height: 1,
                  ),
                  textAlign: TextAlign.center,
                  ),

              SizedBox(height: size.height*0.01,),

              Text('Utiliza los procesos de nuestra fundación para encontrarle un dueño ideal a tus peluditos',
                style: TextStyle(
                  color: Color(0XFFe8e8e8),
                  letterSpacing: 1.2,
                  fontSize: 16.0,
                  height: 1.3),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      
        
      SizedBox(height: size.height*0.02,),
//-----------------------------------BOTON Y FLECHA---------------------------------------------------------------
      Container(
            child: Row(
              children: <Widget>[
              SizedBox(width: size.height*0.19),
              RaisedButton(
              elevation: 6,
              splashColor: Color(0XFFefbbcf),
              onPressed: ()=> Navigator.push(context, MaterialPageRoute(
              builder: (context) => HomePage()
               )
               ), 
              child: Text('Postularme'),
              color: Color(0XFF30475e),
              textColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
              padding: EdgeInsets.all(15) ,
              ),
             
              //SizedBox(width: size.height*0.08,),

              //SvgPicture.asset('assets/svg/fast-forward.svg',height: size.height*0.09)
              ]
            ),
          )
          ,
          
      SizedBox(height: size.height*0.01,),
     //Subtitulo Botón
       Container(
          // padding: EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            children: <Widget>[
              SizedBox(
                width: size.height*0.24,
                              child: Text(
                  'Continuar con el ingreso como adoptante.',
                  style: TextStyle(
                      color: Color(0XFFe8e8e8),
                      letterSpacing: 1.2,
                      fontSize: 15.0,
                      height: 1.3
                      ),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
         ],
      ),
    ),
  );
  }

}