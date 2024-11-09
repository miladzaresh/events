import 'package:flutter/material.dart';

import 'loading_app.dart';

class GeneralButton extends StatelessWidget {
  final void Function()? onPress;
  final String title;

  GeneralButton({required this.onPress,required this.title});

  @override
  Widget build(BuildContext context) =>
      SizedBox(
        height: 45,
        child: RawMaterialButton(
          onPressed: onPress,
          child:onPress==null?LoadingApp():Container(
            decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12)
            ),
            alignment: Alignment.center,
            padding: EdgeInsets.all(8),
            child: Text(title,style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.w600
            ),),
          ),
        ),
      );

}
