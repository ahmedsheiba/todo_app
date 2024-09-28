import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DialogBox extends StatelessWidget {
  DialogBox(
      {super.key,
      required this.controller,
      required this.onCancel,
      required this.onSave});
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Form(
        key: _formKey,
        child: TextFormField(
          controller: controller,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            label: const Text(
              'Add New Task..',
              style: TextStyle(color: Colors.white),
            ),
            focusedBorder: _border,
            border: _border,
            enabledBorder: _border,
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your task';
            } else {
              return null;
            }
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: onCancel,
                child: const Text('Cancel'),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() == true) {
                    return onSave();
                  }
                },
                child: const Text('Save'),
              ),
            ),
          ],
        )
      ],
    );
  }
}

var _border = OutlineInputBorder(
  borderRadius: BorderRadius.circular(16),
  borderSide: const BorderSide(color: Colors.blueAccent, width: 3),
);
