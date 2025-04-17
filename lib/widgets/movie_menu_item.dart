import 'package:flutter/material.dart';

class MovieMenuItem extends StatelessWidget {
  final String menuName;
  final bool isSelected;
  final VoidCallback onSelected;

  const MovieMenuItem({
    super.key,
    required this.menuName,
    required this.isSelected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(menuName),
      selected: isSelected,
      onSelected: (_) => onSelected(),
      selectedColor: Theme.of(context).colorScheme.primaryContainer,
      labelStyle: TextStyle(
        color: isSelected
            ? Theme.of(context).colorScheme.onPrimaryContainer
            : null,
        fontSize: 12,
        fontWeight: isSelected
            ? FontWeight.bold
            : FontWeight.normal,
      ),
    );
  }
}
