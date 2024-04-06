// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:lab/api/get_paciente.dart';
import 'package:lab/models/paciente.dart';
import 'package:lab/providers/url_provider.dart';
import 'package:lab/widgets/toastmsg.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class Pacientes extends StatefulWidget {
  const Pacientes({super.key});

  @override
  State<Pacientes> createState() => _PacientesState();
}

class _PacientesState extends State<Pacientes> {
  bool guardando = false;
  FToast fToast = FToast();
  final TextEditingController _identificacionController =
      TextEditingController();
  final TextEditingController _nombresController = TextEditingController();
  final TextEditingController _apellidosController = TextEditingController();
  final TextEditingController _telefonoController = TextEditingController();
  final TextEditingController _correoController = TextEditingController();
  final TextEditingController _fecnacController = TextEditingController(
      text: DateFormat('yyyy-MM-dd').format(DateTime.now()));

  String _genero = '';
  String fecha = DateFormat('yyyy-MM-dd').format(DateTime.now());

  List<String> genero = [
    'Seleccione el genero del paciente',
    'Masculino',
    'Femenino',
    'Otro'
  ];

  List<DropdownMenuItem> _itemsGenero = [];

  List<DropdownMenuItem<String>> getGeneroItems(List<String> genero) {
    List<DropdownMenuItem<String>> items = [];
    for (String generoItem in genero) {
      items.add(
        DropdownMenuItem(
          enabled: !generoItem.contains('Seleccione'),
          value: generoItem.contains('Seleccione') ? '' : generoItem,
          child: Text(generoItem),
        ),
      );
    }
    return items;
  }

  final focusNode = FocusNode();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1930),
      lastDate: DateTime(2225),
    );
    if (pickedDate != null) {
      _fecnacController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      fecha = _fecnacController.text;
    }
  }

  @override
  void initState() {
    super.initState();
    fToast.init(context);
    _itemsGenero = getGeneroItems(genero);
    focusNode.addListener(() async {
      if (!focusNode.hasFocus) {
        Paciente paciente = await getInfoPaciente(context,
            identificacion: _identificacionController.text);
        print(paciente.toJson());
        if (paciente.identificacion != null) {
          _nombresController.text = paciente.nombres!;
          _apellidosController.text = paciente.apellidos!;
          _fecnacController.text = paciente.fecnac!;
          _genero = paciente.genero!;
          _telefonoController.text = paciente.telefono!;
          _correoController.text = paciente.correo!;
          setState(() {});
        }
      }
    });
  }

  Future<bool> guardarPaciente() async {
    Paciente paciente = Paciente(
        id: NativeRuntime.buildId.toString(),
        identificacion: _identificacionController.text,
        nombres: _nombresController.text,
        apellidos: _apellidosController.text,
        fecnac: _fecnacController.text,
        genero: _genero,
        telefono: _telefonoController.text,
        correo: _correoController.text);
    final urlProvider = Provider.of<UrlProvider>(context, listen: false);
    Uri url = Uri.parse('${urlProvider.url}savePaciente.php');
    final bodyData = json.encode(paciente.toJson());
    try {
      final response = await http.post(url, body: bodyData);
      if (response.statusCode == 200) {
        final dynamic datos = json.decode(response.body);
        return datos['msg'];
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> showToastB(
    String message, {
    ToastGravity gravity = ToastGravity.TOP,
    int milliseconds = 1000,
    Color bacgroundColor = Colors.white,
  }) async {
    final toast = Toastmsg(
      message: message,
      toast: fToast,
      backgroundColor: bacgroundColor,
      frontColor: Colors.black,
    );

    // Await a Timer to simulate async behavior (optional)
    await Future.delayed(Duration(milliseconds: milliseconds));

    // Show the toast directly inside the future
    fToast.showToast(
      child: toast,
      gravity: gravity,
      toastDuration: const Duration(seconds: 2),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text(
          'Crear Paciente',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: guardaPaciente,
              icon: !guardando
                  ? const Icon(
                      Icons.save,
                      color: Colors.lightGreenAccent,
                    )
                  : const SizedBox(
                      width: 12,
                      height: 12,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                focusNode: focusNode,
                autofocus: true,
                controller: _identificacionController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Ingrese una identificación válida',
                  label: Text(
                    'Identificación',
                    style: TextStyle(color: Colors.green),
                  ),
                ),
                keyboardType: const TextInputType.numberWithOptions(),
                textCapitalization: TextCapitalization.characters,
              ),
              const SizedBox(height: 18.0),
              TextField(
                controller: _nombresController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Nombres del paciente',
                  label: Text(
                    'Nombres',
                    style: TextStyle(color: Colors.green),
                  ),
                ),
                textCapitalization: TextCapitalization.characters,
              ),
              const SizedBox(height: 18.0),
              TextField(
                controller: _apellidosController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Apellidos del paciente',
                  label: Text(
                    'Apellidos',
                    style: TextStyle(color: Colors.green),
                  ),
                ),
                textCapitalization: TextCapitalization.characters,
              ),
              const SizedBox(height: 18.0),
              Padding(
                padding: const EdgeInsets.all(0),
                child: _buildDatePicker(),
              ),
              const SizedBox(
                height: 18.0,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: DropdownButton(
                  items: _itemsGenero,
                  value: _genero,
                  onChanged: (value) {
                    setState(() {
                      _genero = value!;
                    });
                  },
                ),
              ),
              const SizedBox(height: 18.0),
              TextField(
                controller: _telefonoController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'telefono del paciente',
                  label: Text(
                    'Teléfono',
                    style: TextStyle(color: Colors.green),
                  ),
                ),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 18.0),
              TextField(
                controller: _correoController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Correo del paciente',
                  label: Text(
                    'Correo',
                    style: TextStyle(color: Colors.green),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(
                height: 36.0,
              ),
              SizedBox(
                width: 0.65 * MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: guardaPaciente,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Guardar",
                      ),
                      !guardando
                          ? const Icon(Icons.save)
                          : const SizedBox(
                              width: 12,
                              height: 12,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void guardaPaciente() async {
    setState(() => guardando = !guardando);
    bool save = await guardarPaciente();
    if (save) {
      await showToastB('Paciente Registrado Correctamente',
          bacgroundColor: Colors.lightGreen);
      Navigator.pop(context);
    } else {
      showToastB('Ha ocurido un error. Intentelo nuevamente más tarde.');
    }
    setState(() => guardando = !guardando);
  }

  Widget _buildDatePicker() {
    return Row(
      children: <Widget>[
        Expanded(
          child: TextField(
            controller: _fecnacController,
            readOnly: true,
            decoration: const InputDecoration(
                labelText: 'Fecha de Nacimiento',
                border: OutlineInputBorder(),
                labelStyle: TextStyle(color: Colors.green)),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.calendar_today),
          onPressed: () => _selectDate(context),
        ),
      ],
    );
  }
}
