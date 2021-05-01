import 'dart:io';
import 'package:benepet/src/utils/userAnimals.dart';
import 'package:benepet/src/widgets/home_bg.dart';
import 'package:benepet/src/widgets/menu_admin_widget.dart';
import 'package:benepet/src/widgets/resposive_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class MascotasAdmin extends StatefulWidget {
  @override
  _MascotasAdminState createState() => _MascotasAdminState();
}

class _MascotasAdminState extends State<MascotasAdmin> {

  //Medidas
  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;

  final formKey     = GlobalKey<FormState>();
  final productoProvider = new AnimalsHelper();
    
  File photo;
  
  //Colores--------------------
  final Color primario=Color(0XFF364f6b);
  final Color secundario=Color(0XFF3fc1c9);
  final Color terciario=Color(0XFFfc5185);
  final Color background=Color(0XFFf5f5f5);  
 
  //Controladores ---------------------
  TextEditingController nombreController = TextEditingController();
  TextEditingController idController = TextEditingController();
  bool disponible=true;
  String _especieInit = 'Gato';
  List<String> _especie = ['Perro','Gato'];
  String _sexoInit = 'Macho';
  List<String> _sexo = ['Macho','Hembra'];
  String _edadCorInit = 'Años';
  List<String> _edadCor = ['Años','Meses'];
  TextEditingController edadController = TextEditingController();
  //String apData="";
  bool apJugueton=false, apAmoroso=false, apTranquilo=false, apEducado=false, apActivo=false, apDormilon=false, apTimido=false;
  TextEditingController historiaController = TextEditingController();
  String _tamanoInit = 'Mediano';
  List<String> _tamano = ['Grande','Mediano','Pequeño'];
  String _peloInit = 'Mediano';
  List<String> _pelo = ['Largo','Mediano','Corto'];
  String _colorPeloInit = '2 Colores';
  List<String> _colorPelo = ['1 Color','2 Colores','3 Colores'];
  bool saludDes=false, saludVac=false, saludEste=false,saludVirales=false;
  bool aptoNinos=false, conPerros=false, conGatos=false;
  bool vivCasa=false,vivApto=false,vivFinca=false;
  bool especial=false;
  String _photoUrl;

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    _large =  ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    _medium =  ResponsiveWidget.isScreenMedium(_width, _pixelRatio);
    
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text('Añadir mascotas')),
          elevation: 7,
          centerTitle: true,
          shape: RoundedRectangleBorder(borderRadius:  BorderRadius.only(bottomRight: Radius.circular(30),bottomLeft: Radius.circular(30)),),
          backgroundColor: secundario,
          actions: <Widget>[
          IconButton(
            icon: Icon( Icons.add_photo_alternate ),
            onPressed:(){_seleccionarFoto();} ,
          ),
          IconButton(
            icon: Icon( Icons.camera_alt ),
            onPressed:(){_tomarFoto();} ,
          ),
          ],
        ),
        drawer: MenuAdminWidget(),
        body: Container(
          child: HomeBackground(
            child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(15.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: <Widget>[
                    _mostrarFoto(),
                    SizedBox(height: 10.0,),
                    Row(children:[Text('¿Cuál es el ID de la mascota?',style: TextStyle(color:primario,fontWeight:FontWeight.bold,fontSize: 16))]),               
                    _idMascota(),
                    Row(children:[Text('¿Cuál es el nombre de la mascota?',style: TextStyle(color:primario,fontWeight:FontWeight.bold,fontSize: 16))]),
                    _nombreMascota(),
                    _crearDisponible(),
                    Row(children:[Text('¿Cuál es la especie de la mascota?',style: TextStyle(color:primario,fontWeight:FontWeight.bold,fontSize: 16))]),
                    _especieDrop(),
                    SizedBox(height: 5.0,),
                    Row(children:[Text('¿Cuál es el sexo de la mascota?',style: TextStyle(color:primario,fontWeight:FontWeight.bold,fontSize: 16))]),               
                    _sexoDrop(),
                    Row(children:[Text('¿Cuál la edad aproximada de la mascota?',style: TextStyle(color:primario,fontWeight:FontWeight.bold,fontSize: 16))]),
                    _edadNumber(),
                    SizedBox(height: 5.0,),
                    _aptitudesCheck(),
                    SizedBox(height: 5.0,),
                    Row(children:[Text('¿Cuál es la historia de la mascota?',style: TextStyle(color:primario,fontWeight:FontWeight.bold,fontSize: 16))]),
                    _historia(),
                    SizedBox(height: 5.0,),
                    Row(children:[Text('¿Cuál es el tamaño de la mascota?',style: TextStyle(color:primario,fontWeight:FontWeight.bold,fontSize: 16))]),               
                    _tamanoDrop(),
                    SizedBox(height: 5.0,),
                    _saludCheck(),
                    _conEspecial(),
                    _aptoNinos(),
                    _conPerros(),
                    _conGatos(),
                    _viviendaCheck(),
                    SizedBox(height: 15.0,),
                    Center(child: Text('Para añadir una mascota: ',style: TextStyle(color:primario,fontWeight:FontWeight.bold,fontSize: 16))),
                    SizedBox(height: 5.0,),
                    _boton(),
                    SizedBox(height: 5.0,),
                    Center(child: Text('Para actualizar unicamente los datos de una mascota recuerda que debes agregar todos los datos completos exeptuando la imagen ya que esta no se remplazará a menos que publiques de nuevo al peludito.',textAlign: TextAlign.center,style: TextStyle(color:primario,fontWeight:FontWeight.bold,fontSize: 16))),
                    SizedBox(height: 5.0,),
                    _boton2()
                  ],
                ),
              ),
            ),
          ),
          ),
        ),
    );
  }
