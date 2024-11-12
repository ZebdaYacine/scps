import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For formatting dates

class DatePickerField extends StatelessWidget {
  final TextEditingController controller;
  final String label;

  const DatePickerField({
    super.key,
    required this.controller,
    required this.label,
  });

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      // Set the selected date to the text field in the format 'yyyy-MM-dd'
      controller.text = DateFormat('yyyy-MM-dd').format(pickedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        suffixIcon: const Icon(Icons.calendar_today),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Date est vide'; // Error message if the field is empty
        }
        return null; // No error message if the field is valid
      },
      readOnly: true, // Makes the field non-editable
      onTap: () => _selectDate(context), // Opens the date picker
    );
  }
}
