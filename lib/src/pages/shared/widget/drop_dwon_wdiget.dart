import 'package:flutter/material.dart';

class DropDownWidget extends StatelessWidget {
  final int value, maxValue;
  final void Function(int?)? onChange;

  DropDownWidget({
    required this.value,
    required this.maxValue,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) => DropdownButton<int>(
        onChanged: onChange,
        value: value,

        icon: Icon(Icons.keyboard_arrow_down,size: 24,color: Colors.grey.shade700,),
        underline: SizedBox(),
        padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
        borderRadius: BorderRadius.circular(8),
        focusColor: Colors.transparent,
        items: List<DropdownMenuItem<int>>.generate(
          maxValue,
          (index) => DropdownMenuItem<int>(
            child: Text(
              index.toString(),
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade900
              ),
            ),
            value: index,
          ),
        ),
      );
}
