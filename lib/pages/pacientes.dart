import 'package:flutter/material.dart';

class Pacientes extends StatefulWidget {
  const Pacientes({super.key});

  @override
  State<Pacientes> createState() => _PacientesState();
}

class _PacientesState extends State<Pacientes> {
  final TextEditingController _identificacionController =
      TextEditingController();
  final TextEditingController _nombresController = TextEditingController();
  final TextEditingController _apellidosController = TextEditingController();
  final TextEditingController _telefonoController = TextEditingController();
  final TextEditingController _correoController = TextEditingController();

  String _genero = '';

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

  @override
  void initState() {
    super.initState();
    _itemsGenero = getGeneroItems(genero);
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
              onPressed: () {},
              icon: const Icon(
                Icons.save,
                color: Colors.lightBlueAccent,
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
              ),
              const SizedBox(height: 18.0),
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
                  onPressed: () {},
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Guardar",
                      ),
                      Icon(Icons.save)
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
}
