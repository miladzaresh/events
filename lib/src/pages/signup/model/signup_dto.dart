class SignupDto {
  final String firstName;
  final String lastName;
  final String username;
  final String password;
  final int gender;

  SignupDto({
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.password,
    required this.gender,
  });

  Map<String,dynamic> toMap()=>{
    'firstName':this.firstName,
    'lastName':this.lastName,
    'username':this.username,
    'password':this.password,
    'gender':this.gender,
  };
}
