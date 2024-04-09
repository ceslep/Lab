import 'dart:convert';

Examenes examenesFromJson(String str) => Examenes.fromJson(json.decode(str));

String examenesToJson(Examenes data) => json.encode(data.toJson());

class Examenes {
  final String ind;
  final String citasind;
  final String codexamen;
  final String identificacion;
  final String fecha;
  final String realizado;
  final String cas;
  final String entidad;
  final String indice;
  final String departamento;
  final String horaRegistro;
  final String exportar;
  final String pyp;
  final String doctor;
  final String bacteriologo;
  final String examen;

  Examenes({
    required this.ind,
    required this.citasind,
    required this.codexamen,
    required this.identificacion,
    required this.fecha,
    required this.realizado,
    required this.cas,
    required this.entidad,
    required this.indice,
    required this.departamento,
    required this.horaRegistro,
    required this.exportar,
    required this.pyp,
    required this.doctor,
    required this.bacteriologo,
    required this.examen,
  });

  factory Examenes.fromJson(Map<String, dynamic> json) => Examenes(
        ind: json["ind"].toString(),
        citasind: json["citasind"].toString(),
        codexamen: json["codexamen"].toString(),
        identificacion: json["identificacion"].toString(),
        fecha: json["fecha"].toString(),
        realizado: json["realizado"].toString(),
        cas: json["cas"].toString(),
        entidad: json["entidad"].toString(),
        indice: json["indice"].toString(),
        departamento: json["departamento"].toString(),
        horaRegistro: json["hora_registro"].toString(),
        exportar: json["exportar"].toString(),
        pyp: json["pyp"].toString(),
        doctor: json["doctor"].toString(),
        bacteriologo: json["bacteriologo"].toString(),
        examen: json["examen"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "ind": ind,
        "citasind": citasind,
        "codexamen": codexamen,
        "identificacion": identificacion,
        "fecha": fecha,
        "realizado": realizado,
        "cas": cas,
        "entidad": entidad,
        "indice": indice,
        "departamento": departamento,
        "hora_registro": horaRegistro,
        "exportar": exportar,
        "pyp": pyp,
        "doctor": doctor,
        "bacteriologo": bacteriologo,
        "examen": examen
      };
}
