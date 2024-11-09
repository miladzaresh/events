import 'dart:convert';
import 'package:flutter/foundation.dart';

class ErrorModel {
  List<String> message;
  ErrorModel({
    required this.message,
  });

  ErrorModel copyWith({
    List<String>? message,
  }) {
    return ErrorModel(
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'message': message,
    };
  }

  factory ErrorModel.fromMap(Map<String, dynamic> map) {
    try {
      String message = map['message'];
      return ErrorModel(
        message: [message],
      );
    } catch (e) {
      return ErrorModel(
        message: List<String>.from(map['message']),
      );
    }
  }

  String toJson() => json.encode(toMap());

  factory ErrorModel.fromJson(String source) =>
      ErrorModel.fromMap(json.decode(source));

  @override
  String toString() {
    String finalMessage = '';
    for (int i = 0; i < message.length; i++) {
      finalMessage += message[i];
      if (i != message.length - 1) {
        finalMessage += '\n';
      }
    }
    return finalMessage;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ErrorModel && listEquals(other.message, message);
  }

  @override
  int get hashCode => message.hashCode;
}
