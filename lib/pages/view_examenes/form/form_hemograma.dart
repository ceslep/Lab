// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

class FormHemograma extends StatefulWidget {
  final List<Map<String, dynamic>> hemograma;
  const FormHemograma({super.key, required this.hemograma});

  @override
  State<FormHemograma> createState() => _FormHemogramaState();
}

class _FormHemogramaState extends State<FormHemograma> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _wbcController = TextEditingController();
  final TextEditingController _lymNumberController = TextEditingController();
  final TextEditingController _midNumberController = TextEditingController();
  final TextEditingController _graNumberController = TextEditingController();
  final TextEditingController _lymPercentController = TextEditingController();
  final TextEditingController _midPercentController = TextEditingController();
  final TextEditingController _graPercentController = TextEditingController();
  final TextEditingController _rbcController = TextEditingController();
  final TextEditingController _hgbController = TextEditingController();
  final TextEditingController _mchcController = TextEditingController();
  final TextEditingController _mchController = TextEditingController();
  final TextEditingController _mcvController = TextEditingController();
  final TextEditingController _rdwCvController = TextEditingController();
  final TextEditingController _rdwSdController = TextEditingController();
  final TextEditingController _hctController = TextEditingController();
  final TextEditingController _pltController = TextEditingController();
  final TextEditingController _mpvController = TextEditingController();
  final TextEditingController _pdwController = TextEditingController();
  final TextEditingController _pctController = TextEditingController();
  final TextEditingController _pLcrController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.hemograma.isNotEmpty) {
      _wbcController.text = widget.hemograma[0]['WBC'].toString();
      _lymNumberController.text = widget.hemograma[1]['LYM#'].toString();
      _midNumberController.text = widget.hemograma[2]['MID#'].toString();
      _graNumberController.text = widget.hemograma[3]['GRA#'].toString();
      _lymPercentController.text = widget.hemograma[4]['LYM%'].toString();
      _midPercentController.text = widget.hemograma[5]['MID%'].toString();
      _graPercentController.text = widget.hemograma[6]['GRA%'].toString();
      _rbcController.text = widget.hemograma[7]['RBC'].toString();
      _hgbController.text = widget.hemograma[8]['HGB'].toString();
      _mchcController.text = widget.hemograma[9]['MCHC'].toString();
      _mchController.text = widget.hemograma[10]['MCH'].toString();
      _mcvController.text = widget.hemograma[11]['MCV'].toString();
      _rdwCvController.text = widget.hemograma[12]['RDW-CV'].toString();
      _rdwSdController.text = widget.hemograma[13]['RDW-SD'].toString();
      _hctController.text = widget.hemograma[14]['HCT'].toString();
      _pltController.text = widget.hemograma[15]['PLT'].toString();
      _mpvController.text = widget.hemograma[16]['MPV'].toString();
      _pdwController.text = widget.hemograma[17]['PDW'].toString();
      _pctController.text = widget.hemograma[18]['PCT'].toString();
      _pLcrController.text = widget.hemograma[19]['P-LCR'].toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildTextField(
              'WBC',
              _wbcController,
            ),
            _buildTextField(
              'LYM#',
              _lymNumberController,
            ),
            _buildTextField(
              'MID#',
              _midNumberController,
            ),
            _buildTextField(
              'GRA#',
              _graNumberController,
            ),
            _buildTextField(
              'LYM%',
              _lymPercentController,
            ),
            _buildTextField(
              'MID%',
              _midPercentController,
            ),
            _buildTextField(
              'GRA%',
              _graPercentController,
            ),
            _buildTextField(
              'RBC',
              _rbcController,
            ),
            _buildTextField(
              'HGB',
              _hgbController,
            ),
            _buildTextField(
              'MCHC',
              _mchcController,
            ),
            _buildTextField(
              'MCH',
              _mchController,
            ),
            _buildTextField(
              'MCV',
              _mcvController,
            ),
            _buildTextField(
              'RDW-CV',
              _rdwCvController,
            ),
            _buildTextField(
              'RDW-SD',
              _rdwSdController,
            ),
            _buildTextField(
              'HCT',
              _hctController,
            ),
            _buildTextField(
              'PLT',
              _pltController,
            ),
            _buildTextField(
              'MPV',
              _mpvController,
            ),
            _buildTextField(
              'PDW',
              _pdwController,
            ),
            _buildTextField(
              'PCT',
              _pctController,
            ),
            _buildTextField(
              'P-LCR',
              _pLcrController,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String labelText, TextEditingController controller) {
    return TextFormField(
      textAlign: TextAlign.end,
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(
          color: Colors.red,
        ),
      ),
    );
  }
}
