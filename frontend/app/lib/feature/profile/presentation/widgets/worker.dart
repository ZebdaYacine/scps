import 'package:app/core/widgets/auth_field.dart';
import 'package:app/core/widgets/auth_gradient_button.dart';
import 'package:flutter/material.dart';

class Worker extends StatefulWidget {
  const Worker({
    super.key,
  });

  @override
  State<Worker> createState() => _WorkerState();
}

class _WorkerState extends State<Worker> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  Map<String, dynamic> test = {};
  @override
  void dispose() {
    // Clean up controllers to prevent memory leaks
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: AuthField(
                      nameFiedl: "Mat assuree",
                      controller: usernameController,
                      isPwdField: false,
                    ),
                  ),
                  Expanded(
                    child: AuthField(
                      nameFiedl: "Mat assuree",
                      controller: usernameController,
                      isPwdField: false,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: AuthField(
                      nameFiedl: "Telephone",
                      controller: usernameController,
                      isPwdField: false,
                    ),
                  ),
                  Expanded(
                    child: AuthField(
                      nameFiedl: "Email",
                      controller: usernameController,
                      isPwdField: false,
                    ),
                  ),
                  Expanded(
                    child: AuthGradientButton(
                      buttonText: 'Validier',
                      onClick: () {
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
