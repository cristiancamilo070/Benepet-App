import 'package:benepet/src/widgets/home_bg.dart';
import 'package:benepet/src/widgets/menu_admin_widget.dart';
import 'package:benepet/src/widgets/resposive_widget.dart';
import 'package:expansion_card/expansion_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
class InformacionAdmin extends StatefulWidget {
  @override
  _InformacionAdminState createState() => _InformacionAdminState();
}

class _InformacionAdminState extends State<InformacionAdmin> {
  
  //COLORES--------------------
  final Color primario=Color(0XFF364f6b);
  final Color secundario=Color(0XFF3fc1c9);
  final Color terciario=Color(0XFFfc5185);
  final Color background=Color(0XFFf5f5f5);
  //Medidas
  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;
  
  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    _large =  ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    _medium =  ResponsiveWidget.isScreenMedium(_width, _pixelRatio);
    return Scaffold(
      appBar: AppBar(
      title: Text('Conócenos'),
      elevation: 7,
          centerTitle: true,
          shape: RoundedRectangleBorder(borderRadius:  BorderRadius.only(bottomRight: Radius.circular(30),bottomLeft: Radius.circular(30)),),
      backgroundColor: secundario
      ),
      drawer: MenuAdminWidget(),
      body: Container(
        child: HomeBackground(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
              SizedBox(height: 10,),
              _logo("assets/img/fundacioncorazon.png"),
              SizedBox(height: 15,),
              _titulos("Conócenos"),
              _card("assets/img/fundacion2.jfif", "¿Quiénes somos?", "Los mejores cuidados.", "Somos una Fundación sin fines de lucro dedicada al rescate de perros y gatos en situación de abandono o de maltrato, así como al apoyo de rescatistas independientes que tengan el mismo fin. Trabajamos en la concientización y educación a la comunidad sobre la tenencia y adopción responsables, nuestra bandera más importante es el fomento de las esterilizaciones. Somos una red de personas trabajando en equipo bajo el mismo objetivo de protección animal."),
              SizedBox(height: 15,),
              _card("assets/img/fundacion1.jfif", "Misión", "Apoyando con el corazón.", "Rescatar perros y gatos en situación de abandono o de maltrato. Apoyar a refugios, rescatistas independientes, hogares de paso y personas naturales que día a día están comprometidos con mejorar la calidad de vida de los peluditos que lo necesitan. Capacitar a dichas personas en las áreas financiera, comercial, de salud, tenencia responsable y primeros auxilios, entre otras, para que puedan desarrollar sus propios objetivos y educar a sus comunidades. Entendemos que la educación es la base del cambio."),
              SizedBox(height: 15,),
              _card("assets/img/fundacion3.jfif", "Visión", "Apoyando con el corazón.", "Ser un equipo en constante movimiento y en permanente lucha por los derechos de los animales, comprometido con lograr un cambio en nuestra sociedad. Para los primeros 5 años de operaciones nuestras metas son: llegar a las 3.000 esterilizaciones, superar las 3.000 adopciones caninas y felinas, consolidar el Grupo Empresarial y aumentar el número de hogares de paso a lo largo del territorio nacional."),
              Divider(),
              _titulos("Pasos para adopción"),
              _cardPasos(primario, "Paso 1", "Leer", "Los peluditos se entregan con formulario de adopción a mayores de edad para la ciudad de Bogotá. No se entrega para zonas con sobrepoblación canina y felina y por cada adopción, se solicita un aporte de 80.000 pesos para la madrina del peludo adoptado los cuales son destinados a cubrir los primeros gastos de recuperación que se requieren al iniciar el rescate de un nuevo peludito, sigue con el punto 2"),
              _cardPasos(Color(0XFFff75a0), "Paso 2", "Realizar test de compatibilidades ", "Una vez realices el test de compatibilidad de afinidades de BENEPET podras ver todas las caracteristicas de dicho peludo y podras acceder al formulario de adopción, luego sigue al paso 3."),
              _cardPasosBoton(Color(0XFFffc93c), "Paso 3", "Diligenciar formulario", "Diligencia nuestra solicitud de adopción que podrás descargar una vez realices el paso 2 o directamente desde el botón de abajo, recuerda que esta la deberas enviar al correo electrónico adopcionescorazonpeludito@gmail.com (para poder descargar el archivo en tu celular debes tener un lector de Word). Como sugerencia, por favor, indícanos 3 opciones por si alguna de las elecciones ya se encuentra en proceso Una vez recibida la solicitud, en un plazo máximo de 3 días hábiles, te daremos respuesta al correo y nos pondremos en contacto para continuar con el proceso.*Ten presente que si la solicitud de adopción no está completamente diligenciada, no será tenida en cuenta."
                              ,"Solicitud de adopción","https://www.corazonpeludito.org/wp-content/uploads/2020/05/Solicitud-de-adopcion-Corazon-Peludito-2020.docx"),
              _cardPasos(Color(0XFFe9896a), "Paso 4", "Donación", "El aporte de la adopción (80.000 pesos) es destinado para el rescatista que ha invertido su tiempo, amor y dedicación para poder entregar un peludo en óptimas condiciones. Es un aporte mínimo y simbólico que hacen las personas que adoptan con el fin de ayudar a iniciar un nuevo rescate. Todos nuestros peludos son entregados esterilizados, desparasitados y recuperados"),
              _cardPasos(Color(0XFF3a6351), "Paso 5", "Entrega", "Cuando el peludito adoptado se encuentra bajo protección de la Fundación la entrega será coordinada directamente con la Directora. Cuando se trata de un peludo que está protegido por alguna de las madrinas los términos de la adopción, entrega y demás aspectos serán acordados entre Madrina y adoptante y la Fundación no interviene de ninguna manera en este acuerdo. El aporte de Adopción debe ser entregado a la madrina ya que este valor es un aporte que hace el adoptante para que ella pueda iniciar un nuevo rescate. Nuestra Fundación no avala que se realicen cobros adicionales por ningún concepto a los adoptantes. Los Peluditos, obligatoriamente deben estar esterilizados antes de la entrega y por ningún motivo se debe aceptar que se efectúen cobros adicionales por este concepto."),
              SizedBox(height: 15,),
              Center(child: Text("Escríbenos a Whatsapp: ",style: GoogleFonts.alfaSlabOne(color:primario,fontSize: 19 ),)),
              _whatsapp(),
              SizedBox(height: 15,),
              Center(child: Text("BENEPET, desarrollado por ",style: GoogleFonts.alfaSlabOne(color:primario,fontSize: 9 ),)),
             // Center(child: ),
              _devlogo(),
              SizedBox(height: 15,),
            ]
          ),
        ),
      ),
    )
  );
}

