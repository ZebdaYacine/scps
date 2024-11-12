import 'package:app/core/widgets/date_picker.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Text("Setting Page"),
          DatePickerField(
            controller: controller,
            label: "label",
          ),
        ],
      ),
    );
  }
}
