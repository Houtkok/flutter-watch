import 'package:flutter/material.dart';

class ToggleButtonsWidget extends StatelessWidget {
  const ToggleButtonsWidget(
      {super.key,
      required this.selectedCategory,
      required this.onCategoryChange});
  final String selectedCategory;
  final Function(String) onCategoryChange;

  Widget _buildToggleButton(String label) {
    final bool isSelected = label == selectedCategory;

    return Expanded(
        child: ElevatedButton(
            onPressed: () => onCategoryChange(label),
            style: ElevatedButton.styleFrom(
                backgroundColor: isSelected ? Colors.grey[300] : Colors.white),
            child: Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.black : Colors.grey[600],
              ),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildToggleButton('Watch'),
        _buildToggleButton('Watch Strap'),
      ],
    );
  }
}