Widget _logo(String imagen) {
return Container(
      alignment: Alignment.bottomCenter,
      margin: EdgeInsets.only(right: 15,left: 15),
      child: FadeInImage(
        image: AssetImage(imagen),
         placeholder:AssetImage("assets/img/no_image2.jpg") ,
      ),
  );
}

Widget _titulos(String descripcion) {
  return Center(
    child: Container(
        margin:EdgeInsets.only(right: 15,left: 15,top: 5,bottom: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              descripcion,
              textAlign: TextAlign.center,
              style: GoogleFonts.frederickaTheGreat(
                fontWeight: FontWeight.bold,
                fontSize: 38,
                color: primario
              ),
            ),
          ],
        ),
    ),
  );
  }

Widget _card(String imagen,String titulo,String subtitulo,String info ){
return  Container(
  padding: EdgeInsets.all(3.0),
  child: ExpansionCard(
          borderRadius: 30,
          margin: EdgeInsets.all(9),
          background: (imagen == null )    
                ? Image(image: AssetImage('assets/img/no-image.png'))
                :ClipRRect(
                  child: FadeInImage(
                    image: AssetImage(imagen),
                    placeholder: AssetImage('assets/img/jar-loading.gif'),
                    height: 350.0,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
            title: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 25,),
                Center(
                  child: Text( titulo ,
                      style: GoogleFonts.alfaSlabOne(
                        color:Colors.white,
                        fontSize: 25)),
                ),
                Center(
                  child: Text( subtitulo,
                    style: 
                    GoogleFonts.courgette(
                      color:Colors.white,
                    ) ),
                ),
              ],
            ),
          ),
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              color: Colors.black.withOpacity(0.2),
                child: Text(info,
                  textAlign: TextAlign.justify
                   ,style:GoogleFonts.aleo(
                    color:Colors.white,
                    fontSize: 17
                  ) 
                ),
            ),
            //SizedBox(height: 160,),     
          ],        
        )
        );
}


