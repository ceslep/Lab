// ignore_for_file: avoid_print, library_private_types_in_public_api

import 'package:flutter/material.dart';

abstract class HemogramaState {
  String getTextFieldValue(TextEditingController controller);
}

class FormHemograma extends StatefulWidget {
  final void Function(_FormHemogramaState) onFormStateChange;
  final List<Map<String, dynamic>> hemograma;

  const FormHemograma(
      {super.key, required this.hemograma, required this.onFormStateChange});

  @override
  State<FormHemograma> createState() => _FormHemogramaState();
}

class _FormHemogramaState extends State<FormHemograma> {
  final _formKey = GlobalKey<FormState>();
  String fsistematizado = '';
  TextEditingController wbcController = TextEditingController();
  TextEditingController lymNumberController = TextEditingController();
  TextEditingController midNumberController = TextEditingController();
  TextEditingController graNumberController = TextEditingController();
  TextEditingController lymPercentController = TextEditingController();
  TextEditingController midPercentController = TextEditingController();
  TextEditingController graPercentController = TextEditingController();
  TextEditingController rbcController = TextEditingController();
  TextEditingController hgbController = TextEditingController();
  TextEditingController mchcController = TextEditingController();
  TextEditingController mchController = TextEditingController();
  TextEditingController mcvController = TextEditingController();
  TextEditingController rdwCvController = TextEditingController();
  TextEditingController rdwSdController = TextEditingController();
  TextEditingController hctController = TextEditingController();
  TextEditingController pltController = TextEditingController();
  TextEditingController mpvController = TextEditingController();
  TextEditingController pdwController = TextEditingController();
  TextEditingController pctController = TextEditingController();
  TextEditingController pLcrController = TextEditingController();

  String getTextFieldValue(TextEditingController controller) {
    return controller.text;
  }

  @override
  void initState() {
    super.initState();
    if (widget.hemograma.isNotEmpty) {
      wbcController.text = widget.hemograma[0]['WBC'].toString();
      lymNumberController.text = widget.hemograma[1]['LYM#'].toString();
      midNumberController.text = widget.hemograma[2]['MID#'].toString();
      graNumberController.text = widget.hemograma[3]['GRA#'].toString();
      lymPercentController.text = widget.hemograma[4]['LYM%'].toString();
      midPercentController.text = widget.hemograma[5]['MID%'].toString();
      graPercentController.text = widget.hemograma[6]['GRA%'].toString();
      rbcController.text = widget.hemograma[7]['RBC'].toString();
      hgbController.text = widget.hemograma[8]['HGB'].toString();
      mchcController.text = widget.hemograma[9]['MCHC'].toString();
      mchController.text = widget.hemograma[10]['MCH'].toString();
      mcvController.text = widget.hemograma[11]['MCV'].toString();
      rdwCvController.text = widget.hemograma[12]['RDW-CV'].toString();
      rdwSdController.text = widget.hemograma[13]['RDW-SD'].toString();
      hctController.text = widget.hemograma[14]['HCT'].toString();
      pltController.text = widget.hemograma[15]['PLT'].toString();
      mpvController.text = widget.hemograma[16]['MPV'].toString();
      pdwController.text = widget.hemograma[17]['PDW'].toString();
      pctController.text = widget.hemograma[18]['PCT'].toString();
      pLcrController.text = widget.hemograma[19]['P-LCR'].toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      onChanged: () {},
      key: _formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildTextField(
              'WBC',
              wbcController,
            ),
            _buildTextField(
              'LYM#',
              lymNumberController,
            ),
            _buildTextField(
              'MID#',
              midNumberController,
            ),
            _buildTextField(
              'GRA#',
              graNumberController,
            ),
            _buildTextField(
              'LYM%',
              lymPercentController,
            ),
            _buildTextField(
              'MID%',
              midPercentController,
            ),
            _buildTextField(
              'GRA%',
              graPercentController,
            ),
            _buildTextField(
              'RBC',
              rbcController,
            ),
            _buildTextField(
              'HGB',
              hgbController,
            ),
            _buildTextField(
              'MCHC',
              mchcController,
            ),
            _buildTextField(
              'MCH',
              mchController,
            ),
            _buildTextField(
              'MCV',
              mcvController,
            ),
            _buildTextField(
              'RDW-CV',
              rdwCvController,
            ),
            _buildTextField(
              'RDW-SD',
              rdwSdController,
            ),
            _buildTextField(
              'HCT',
              hctController,
            ),
            _buildTextField(
              'PLT',
              pltController,
            ),
            _buildTextField(
              'MPV',
              mpvController,
            ),
            _buildTextField(
              'PDW',
              pdwController,
            ),
            _buildTextField(
              'PCT',
              pctController,
            ),
            _buildTextField(
              'P-LCR',
              pLcrController,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String labelText, TextEditingController controller) {
    return TextFormField(
      onChanged: (value) {
        setState(() {
          widget.onFormStateChange(this);
        });
      },
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
