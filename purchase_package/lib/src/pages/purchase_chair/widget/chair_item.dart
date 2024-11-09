import 'package:flutter/material.dart';

class ChairItem extends StatelessWidget {
  final void Function(int) onTap;
  final int index;
  final bool value;

  ChairItem({
    required this.onTap,
    required this.index,
    required this.value,
  });

  @override
  Widget build(BuildContext context) => IconButton(
      onPressed: () async {
        onTap(index);
      },
      icon: Icon(
        Icons.chair,
        size: 25,
        color: value ? Colors.blue : Colors.grey,
      ));
}
