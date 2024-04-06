// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lab/models/paciente.dart';
import 'package:lab/providers/url_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class CrearExamen extends StatefulWidget {
  const CrearExamen({super.key});

  @override
  State<CrearExamen> createState() => _CrearExamenState();
}

class _CrearExamenState extends State<CrearExamen> {
  Paciente paciente = Paciente();
  Uri url = Uri();

  final TextEditingController _identificacionController =
      TextEditingController();
  bool buscando = false;
  Future<Paciente> getInfoPaciente() async {
    late Paciente paciente;
    final urlProvider = Provider.of<UrlProvider>(context, listen: false);
    Uri url = Uri.parse('${urlProvider.url}getPaciente.php');
    final bodyData = json.encode({
      'identificacion': _identificacionController.text,
    });
    final response = await http.post(url, body: bodyData);
    if (response.statusCode == 200) {
      final dynamic datosPaciente = json.decode(response.body);
      if (datosPaciente['msg']) {
        paciente = Paciente.fromJson(datosPaciente['data']);
      }
    } else {}
    return paciente;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Crear Exámenes'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 0.8 * MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      onChanged: (value) {
                        if (value.length < 3) {
                          setState(() => paciente = Paciente());
                        }
                      },
                      autofocus: true,
                      controller: _identificacionController,
                      decoration: const InputDecoration(
                          labelText: 'Paciente',
                          hintText: 'Identificación del paciente'),
                    ),
                  ),
                ),
                SizedBox(
                  width: 0.2 * MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                      onPressed: () async {
                        setState(() => buscando = !buscando);
                        paciente = await getInfoPaciente();
                        setState(() => buscando = !buscando);
                      },
                      icon: !buscando
                          ? const Icon(Icons.search)
                          : const SizedBox(
                              width: 12,
                              height: 12,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                            ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Card(
                child: paciente.nombres != null
                    ? ListTile(
                        title:
                            Text('${paciente.nombres} ${paciente.apellidos}'),
                      )
                    : const SizedBox(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