Widget _idMascota() {
    return TextFormField(
      controller: idController,
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      textCapitalization: TextCapitalization.sentences,
      onSaved: (value) => idController.text = value,//???
      decoration: InputDecoration(
                hintText: "Escribe el ID de la mascota",
                labelStyle: TextStyle(color: primario ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide.none),
                ),
    );
}
Widget _nombreMascota() {
    return TextFormField(
      //initialValue: animalesModel.titulo,
      controller: nombreController,
      textCapitalization: TextCapitalization.sentences,
      onSaved: (value) =>nombreController.text = value,//animalesModel.titulo = value ????
      decoration: InputDecoration(
                hintText: "Escribe el nombre",
                labelStyle: TextStyle(color: primario ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide.none),
                ),
    );
}


//--------------------------------Switch disponible-------------------------------
Widget _crearDisponible() {
    return SwitchListTile(
      value: disponible,
      title: Text('Disponible',style: TextStyle(color:primario,fontWeight:FontWeight.bold)),
      activeColor: terciario,
      onChanged: (value)=> setState((){
        disponible = value;
      }),
    );
  }
//--------------------------------DROP especie-------------------------------
Widget _especieDrop(){
  return Row(
    children: [
      Icon(Icons.pets_outlined, color: terciario,),
      SizedBox(width: 30.0,),
      Expanded(
        child: DropdownButton(
         iconEnabledColor: terciario,
         value: _especieInit,
         items: getEspecie(),
         onChanged: (opt){
          setState(() {
            _especieInit=opt;
          });}, ), ),
      SizedBox(width: 30.0,),
    ],
  ); 
}
List<DropdownMenuItem<String>> getEspecie(){
  List<DropdownMenuItem<String>> lista=[];
  _especie.forEach((x) { 
    lista.add(DropdownMenuItem(
      child: Text(x, style: TextStyle(color:terciario,fontWeight:FontWeight.bold)),
      value: x,
    ));
  });
  return lista;
  }
