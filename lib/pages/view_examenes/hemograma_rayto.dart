import 'package:flutter/material.dart';
import 'package:lab/api/get_info_pacientes.dart';
import 'package:lab/models/hemograma_rayto.dart';

class ViewHemogramaRayto extends StatefulWidget {
  final HemogramaRayto hemograma;
  const ViewHemogramaRayto({super.key, required this.hemograma});

  @override
  State<ViewHemogramaRayto> createState() => _ViewHemogramaRaytoState();
}

class _ViewHemogramaRaytoState extends State<ViewHemogramaRayto> {
  final TextEditingController _hemoController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _hemoController.text = widget.hemograma.sistematizado!;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _hemoController,
      maxLines: 30,
    );
  }
}
