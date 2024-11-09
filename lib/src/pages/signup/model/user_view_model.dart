import 'package:events/src/pages/login/model/user_view_model.dart';

class UserViewModel {
  final String firstName;
  final String lastName;
  final String username;
  final String password;
  final int gender;
  final int id;

  UserViewModel({
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.password,
    required this.gender,
    required this.id,
  });

  factory UserViewModel.fromJson(Map<String, dynamic> json) => UserViewModel(
        firstName: json['firstName'],
        lastName: json['lastName'],
        username: json['username'],
        password: json['password'],
        gender: json['gender'],
        id: json['id'],
      );
}
