import 'package:flutter/material.dart';

class AddQuantity extends StatelessWidget {
  const AddQuantity({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        decoration: InputDecoration(
          labelText: 'Quantité',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