//--------------------------------DROP Sexo-------------------------------
Widget _sexoDrop(){
  return Row(
    children: [
      Icon(Icons.person_outline_outlined,color: terciario),
      SizedBox(width: 30.0,),
      Expanded(
        child: DropdownButton(
         iconEnabledColor: terciario,
         value: _sexoInit,
         items: getSexo(),
         onChanged: (opt){
          setState(() {
            _sexoInit=opt;
          }
          );
        },
      ),
     ),
     SizedBox(width: 30.0,),
    ],
  ); 
}
List<DropdownMenuItem<String>> getSexo(){
  List<DropdownMenuItem<String>> lista=[];
  _sexo.forEach((x) { 
    lista.add(DropdownMenuItem(
      child: Text(x,style: TextStyle(color:terciario,fontWeight:FontWeight.bold)),
      value: x,
    ));
  });
  return lista;
  }
//----------------------------------EDAD MASCOTA----------------------------------------
Widget _edadNumber() {
    return Column(
      children: [
           TextFormField(
                controller: edadController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                textCapitalization: TextCapitalization.none,
                onSaved: (value) => edadController.text = value,//animalesModel.titulo = value,
                decoration: InputDecoration(
                  hintText: "Escribe el número y si años o meses.",
                  labelStyle: TextStyle(color: primario ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide.none),
                  ),
              ),
              _edadComDrop()
              ],
    ); 
}
Widget _edadComDrop(){
  return Row(
    children: [
      Icon(Icons.calendar_today,color: terciario),
      SizedBox(width: 30.0,),
      Expanded(
        child: DropdownButton(
         iconEnabledColor: terciario,
         value: _edadCorInit,
         items: getEdadCor(),
         onChanged: (opt){
          setState(() {
            _edadCorInit=opt;
          }
          );
        },
      ),
     ),
     SizedBox(width: 30.0,),
    ],
  ); 
}

List<DropdownMenuItem<String>> getEdadCor(){
  List<DropdownMenuItem<String>> lista=[];
  _edadCor.forEach((x) { 
    lista.add(DropdownMenuItem(
      child: Text(x,style: TextStyle(color:terciario,fontWeight:FontWeight.bold)),
      value: x,
    ));
  });
  return lista;
  }
