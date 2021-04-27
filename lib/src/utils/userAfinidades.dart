import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AfinidadesHelper{

  static FirebaseFirestore _db =FirebaseFirestore.instance;

  static saveAfinidades(String user,String _personalidadR ,String _estiloVidaR,
                        String _aficionesR ,String _viviendaR ,String _patioR ,String _familiaR ,String _ninosR,
                        String _mascotasactR ,String _mascotasactEspR ,String _mascotaantR,String _especieR ,
                        String _sexoR ,String _tamanoR ,String _rangoEdadR ,bool especial  ) async{

    Map<String,dynamic> afin={
      "usuario":user,
      "personalidad":_personalidadR ,
      "estilo":_estiloVidaR,
      "aficiones":_aficionesR ,
      "vivienda":_viviendaR ,
      "patio":_patioR ,
      "familia":_familiaR ,
      "ninos":_ninosR,
      "mascAct":_mascotasactR ,
      "mascActEsp":_mascotasactEspR ,
      "mascAnt": _mascotaantR,
      "especieMas":_especieR ,
      "sexoMas":_sexoR ,
      "tamanoMas":_tamanoR ,
      "edadMas":_rangoEdadR ,
      "Especial":especial 
    };

  final afinidadesRef =_db.collection("Afinidades").doc(user);//uid o email

  if ((await afinidadesRef.get()).exists) {
    await afinidadesRef.update({
      
      "personalidad":_personalidadR ,
      "estilo":_estiloVidaR,
      "aficiones":_aficionesR ,
      "vivienda":_viviendaR ,
      "patio":_patioR ,
      "familia":_familiaR ,
      "ninos":_ninosR,
      "mascAct":_mascotasactR ,
      "mascActEsp":_mascotasactEspR ,
      "mascAnt": _mascotaantR,
      "especieMas":_especieR ,
      "sexoMas":_sexoR ,
      "tamanoMas":_tamanoR ,
      "edadMas":_rangoEdadR ,
      "Especial":especial 
    });
    }
    else{
      await afinidadesRef.set(afin);
    }  
  }

  static addAfinidades(String user,List list)async{
      Map<String,dynamic> addAfin={
      "afin1":list[0],
      "afin2":list[1]
      };
    final addAfinRef =_db.collection("Afinidades").doc(user);//uid o email
      if ((await addAfinRef.get()).exists) {
    await addAfinRef.update({
      "afin1":list[0],
      "afin2":list[1],
      "afin3":list[2],
      "afin4":list[3]
      });}
      else{await addAfinRef.set(addAfin);}
  }


}