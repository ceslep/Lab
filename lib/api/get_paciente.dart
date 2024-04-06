import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lab/models/paciente.dart';
import 'package:lab/providers/url_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

Future<Paciente> getInfoPaciente(BuildContext context,
    {String identificacion = ''}) async {
  final urlProvider = Provider.of<UrlProvider>(context, listen: false);
  Uri url = Uri.parse('${urlProvider.url}getPaciente.php');
  final bodyData = json.encode({
    'identificacion': identificacion,
  });
  final response = await http.post(url, body: bodyData);
  if (response.statusCode == 200) {
    final dynamic datosPaciente = json.decode(response.body);
    if (datosPaciente['msg']) {
      return Paciente.fromJson(datosPaciente['data']);
    }
  } else {}
  return Paciente();
}
