// To parse this JSON data, do
//
//     final paciente = pacienteFromJson(jsonString);

import 'dart:convert';

Paciente pacienteFromJson(String str) => Paciente.fromJson(json.decode(str));

String pacienteToJson(Paciente data) => json.encode(data.toJson());

class Paciente {
  final String? id;
  final String? identificacion;
  final String? nombres;
  final String? apellidos;
  final String? fecnac;
  final String? telefono;
  final String? correo;
  final String? genero;
  final String? entidad;

  Paciente({
    this.id,
    this.identificacion,
    this.nombres,
    this.apellidos,
    this.fecnac,
    this.telefono,
    this.correo,
    this.genero,
    this.entidad,
  });

  factory Paciente.fromJson(Map<String, dynamic> json) => Paciente(
        id: json["id"].toString(),
        identificacion: json["identificacion"].toString(),
        nombres: json["nombres"].toString(),
        apellidos: json["apellidos"].toString(),
        fecnac: json["fecnac"].toString(),
        telefono: json["telefono"].toString(),
        correo: json["correo"].toString(),
        genero: json["genero"].toString(),
        entidad: json["entidad"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "identificacion": identificacion,
        "nombres": nombres,
        "apellidos": apellidos,
        "fecnac": fecnac,
        "telefono": telefono,
        "correo": correo,
        "genero": genero,
        "entidad": entidad,
      };
}