//--------------------------------checkBox aptitudes-------------------------------
Widget _aptitudesCheck(){
return Card(
  elevation: 2,
  child:   Container( 
    child: Column(
      children: [
        ListTile(
          leading: Icon(
              Icons.flare_rounded,
              color: terciario,
            ),
          title: Text("Selecciones las aptitudes de la mascota",style: TextStyle(color:primario,fontWeight:FontWeight.bold)),
        ), 
        Container(
          child: Row( mainAxisSize: MainAxisSize.min,
            children:<Widget> [
              Expanded(
                child: CheckboxListTile(
                  value:  apJugueton,
                  onChanged: (value)=> setState((){
                    apJugueton=value;//recently added 
                  }),
                  dense: false,
                  activeColor: terciario,
                  title: Text("Juguetón",style: TextStyle(color:primario,fontWeight:FontWeight.bold)),
                ),
              ),  
              Expanded(
                child: CheckboxListTile(
                  value: apAmoroso,
                  onChanged: (value)=> setState((){
                    apAmoroso=value;//recently added 
                  }),
                  dense: false,
                  activeColor: terciario,
                  title: Text("Amoroso",style: TextStyle(color:primario,fontWeight:FontWeight.bold)),
                ),
              ), 
            ],
          ),
        ),
        Container(
          child: Row( mainAxisSize: MainAxisSize.min,
            children:<Widget> [
              Expanded(
                child: CheckboxListTile(
                  value: apTranquilo,
                  onChanged: (value)=> setState((){
                    apTranquilo=value;//recently added 
                  }),
                  dense: false,
                  activeColor: terciario,
                  title: Text("Tranquilo",style: TextStyle(color:primario,fontWeight:FontWeight.bold)),
                ),
              ),  
              Expanded(
                child: CheckboxListTile(
                  value: apEducado,
                  onChanged: (value)=> setState((){
                    apEducado=value;//recently added 
                  }),
                  dense: false,
                  activeColor: terciario,
                  title: Text("Educado",style: TextStyle(color:primario,fontWeight:FontWeight.bold)),
                ),
              ), 
            ],
          ),
        ),
        Container(
          child: Row( mainAxisSize: MainAxisSize.min,
            children:<Widget> [
              Expanded(
                child: CheckboxListTile(
                  value: apActivo,
                  onChanged: (value)=> setState((){
                    apActivo=value;//recently added 
                  }),
                  dense: false,
                  activeColor: terciario,
                  title: Text("Activo",style: TextStyle(color:primario,fontWeight:FontWeight.bold)),
                ),
              ),  
              Expanded(
                child: CheckboxListTile(
                  value: apDormilon,
                  onChanged: (value)=> setState((){
                    apDormilon=value;//recently added 
                  }),
                  dense: false,
                  activeColor: terciario,
                  title: Text("Dormilon",style: TextStyle(color:primario,fontWeight:FontWeight.bold)),
                ),
              ), 
            ],
          ),
        ),
        Container(
          child: Row( mainAxisSize: MainAxisSize.min,
            children:<Widget> [
              Expanded(
                child: CheckboxListTile(
                  value: apTimido,
                  onChanged: (value)=> setState((){
                    apTimido=value;//recently added 
                  }),
                  dense: false,
                  activeColor: terciario,
                  title: Text("Timido",style: TextStyle(color:primario,fontWeight:FontWeight.bold)),
                ),
              ),   
            ],
          ),
        ),                              
      ],  
    ),
  ),
);
}
//--------------------------------Historia-------------------------------
Widget _historia(){
  return TextFormField(
  //initialValue: animalesModel.titulo,
  controller: historiaController,
  textCapitalization: TextCapitalization.sentences,
  onSaved: (value) => historiaController.text = value,//animalesModel.titulo = value,
  decoration: InputDecoration(
            hintText: "Escribe una pequeña historia de la mascota",
            labelStyle: TextStyle(color: primario ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide.none),
            ),
);
     
}
//--------------------------------CheckBox salud-------------------------------
Widget _saludCheck(){
return Card(
  elevation: 2,
  child:   Container( 
    child: Column(
      children: [
        ListTile(
          leading: Icon(
              Icons.healing_rounded,
              color: terciario,
            ),
          title: Text("En cuanto salud la mascota está: ",style: TextStyle(color:primario,fontWeight:FontWeight.bold)),
        ), 
        Container(
          child: Row( mainAxisSize: MainAxisSize.min,
            children:<Widget> [
              Expanded(
                child: CheckboxListTile(
                  value: saludDes,
                  onChanged: (value)=> setState((){
                    saludDes=value;//recently added 
                  }),
                  dense: false,
                  activeColor: terciario,
                  title: Text("Desparasitado",style: TextStyle(color:primario,fontWeight:FontWeight.bold)),
                ),
              ),  
              Expanded(
                child: CheckboxListTile(
                  value: saludVac,
                  onChanged: (value)=> setState((){
                    saludVac=value;//recently added 
                  }),
                  dense: false,
                  activeColor: terciario,
                  title: Text("Vacunado",style: TextStyle(color:primario,fontWeight:FontWeight.bold)),
                ),
              ), 
            ],
          ),
        ), 
       Container(
          child: Row( mainAxisSize: MainAxisSize.min,
            children:<Widget> [
              Expanded(
                child: CheckboxListTile(
                  value: saludEste,
                  onChanged: (value)=> setState((){
                    saludEste=value;//recently added 
                  }),
                  dense: false,
                  activeColor: terciario,
                  title: Text("Esterilizado",style: TextStyle(color:primario,fontWeight:FontWeight.bold)),
                ),
              ),  
              Expanded(
                child: CheckboxListTile(
                  value: saludVirales,
                  onChanged: (value)=> setState((){
                    saludVirales=value;//recently added 
                  }),
                  dense: false,
                  activeColor: terciario,
                  title: Text("P. virales",style: TextStyle(color:primario,fontWeight:FontWeight.bold)),
                ),
              ), 
            ],
          ),
        ),                             
      ],  
    ),
  ),
);
}
//--------------------------------DROP Tamaño-------------------------------
Widget _tamanoDrop(){
  return Row(
    children: [
      Icon(Icons.photo_size_select_small,color: terciario,),
      SizedBox(width: 30.0,),
      Expanded(
        child: DropdownButton(
         iconEnabledColor: terciario,
         value: _tamanoInit,
         items: getTamano(),
         onChanged: (opt){
          setState(() {
            _tamanoInit=opt;
          }
          );
        },
      ),
     ),
     SizedBox(width: 30.0,),
    ],
  ); 
}
List<DropdownMenuItem<String>> getTamano(){
  List<DropdownMenuItem<String>> lista=[];
  _tamano.forEach((x) { 
    lista.add(DropdownMenuItem(

      child: Text(x,style: TextStyle(color:terciario,fontWeight:FontWeight.bold)),
      value: x,
    ));
  });
  return lista;
}


