// ignore_for_file: use_key_in_widget_constructors, public_member_api_docs, sort_constructors_first

import 'package:app/core/entities/son_data.dart';
import 'package:flutter/material.dart';
import 'package:app/core/extension/extension.dart';

class ListAyantDroit extends StatefulWidget {
  final List<SonData>? sons;

  const ListAyantDroit({super.key, this.sons});
  @override
  _ListAyantDroitState createState() => _ListAyantDroitState();
}

class _ListAyantDroitState extends State<ListAyantDroit> {
  String? _selectedValue;

  @override
  Widget build(BuildContext context) {
    final List<SonData> sons = widget.sons ?? [];

    return Padding(
      padding: const EdgeInsets.all(10.0), // Padding similar to AuthField
      child: SizedBox(
        width: context.isMobile
            ? context.responsiveWidth(100) // Matching width behavior
            : context.responsiveWidth(40),
        height: context.isMobile
            ? context.responsiveWidth(15)
            : context.responsiveWidth(5),
        child: DropdownButtonFormField<String>(
          value: _selectedValue,
          decoration: InputDecoration(
            labelText: 'Ayant droit',
            border: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(8.0), // Similar rounded corners
            ),
          ),
          hint: const Text('Select an option'),
          onChanged: (String? newValue) {
            setState(() {
              _selectedValue = newValue;
            });
          },
          items: sons.map<DropdownMenuItem<String>>((SonData son) {
            return DropdownMenuItem<String>(
              value: son.name,
              child: Text(son.name),
            );
          }).toList(),
        ),
      ),
    );
  }
}
