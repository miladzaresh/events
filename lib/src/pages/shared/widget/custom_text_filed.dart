import 'package:flutter/material.dart';
class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType type;
  final Widget? toggle;
  final String title;
  final bool observed;
  final String? Function(String?)? onValidator;
  final Function()? onTap;


  CustomTextFormField(
      {required this.title,
        required this.controller,
        required this.type,
        this.toggle,
        this.observed = true,
        this.onValidator,
        this.onTap
      });

  @override
  Widget build(BuildContext context) => Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Colors.grey.shade700),
      ),
      SizedBox(
        height: 6,
      ),
      TextFormField(
        cursorHeight: 20,
        validator: onValidator,
        obscureText: toggle==null?false:observed,
        controller: controller,
        keyboardType: type,
        onTap: onTap,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          errorBorder: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(horizontal: 16,vertical: 4),
          suffixIcon: toggle,
        ),
      )
    ],
  );
}