List<DropdownMenuItem<String>> getColorPelo(){
  List<DropdownMenuItem<String>> lista=[];
  _colorPelo.forEach((x) { 
    lista.add(DropdownMenuItem(
      child: Text(x,style: TextStyle(color:terciario,fontWeight:FontWeight.bold)),
      value: x,
    ));
  });
  return lista;
}
//--------------------------------Switch  Apto para niños -------------------------------
Widget _aptoNinos() {
    return SwitchListTile(
      value: aptoNinos,
      title: Text('Apto para niños',style: TextStyle(color:primario,fontWeight:FontWeight.bold)),
      activeColor: terciario,
      onChanged: (value)=> setState((){
        aptoNinos=value;//recently added 
      }),
    );
  }
//--------------------------------Convive con perros -------------------------------
Widget _conPerros() {
    return SwitchListTile(
      value: conPerros,
      title: Text('Convive con perros',style: TextStyle(color:primario,fontWeight:FontWeight.bold)),
      activeColor: terciario,
      onChanged: (value)=> setState((){
        conPerros = value;
      }),
    );
  }
  //------------------------------Convive con gatos------------------------------
Widget _conGatos() {
    return SwitchListTile(
      value: conGatos,
      title: Text('Convive con gatos',style: TextStyle(color:primario,fontWeight:FontWeight.bold)),
      activeColor: terciario,
      onChanged: (value)=> setState((){
        conGatos = value;
      }),
    );
  }
