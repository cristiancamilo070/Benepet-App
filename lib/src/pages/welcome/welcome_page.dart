import 'package:benepet/src/pages/welcome/welcome_bg.dart';
import 'package:benepet/src/widgets/resposive_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


// ignore: must_be_immutable
class ScrollPage extends StatelessWidget {

  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;
  final Color primario=Color(0XFF364f6b);
  final Color secundario=Color(0XFF3fc1c9);
  final Color terciario=Color(0XFFfc5185);
  final Color background=Color(0XFFf5f5f5);

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
     _width = MediaQuery.of(context).size.width;
     _pixelRatio = MediaQuery.of(context).devicePixelRatio;
     _large =  ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
     _medium =  ResponsiveWidget.isScreenMedium(_width, _pixelRatio);
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
          'assets/svg/jaco.svg',
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
                  color: primario,
                  height: 1,
                  ),
                  textAlign: TextAlign.center,
                  ),

              SizedBox(height: size.height*0.02,),

              Text('BENEPET es una aplicación movil desarrollada para encontrar compatibilidades entre adoptantes y mascotas.',
                style: TextStyle(
                  color: primario,
                  letterSpacing: 1.2,
                  fontSize: 16.0,
                  height: 1.3),
                textAlign: TextAlign.justify,
              )
            ],
          ),
        ),
      
        
      SizedBox(height: size.height*0.01,),
//-----------------------------------BOTON Y FLECHA---------------------------------------------------------------
      Container(
        child: Row(
          children: <Widget>[
          SizedBox(width: _width/3.5),
          ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: primario,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0),),
          elevation: 3,
          textStyle: TextStyle(color: background),
          padding: EdgeInsets.all(0.0)
      ),
      onPressed: (){
       Navigator.of(context).pushNamed('home');
      },
      child: Ink(
        decoration:BoxDecoration(
        gradient: LinearGradient(colors: [terciario.withOpacity(0.6), terciario]),
        borderRadius: BorderRadius.circular(20)) ,
        child:Container(
          constraints: BoxConstraints.tightFor(width: _width/3.0, height: _height/18),//tamaño botón
          alignment: Alignment.center,
          child: Text('Ingresar ',style: TextStyle(fontSize: _large? 19: (_medium? 19: 13), fontWeight: FontWeight.bold, color: Colors.white))
        )
      ),
  ), 

          SizedBox(width: _width/9,),

          SvgPicture.asset('assets/svg/fast-forward.svg',color: primario,height: _height*0.09)
              ]
            ),
          )
          ,
     
      SizedBox(height: _height*0.001,),
//------------------------------------------------Subtitulo Botón-------------------------------------------------
       Container(
          // padding: EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            children: <Widget>[
              SizedBox(
                width: size.height*0.3,
                child: Text(
                  'Ya tengo cuenta!',
                  style: TextStyle(
                      color: primario,
                      letterSpacing: 1.2,
                      fontSize:_large? 14: (_medium? 12: 10),
                      height: 1.3,
                      fontWeight: FontWeight.w400
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
          'assets/svg/happy.svg',
          height: size.height*0.45,
      )
      ,
//-----------------------------------TITULO Y TEXTO--------------------------------------------------------------
       Container(
          padding: EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            children: <Widget>[
              Text('¡Conoce a tu peludito ideal!',
                style: TextStyle(
                  fontSize: 50.0,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w600,//anchura titulo
                  color: primario,
                  height: 1,
                  ),
                  textAlign: TextAlign.center,
                  ),

              SizedBox(height: size.height*0.02,),

              Text('Realiza nuestro proceso de adopción para encontrar compatibilidades entre tu futuro peludito y tú.',
                style: TextStyle(
                  color: primario,
                  letterSpacing: 1.2,
                  fontSize: 16.0,
                  height: 1.3),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      
        
      SizedBox(height: _height*0.02,),
//-----------------------------------BOTON Y FLECHA---------------------------------------------------------------
      Container(
        child: Row(
          children: <Widget>[
      SizedBox(width: _width/3.5),
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: primario,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0),),
          elevation: 3,
          textStyle: TextStyle(color: background),
          padding: EdgeInsets.all(0.0)
      ),
      onPressed: (){
       Navigator.of(context).pushNamed('home');
      },
      child: Ink(
        decoration:BoxDecoration(
        gradient: LinearGradient(colors: [terciario.withOpacity(0.6), terciario]),
        borderRadius: BorderRadius.circular(20)) ,
        child:Container(
          constraints: BoxConstraints.tightFor(width: _width/3.0, height: _height/18),//tamaño botón
          alignment: Alignment.center,
          child: Text('Ingresar ',style: TextStyle(fontSize: _large? 19: (_medium? 19: 13), fontWeight: FontWeight.bold, color: Colors.white))
        )
      ),
  ), 
             
          SizedBox(width: _width/6),

          SvgPicture.asset('assets/svg/fast-forward.svg',color: primario,height: _height*0.09)
          ]
            )
          )
          ,
      SizedBox(height: _height*0.001,),
     //Subtitulo Botón
       Container(
          // padding: EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            children: <Widget>[
              SizedBox(
                width: size.height*0.3,
                              child: Text(
                  'Continuar con el ingreso como adoptante.',
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: primario,
                      letterSpacing: 1.2,
                      fontSize:_large? 14: (_medium? 12: 10),
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
          'assets/svg/animal-shelter.svg',
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
                  color: primario,
                  height: 1,
                  ),
                  textAlign: TextAlign.center,
                  ),

              SizedBox(height: size.height*0.01,),

              Text('Utiliza los procesos de nuestra fundación para encontrarle un dueño ideal a tus peluditos',
                style: TextStyle(
                  color: primario,
                  letterSpacing: 1.2,
                  fontSize: 16.0,
                  height: 1.3),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      
        
      SizedBox(height: size.height*0.02,),
//-----------------------------------BOTON ---------------------------------------------------------------
      Container(
        child:Center(
          child: 
          ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: primario,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0),),
          elevation: 3,
          textStyle: TextStyle(color: background),
          padding: EdgeInsets.all(0.0)
      ),
      onPressed: (){
       Navigator.of(context).pushNamed('home');
      },
      child: Ink(
        decoration:BoxDecoration(
        gradient: LinearGradient(colors: [terciario.withOpacity(0.6), terciario]),
        borderRadius: BorderRadius.circular(20)) ,
        child:Container(
          constraints: BoxConstraints.tightFor(width: _width/3.0, height: _height/18),//tamaño botón
          alignment: Alignment.center,
          child: Text('Ingresar ',style: TextStyle(fontSize: _large? 19: (_medium? 19: 13), fontWeight: FontWeight.bold, color: Colors.white))
        )
      ),
  ), 
        ) 
       ),
          
      SizedBox(height: _height*0.001,),
     //Subtitulo Botón
       Container(
          // padding: EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            children: <Widget>[
              SizedBox(height: 10,),
              SizedBox(
                width: size.height*0.26,
                              child: Text(
                  'Una vez ingreses podrás postularte como rescatista',
                  style: TextStyle(
                      color: primario,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 1.2,
                      fontSize:_large? 14: (_medium? 14: 10),
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