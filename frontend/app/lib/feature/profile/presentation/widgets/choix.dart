// ignore_for_file: use_key_in_widget_constructors, public_member_api_docs, sort_constructors_first

import 'package:app/feature/profile/presentation/cubit/used_cubit.dart';
import 'package:flutter/material.dart';
import 'package:app/core/extension/extension.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Choise extends StatefulWidget {
  const Choise({super.key});
  @override
  _ChoiseState createState() => _ChoiseState();
}

class _ChoiseState extends State<Choise> {
  String? _selectedValue;

  @override
  Widget build(BuildContext context) {
    final List<String> sons = ["le properetaire", "l'ayant droit"];

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
            labelText: 'Select an option',
            border: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(8.0), // Similar rounded corners
            ),
          ),
          hint: const Text('le properetaire'),
          onChanged: (String? newValue) {
            setState(() {
              _selectedValue = newValue;
              if (_selectedValue == "le properetaire") {
                context.read<UsedCubit>().meUsed();
              } else {
                context.read<UsedCubit>().ayantDroitUsed();
              }
            });
          },
          items: sons.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }
}
