class User {
  String id;
  String token;
  String firstName;
  String lastName;
  String phoneNumber;
  String password;
  String email;
  String position;
  String profileImageURL;
  List<dynamic> skills;
  List<dynamic> educations;
  List<dynamic> experiences;
  List<dynamic> posts;
  List<dynamic> applications;
  List<dynamic> jobs;

  User.createConstructor({
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.email,
    this.position,
    this.password,
    this.profileImageURL,
    this.token,
  });

  User.updateConstructor({
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.email,
    this.position,
    this.password,
  });

  User.loginConstructor({
    this.email,
    this.password,
  });

  User({
    this.id,
    this.token,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.password,
    this.email,
    this.profileImageURL,
    this.position,
    this.skills,
    this.educations,
    this.experiences,
    this.posts,
    this.applications,
    this.jobs,
  });

  factory User.fromJson(
    Map<String, dynamic> json,
  ) =>
      User(
        id: json['_id'],
        token: json['token'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        phoneNumber: json['phoneNumber'],
        password: json['password'],
        email: json['email'],
        position: json['position'],
        profileImageURL: json['profileImageURL'],
        skills: json['skills'],
        educations: json['education'],
        experiences: json['experience'],
        posts: json['posts'],
        applications: json['applicationList'],
        jobs: json['jobList'],
      );

  factory User.fromCreateJson(
    Map<String, dynamic> json,
  ) =>
      User.createConstructor(
        token: json['token'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        phoneNumber: json['phoneNumber'],
        position: json['position'],
        password: json['password'],
        email: json['email'],
        profileImageURL: json['profileImageURL'],
      );

  factory User.fromModifyJson(
    Map<String, String> json,
  ) =>
      User.updateConstructor(
        firstName: json['firstName'],
        lastName: json['lastName'],
        phoneNumber: json['phoneNumber'],
        position: json['position'],
        password: json['password'],
        email: json['email'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'firstName': firstName,
        'lastName': lastName,
        'phoneNumber': phoneNumber,
        'password': password,
        'email': email,
        'position': position,
        'profileImageURL': profileImageURL,
        'skills': skills,
        'educations': educations,
        'experiences': experiences,
        'applications': applications,
        'jobs': jobs,
      };
}
