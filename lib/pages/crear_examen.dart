import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CrearExamen extends StatefulWidget {
  const CrearExamen({super.key});

  @override
  State<CrearExamen> createState() => _CrearExamenState();
}

class _CrearExamenState extends State<CrearExamen> {
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
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: InputDecoration(
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
                      onPressed: () {},
                      icon: const Icon(Icons.search),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
