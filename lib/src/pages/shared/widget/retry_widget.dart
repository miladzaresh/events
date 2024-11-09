import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../generated/locales.g.dart';

class RetryWidget extends StatelessWidget {
  final void Function() onTap;

  RetryWidget({required this.onTap});

  @override
  Widget build(BuildContext context) => Center(
        child: Flex(
          direction: Axis.vertical,
          children: [
            Text(
              LocaleKeys.shared_text_retry.tr,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
            TextButton(
              onPressed: onTap,
              child: Icon(
                Icons.refresh,
                size: 25,
              ),
            )
          ],
        ),
      );
}
