class User{
  num id;
  String firstName;
  String lastName;
  String iconUrl;

  User (this.id, this.firstName,this.lastName,this.iconUrl);

  static List<User> generateUsers(){
    return [
      User(1, 'Oliver','Perera','assets/images/Oliver Perera.png'),
      User(2, 'Elsa','Dias','assets/images/Elsa Dias.png'),
      User(3, 'Noah','James','assets/images/Noah James.png'),
      //User(4, 'Noah','James','assets/images/Noah James.png'),
    ];
  }
}

