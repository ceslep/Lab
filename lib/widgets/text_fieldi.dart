import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UpperCaseFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

class LowerCaseFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toLowerCase(),
      selection: newValue.selection,
    );
  }
}

extension StringExtension on String {
  String onlyNumbers() {
    return replaceAll(RegExp('[^0-9]'), '');
  }
}

bool validarCorreo(String correo) {
  if (correo == '') return false;
  final RegExp emailRegExp = RegExp(
    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
    caseSensitive: false,
    multiLine: false,
  );
  return emailRegExp.hasMatch(correo);
}

class TextFieldi extends StatefulWidget {
  final FocusNode focusNode;
  final TextEditingController controller;
  final int count;
  final Color color;
  final String hintText;
  final String field;
  final Function(String) onChanged;
  final TextCapitalization textCapitalization;
  final TextInputType keyboardType;
  final bool digitsOnly;
  final bool isCorreo;
  const TextFieldi({
    super.key,
    required this.focusNode,
    required this.controller,
    required this.count,
    required this.color,
    required this.hintText,
    required this.field,
    required this.onChanged,
    required this.textCapitalization,
    required this.keyboardType,
    required this.digitsOnly,
    this.isCorreo = false,
  });

  @override
  State<TextFieldi> createState() => _TextFieldiState();
}

class _TextFieldiState extends State<TextFieldi> {
  int fieldiCount = 0;
  bool correoValido = false;
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) {
        if (widget.isCorreo) {
          correoValido = validarCorreo(widget.controller.text);
        }
        setState(() => fieldiCount = value.length);
        widget.onChanged(value);
      },
      focusNode: widget.focusNode,
      autofocus: true,
      controller: widget.controller,
      inputFormatters: [
        widget.digitsOnly
            ? FilteringTextInputFormatter.digitsOnly
            : !widget.isCorreo
                ? UpperCaseFormatter()
                : LowerCaseFormatter(),
      ],
      decoration: InputDecoration(
        error: widget.isCorreo
            ? !correoValido
                ? const Text(
                    'Correo  inválido',
                    style: TextStyle(color: Colors.red, fontSize: 10),
                  )
                : const Text(
                    'Correo Válido',
                    style: TextStyle(color: Colors.blue, fontSize: 10),
                  )
            : null,
        border: const OutlineInputBorder(),
        hintText: widget.hintText,
        label: Text(
          widget.field,
          style: TextStyle(color: widget.color),
        ),
        counter: Text(
          widget.count > 0
              ? '${fieldiCount.toString()} de Mínimo  ${widget.count} Caracteres'
              : '',
          style: TextStyle(
              color: fieldiCount >= widget.count ? Colors.blue : Colors.red,
              fontSize: 10),
        ),
      ),
      keyboardType: widget.keyboardType,
      textCapitalization: widget.textCapitalization,
    );
  }
}
