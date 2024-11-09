import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../generated/locales.g.dart';

class SearchBox extends StatelessWidget {
  final void Function() onSearch;
  final TextEditingController controller;
  SearchBox({required this.onSearch,required this.controller});


  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          color: Colors.grey.shade200,
        ),
        margin: EdgeInsets.symmetric(vertical: 12),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              onPressed: onSearch,
              icon: Icon(
                Icons.search,
                size: 24,
                color: Colors.grey.shade500,
              ),
              style: ButtonStyle(
                padding: MaterialStateProperty.all(EdgeInsets.zero),

              ),
            ),
            SizedBox(
              width: 8,
            ),
            Expanded(
              child: SizedBox(
                height: 35,
                child: TextField(
                  cursorHeight: 20,
                  controller: controller,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    errorBorder: InputBorder.none,
                    hintText: LocaleKeys.shared_text_search.tr,
                  ),
                ),
              ),
            )
          ],
        ),
      );
}