//--------------------------------CheckBox Vivienda-------------------------------
Widget _viviendaCheck(){
return Card(
  elevation: 2,
  child:   Container( 
    child: Column(
      children: [
        ListTile(
          leading: Icon(
              Icons.home,
              color: terciario,
            ),
          title: Text("Puede vivir en: ",style: TextStyle(color:primario,fontWeight:FontWeight.bold)),
        ), 
        Container(
          child: Row( mainAxisSize: MainAxisSize.min,
            children:<Widget> [
              Expanded(
                child: CheckboxListTile(
                  value: vivApto,
                  onChanged: (value)=> setState((){
                    vivApto=value;//recently added 
                  }),
                  dense: false,
                  activeColor: terciario,
                  title: Text("Apto",style: TextStyle(color:primario,fontWeight:FontWeight.bold)),
                ),
              ),  
              Expanded(
                child: CheckboxListTile(
                  value: vivCasa,
                  onChanged: (value)=> setState((){
                    vivCasa=value;//recently added 
                  }),
                  dense: false,
                  activeColor: terciario,
                  title: Text("Casa",style: TextStyle(color:primario,fontWeight:FontWeight.bold)),
                ),
              ), 
            ],
          ),
        ),   
        Container(
          child: Row( mainAxisSize: MainAxisSize.min,
            children:<Widget> [
              Expanded(
                child: CheckboxListTile(
                  value: vivFinca,
                  onChanged: (value)=> setState((){
                    vivFinca=value;//recently added 
                  }),
                  dense: false,
                  activeColor: terciario,
                  title: Text("Finca",style: TextStyle(color:primario,fontWeight:FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),                           
      ],  
    ),
  ),
);
}
//--------------------------------Condición especial------------------------------
Widget _conEspecial() {
    return SwitchListTile(
      value: especial,
      title: Text('Si la mascota tiene algún tipo de enfermedad (VIF, VLFe u otras) o alguna discapacidad, marca esta casilla.',
      textAlign: TextAlign.justify,
      style: TextStyle(color:primario,fontWeight:FontWeight.bold)),
      activeColor: terciario,
      onChanged: (value)=> setState((){
        especial = value;
      }),
    );
  }
//-------------------------BOTON DEL FINAL ---------------------------------------------------------
  Widget _boton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: primario,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0),),
        elevation: 3,
        textStyle: TextStyle(color: background),
        padding: EdgeInsets.all(0.0)
    ),
    onPressed: (){
      _submit();
    },
    child: Ink(
      decoration:BoxDecoration(
      gradient: LinearGradient(colors: [terciario.withOpacity(0.6), terciario]),
      borderRadius: BorderRadius.circular(20)) ,
      child:Container(
        constraints: BoxConstraints.tightFor(width: _width/2.5, height: _height/18),//tamaño botón
        alignment: Alignment.center,
        child: Text('Publicar',style: TextStyle(fontSize: _large? 19: (_medium? 15: 13), fontWeight: FontWeight.bold, color: Colors.white))
      )
    ),
  );
  }

void _submit() async {
    if ( !formKey.currentState.validate() ) return;
    formKey.currentState.save();
    if ( photo != null &&idController.text!=null&&nombreController.text!=null&&edadController.text!=null) {
      try{
      User madrina=FirebaseAuth.instance.currentUser;
      if (await AnimalsHelper.verificarAnimal(idController.text)==false) {//agregado ???
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Publicando... espera unos segundos."),
      ));
        _photoUrl = await productoProvider.subirImagen(photo);
        await AnimalsHelper.saveAnimal(madrina, idController.text, nombreController.text, disponible,
                          _especieInit,  _sexoInit, edadController.text,_edadCorInit,
                          apJugueton, apAmoroso, apTranquilo, apEducado, apActivo, apDormilon, apTimido,
                          historiaController.text,
                          saludDes, saludVac, saludEste, saludVirales,
                          _tamanoInit, aptoNinos, conPerros,  conGatos,
                          vivCasa, vivApto, vivFinca, especial, _photoUrl); 
       Navigator.of(context).pushReplacementNamed('home');
       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("La mascota se ha publicado exitosamente!"),
                ));   
      }else{
         showAlertDialog(context);
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //       content: Text("La mascota ya existe, deseas actualizarla?"),
        //     ));
      }
     }catch(e){
        showError(e.message);
        print(e);}
    } else {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Para añadir una mascota agrega una foto, id, nombre y edad"),
                )); 
    }
}

