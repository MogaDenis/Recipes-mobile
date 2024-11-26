import 'package:flutter/material.dart';

class DropdownMenuWidget extends StatefulWidget {
  final String label;
  final String value;
  final List<String> options;
  final Function(String?) onChanged;

  const DropdownMenuWidget(
      {super.key,
      required this.label,
      required this.value,
      required this.options,
      required this.onChanged});

  @override
  State<StatefulWidget> createState() => _DropdownMenuState();
}

class _DropdownMenuState extends State<DropdownMenuWidget> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      decoration: InputDecoration(labelText: widget.label),
      value: widget.value,
      icon: const Icon(Icons.arrow_drop_down),
      elevation: 16,
      style: const TextStyle(color: Colors.black),
      onChanged: widget.onChanged,
      items: widget.options.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Field is required';
        }
        return null;
      },
    );
  }
}
