class UserData {
  static const String name = "Prasad Store";

}

class UserType {
  int id;
  String type;

  UserType(this.id, this.type);

  static List<UserType> getUserTypes() {
    return <UserType> [
      UserType(1, 'Farmer'),
      UserType(2, 'Seller'),
      UserType(3, 'Transporter'),
      UserType(4, 'Representative'),
      UserType(5, 'Buyer')
    ];
  }

}