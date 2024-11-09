import 'package:flutter/material.dart';
class EmptyWidget extends StatelessWidget {
  final String message;

  EmptyWidget({required this.message});

  @override
  Widget build(BuildContext context) =>
      Center(
        child: Text(
          message,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black
          ),
        ),
      );
}
