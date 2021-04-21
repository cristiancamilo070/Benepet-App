// To parse this JSON data, do
//
//     final productoModel = productoModelFromJson(jsonString);

import 'dart:convert';

AnimalesModel animalesModelFromJson(String str) => AnimalesModel.fromJson(json.decode(str));

String animalesModelToJson(AnimalesModel data) => json.encode(data.toJson());

class AnimalesModel {

    String id;
    String titulo;
    double valor;
    bool disponible;
    String fotoUrl;
    bool aptoNinos;
    bool conPerros;
    bool conGatos;
    bool especial;
    bool ap1;


    AnimalesModel({
        this.id,
        this.titulo = '',
        this.valor  = 0.0,
        this.disponible = true,
        this.fotoUrl,

        this.aptoNinos = true,
        this.conPerros = true,
        this.conGatos = true,
        this.especial = false,
        this.ap1=false,
    });

    factory AnimalesModel.fromJson(Map<String, dynamic> json) => new AnimalesModel(
        id         : json["id"],
        titulo     : json["titulo"],
        valor      : json["valor"],
        disponible : json["disponible"],
        fotoUrl    : json["fotoUrl"],
        aptoNinos  : json["aptoNinos"],
        conPerros : json["conPerros"],
        conGatos : json["conGatos"],
        especial : json["especial"],
        ap1: json["ap1"],
    );

    Map<String, dynamic> toJson() => {
        // "id"         : id,
        "titulo"     : titulo,
        "valor"      : valor,
        "disponible" : disponible,
        "fotoUrl"    : fotoUrl,
        "aptoNinos"  :aptoNinos,
        "conPerros" : conPerros,
        "conGatos" : conGatos,
        "especial" : especial,
        "ap1":ap1,
    };
}