showAlertDialog(BuildContext context) {
  Widget cancelButton = ElevatedButton(
    child: Text("Cancelar"),
        style: ElevatedButton.styleFrom(
         primary: primario,
         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0),),
         elevation: 4,
         textStyle: TextStyle(color: background),
         padding: EdgeInsets.all(0.0)
      ),
    onPressed:  () { Navigator.of(context).pop();},
  );
  Widget continueButton = ElevatedButton(
    child: Text("Remplazar",style:TextStyle(fontWeight:FontWeight.bold) ),
    style: ElevatedButton.styleFrom(
         primary: terciario,
         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0),),
         elevation: 4,
         textStyle: TextStyle(color: background),
         padding: EdgeInsets.all(0.0)
      ),
    onPressed:  () async {
      User madrina=FirebaseAuth.instance.currentUser;
      try{
        _photoUrl = await productoProvider.subirImagen(photo);
        await AnimalsHelper.saveAnimal(madrina, idController.text, nombreController.text, disponible,
                          _especieInit,  _sexoInit, edadController.text,_edadCorInit,
                          apJugueton, apAmoroso, apTranquilo, apEducado, apActivo, apDormilon, apTimido,
                          historiaController.text,
                          saludDes, saludVac, saludEste, saludVirales,
                          _tamanoInit, aptoNinos, conPerros,  conGatos,
                          vivCasa, vivApto, vivFinca, especial, _photoUrl); 
       Navigator.of(context).pushReplacementNamed('home');
       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("La mascota se remplazó correctamente"),
                )); 
      }catch(e){
        showError(e.message);
        print(e);}

    },
  );
  AlertDialog alert = AlertDialog(
    title: Text("¡La mascota ya existe!",style:TextStyle(fontWeight:FontWeight.bold) ,),
    content: Text("¿Quieres actualizar o remplazar los datos de la actual?"),
    elevation: 10,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    
    actions: [
      cancelButton,
      continueButton,
    ],
  );
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
//-----------------------BOTON ACTUALIZAR -------------------------------
  Widget _boton2() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: primario,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0),),
        elevation: 3,
        textStyle: TextStyle(color: background),
        padding: EdgeInsets.all(0.0)
    ),
    onPressed: (){
      _submit2();
    },
    child: Ink(
      decoration:BoxDecoration(
      gradient: LinearGradient(colors: [terciario.withOpacity(0.6), terciario]),
      borderRadius: BorderRadius.circular(20)) ,
      child:Container(
        constraints: BoxConstraints.tightFor(width: _width/2.5, height: _height/18),//tamaño botón
        alignment: Alignment.center,
        child: Text('Actualizar',style: TextStyle(fontSize: _large? 19: (_medium? 15: 13), fontWeight: FontWeight.bold, color: Colors.white))
      )
    ),
  );
  }

void _submit2() async {
    if ( !formKey.currentState.validate() ) return;
    formKey.currentState.save();
    if (idController.text!=null) {
      try{
      User madrina=FirebaseAuth.instance.currentUser;
      if (await AnimalsHelper.verificarAnimal(idController.text)==true) {//agregado ???
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Actualizando... espera unos segundos."),
      ));
        await AnimalsHelper.actualizarMascota(madrina, idController.text, nombreController.text, disponible,
                          _especieInit,  _sexoInit, edadController.text,_edadCorInit,
                          apJugueton, apAmoroso, apTranquilo, apEducado, apActivo, apDormilon, apTimido,
                          historiaController.text,
                          saludDes, saludVac, saludEste, saludVirales,
                          _tamanoInit, aptoNinos, conPerros,  conGatos,
                          vivCasa, vivApto, vivFinca, especial); 
       Navigator.of(context).pushReplacementNamed('home');
       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("La mascota se ha actualizado"),
                ));   
      }else{
         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("El ID de esta mascota no existe, verifica."),
                )); 
      }
     }catch(e){
        showError(e.message);
        print(e);}
    } else {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Para actualizar una mascota se necesita el ID."),
                )); 
    }
}

_mostrarFoto() {
    if (_photoUrl != null) {
      return Container();
    } else {
      if( photo != null ){
        return Image.file(
          photo,
          fit: BoxFit.cover,
          height: 300.0,
        );
      }if(photo==null){
      return Image.asset(
        "assets/img/no_image2.jpg"
        );
      }
    }
  }

_seleccionarFoto() async {
    _procesarImagen( ImageSource.gallery );
}
   
_tomarFoto() async {
    _procesarImagen( ImageSource.camera  );
}

_procesarImagen(ImageSource origin) async {
    final _picker = ImagePicker();
 
    final pickedFile = await _picker.getImage(
      source: origin,
      imageQuality: 40
    );
    
    photo = File(pickedFile.path);
 
    if (photo != null) {
      _photoUrl = null;
    }
 
    setState(() {});
  }

showError(String errormessage){
   showDialog(
    context: context,
    builder: (BuildContext context){
      return AlertDialog(
        title: Text('ERROR'),
        content: Text(errormessage),
        actions: <Widget>[
          // ignore: deprecated_member_use
          FlatButton(
            
            onPressed: (){
              Navigator.of(context).pop();
            }, 
          child: Text('OK'))
        ],
      );
    }
   );
  }

}