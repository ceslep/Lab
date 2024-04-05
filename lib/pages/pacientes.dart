import 'package:flutter/material.dart';

class Pacientes extends StatefulWidget {
  const Pacientes({super.key});

  @override
  State<Pacientes> createState() => _PacientesState();
}

class _PacientesState extends State<Pacientes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
        title: const Text(
          'Crear Paciente',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.save,
                color: Color.fromARGB(255, 112, 117, 251),
              ),
            ),
          ),
        ],
      ),
      body: const Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(18.0),
            child: TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Ingrese una identificación válida',
                  label: Text('Identificación')),
              keyboardType: TextInputType.numberWithOptions(),
            ),
          )
        ],
      ),
    );
  }
}
