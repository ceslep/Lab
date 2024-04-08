import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lab/models/paciente.dart';
import 'package:lab/providers/url_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

Future<Paciente> getInfoPaciente(
  BuildContext context, {
  String identificacion = '',
}) async {
  final urlProvider = Provider.of<UrlProvider>(context, listen: false);
  Uri url = Uri.parse('${urlProvider.url}getPaciente.php');
  final bodyData = json.encode({
    'identificacion': identificacion,
  });
  try {
    final response = await http.post(url, body: bodyData);
    if (response.statusCode == 200) {
      final decodedResponse = utf8.decode(response.bodyBytes);
      final dynamic datosPaciente = json.decode(decodedResponse);
      if (datosPaciente['msg']) {
        return Paciente.fromJson(datosPaciente['data']);
      }
    } else {}
    return Paciente();
  } catch (e) {
    return Paciente(identificacion: 'Error');
  }
}

Future<List<Map<String, dynamic>>> getPacientes(
  BuildContext context,
) async {
  final urlProvider = Provider.of<UrlProvider>(context, listen: false);
  Uri url = Uri.parse('${urlProvider.url}getPacientes.php');

  final response = await http.get(url);
  if (response.statusCode == 200) {
    var datosPaciente = json.decode(response.body);
    return datosPaciente.cast<Map<String, dynamic>>();
  } else {
    return [];
  }
}