Widget _cardPasos(Color color, String titulo,String subtitulo,String info ){
return  Container(
  padding: EdgeInsets.all(3.0),
  child: ExpansionCard(
          background:Image(image: AssetImage("assets/img/no-image.png"),color: color,height: 200.0,
                    width: double.infinity,
                    fit: BoxFit.cover,) ,
          borderRadius: 30,
          margin: EdgeInsets.all(9),
            title: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Text( titulo ,
                      style: GoogleFonts.alfaSlabOne(
                        color:Colors.white,
                        fontSize: 25)),
                ),
                Center(
                  child: Text( subtitulo,
                    style: GoogleFonts.courgette(
                      color:Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    ),
                ),
              ],
            ),
          ),
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              color: color,
                child: Text(info,
                textAlign: TextAlign.justify, 
                style:GoogleFonts.aleo(
                    color:Colors.white,
                    fontSize: 17
                  ) 
                ),
            ),
            //SizedBox(height: 160,),     
          ],        
        )
        );
}

Widget _cardPasosBoton(Color color, String titulo,String subtitulo,String info,nombreBoton,String link ){
return  Container(
  padding: EdgeInsets.all(3.0),
  child: ExpansionCard(
          background:Image(image: AssetImage("assets/img/no-image.png"),color: color,height: 200.0,
                    width: double.infinity,
                    fit: BoxFit.cover,) ,
          borderRadius: 30,
          margin: EdgeInsets.all(9),
            title: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Text( titulo ,
                      style: GoogleFonts.alfaSlabOne(
                        color:Colors.white,
                        fontSize: 25)),
                ),
                Center(
                  child: Text( subtitulo,
                    style: GoogleFonts.courgette(
                      color:Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    ),
                ),
              ],
            ),
          ),
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              color: color,
                child: Text(info,
                textAlign: TextAlign.justify, 
                style:GoogleFonts.aleo(
                    color:Colors.white,
                    fontSize: 17
                  ) 
                ), 
            ),
            SizedBox(height: 5,),
            ElevatedButton(
            style: ElevatedButton.styleFrom(
            primary: primario,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0),),
            elevation: 3,
            textStyle: TextStyle(color: background),
            padding: EdgeInsets.all(0.0)
            ),
            onPressed: (){
              launch(link);
            }, 
            child: Ink(
              decoration:BoxDecoration(
              gradient: LinearGradient(colors: [color, color ]),
              borderRadius: BorderRadius.circular(20)) ,
              child:Container(
                constraints: BoxConstraints.tightFor(width: _width/2.5, height: _height/18),//tamaño botón
                alignment: Alignment.center,
                child: Text(nombreBoton,style: TextStyle(fontSize: _large? 19: (_medium? 15: 13), fontWeight: FontWeight.bold, color: Colors.white))
              )
            ),     
          ),
         ],        
        )
        );
}

Widget _whatsapp(){
  return 
     Center(
       child: Container(
        margin: EdgeInsets.only(top: _height / 120.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[            
            CircleAvatar(
              radius: 40,
              child:  GestureDetector(
                onTap: (){launch("https://api.whatsapp.com/send?phone=573106894861&text="); },
                child:SvgPicture.asset("assets/svg/whatsapp.svg"),
                ) 
              )
            ] 
          ) 
    
  ),
     );
}

_devlogo(){
 return  Center(
   child: Container(
          margin: EdgeInsets.only(top: _height / 120.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Cristian Cruz ",style: GoogleFonts.alfaSlabOne(color:primario,fontSize: 9 ),)
,              CircleAvatar(
                child:SvgPicture.asset("assets/svg/flutter_dev.svg"),
              )
            ],
            )            
          ),
 );
}


}