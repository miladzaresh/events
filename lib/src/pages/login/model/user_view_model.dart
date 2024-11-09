class UserViewModel {
  final int id;
  final String firstName;
  final String lastName;
  final String username;
  final int gender;

  UserViewModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.gender,
  });

  factory UserViewModel.fromJson(Map<String, dynamic> json) => UserViewModel(
        id: json['id'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        username: json['username'],
        gender: json['gender'],
      );
}
