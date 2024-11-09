import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';

Future<String?> encodeImage(XFile? image) async {
  if (image == null) {
    return null;
  }

  List<int> fileBytes = await image.readAsBytes();
  String base64String = base64Encode(fileBytes);
  return base64String;
}

Uint8List decodeBase64ToFile(String base64String)  {
  Uint8List decodedBytes = base64Decode(base64String);
  return decodedBytes;
}
String checkMonth(DateTime time){
  Map<String,String> months={
    '1':'Jan',
    '2':'Feb',
    '3':'Mar',
    '4':'Apr',
    '5':'May',
    '6':'Jun',
    '7':'Jul',
    '8':'Aug',
    '9':'Sep',
    '10':'Oct',
    '11':'Nov',
    '12':'Dec',
  };
  return months[time.month.toString()]??'';
}
