class User {
  String gender;
  userName name;
  String email;
  String phone;
  String cell;
  String nat;

  User({
    required this.gender,
    required this.name,
    required this.email,
    required this.phone,
    required this.cell,
    required this.nat,
  });
}

class userName {
  String title;
  String first;
  String last;
  userName({
    required this.title,
    required this.first,
    required this.last,
  });
}
