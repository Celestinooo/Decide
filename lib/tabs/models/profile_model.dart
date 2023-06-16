class ProfileModel {
  int id;
  String login;
  String password;
  final String name;
  final String description;
  final String imagePath;

  ProfileModel({
    this.id = -1,
    this.login = "",
    this.password = "",
    required this.name,
    required this.description,
    this.imagePath ="",
  });
}
