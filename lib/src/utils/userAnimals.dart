import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime_type/mime_type.dart';


class AnimalsHelper{

  static FirebaseFirestore _db =FirebaseFirestore.instance;

  static saveAnimal(User madrina,String idMascota,String nombre,
                  bool disponible,String especie, String sexo, String edad,
                  bool apJugueton,bool apAmoroso,bool apTranquilo,bool apEducado,bool apActivo,bool apDormilon,bool apTimido,
                  String historia,String _peloInit,String _colorPeloInit,
                  bool saludDes,bool saludVac,bool saludEste,bool saludVirales,
                  String tamano, bool aptoNinos,bool conPerros, bool conGatos,
                  bool vivCasa, bool vivApto, bool vivFinca,
                  bool especial,String _photoUrl) async{

    Map<String,dynamic> mascotaData={
      "usuario":madrina.email,
      "id": idMascota,
      "nombre": nombre,
      "disponible":disponible,
      "especie": especie,
      "sexo": sexo,
      "edad":edad,
      
      "jugueton": apJugueton,
      "amoroso": apAmoroso,
      "tranquilo": apTranquilo,
      "educado": apEducado,
      "activo": apActivo,
      "dormilon": apDormilon,
      "timido": apTimido,

      "historia":historia,

      "desparasitado": saludDes,
      "vacunado": saludVac,
      "esterilizado": saludEste,
      "virales": saludVirales,
      
      "tamano": tamano,
      
      "ninos": aptoNinos,
      "conperros": conPerros,
      "congatos": conGatos,

      "fecha_publicacion":madrina.metadata.creationTime.millisecondsSinceEpoch,//no es necesario en mascotas_admin
      
      "casa": vivCasa,
      "apto": vivApto,
      "finca": vivFinca,
      "especial": especial,
      "url": _photoUrl
    };

  final mascotaRef =_db.collection("Mascotas").doc(idMascota);//uid o email

  if ((await mascotaRef.get()).exists) {
    await mascotaRef.update({
      "id": idMascota,
      "nombre": nombre,
      "disponible":disponible,
      "especie": especie,
      "sexo": sexo,
      "edad":edad,
      
      "jugueton": apJugueton,
      "amoroso": apAmoroso,
      "tranquilo": apTranquilo,
      "educado": apEducado,
      "activo": apActivo,
      "dormilon": apDormilon,
      "timido": apTimido,

      "historia":historia,

      "desparasitado": saludDes,
      "vacunado": saludVac,
      "esterilizado": saludEste,
      "virales": saludVirales,
      
      "tamano": tamano,
      
      "ninos": aptoNinos,
      "conperros": conPerros,
      "congatos": conGatos,
      
      "casa": vivCasa,
      "apto": vivApto,
      "finca": vivFinca,
      "especial": especial,
      "url": _photoUrl
    });
    }
    else{
      await mascotaRef.set(mascotaData);
    }  
  }


  Future<String> subirImagen( File imagen ) async {

  final url = Uri.parse('https://api.cloudinary.com/v1_1/cristiancruz070/image/upload?upload_preset=jmoz17ru');
  final mimeType = mime(imagen.path).split('/'); //image/jpeg

  final imageUploadRequest = http.MultipartRequest(
    'POST',
    url
  );

  final file = await http.MultipartFile.fromPath(
    'file', 
    imagen.path,
    contentType: MediaType( mimeType[0], mimeType[1] )
  );

  imageUploadRequest.files.add(file);


  final streamResponse = await imageUploadRequest.send();
  final resp = await http.Response.fromStream(streamResponse);

  if ( resp.statusCode != 200 && resp.statusCode != 201 ) {
    print('Algo salio mal');
    print( resp.body );
    return null;
  }

  final respData = json.decode(resp.body);
  print( respData);

  return respData['secure_url'];


  }  
}