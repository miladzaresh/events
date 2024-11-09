import 'package:flutter/material.dart';

import '../../../shared/enums/gender_enum.dart';

class ChooseBox extends StatelessWidget {
  final Genders gender;
  final Genders selected;
  final String title;
  void Function(Genders) onChoose;

  ChooseBox({
    required this.gender,
    required this.selected,
    required this.onChoose,
    required this.title,
  });

  @override
  Widget build(BuildContext context) => InkWell(
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          border: gender==selected?null:Border.all(width: 1,color: Colors.grey.shade400),
          color:  gender==selected?Colors.grey.shade200:Colors.transparent,
          borderRadius: BorderRadius.circular(12)
      ),
      child: Text(
        title,
        style: TextStyle(
            fontSize: 14,
            color: Colors.black,
            fontWeight: FontWeight.normal
        ),
      ),
    ),
    onTap: (){
      onChoose(gender);
    },
  );
}
