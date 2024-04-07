import 'package:flutter/material.dart';
import 'package:lab/functions/select_date.dart';

Widget buildDatePicker(BuildContext context, TextEditingController controller) {
  return Row(
    children: <Widget>[
      Expanded(
        child: TextField(
          controller: controller,
          readOnly: true,
          decoration: InputDecoration(
            labelText: 'Fecha de Nacimiento',
            border: const OutlineInputBorder(),
            labelStyle: const TextStyle(color: Colors.green),
            suffixIcon: IconButton(
              onPressed: () {
                selectDate(context, controller);
              },
              icon: const Icon(Icons.date_range),
            ),
          ),
        ),
      )
    ],
  );
}
