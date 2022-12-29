class Application {
  String id;
  String companyName;
  String position;
  String applicantName;
  String nic;
  String contactNumber;
  String university;
  String skills;
  String languages;
  String linkedIn;
  String github;
  String status;

  Application({
    this.id,
    this.companyName,
    this.position,
    this.applicantName,
    this.nic,
    this.contactNumber,
    this.university,
    this.skills,
    this.languages,
    this.linkedIn,
    this.github,
    this.status,
  });

  factory Application.fromJson(
    Map<String, dynamic> json,
  ) =>
      Application(
        id: json['_id'],
        companyName: json['job']['companyName'],
        position: json['job']['position'],
        applicantName: json['applicantName'],
        nic: json['nic'],
        contactNumber: json['contactNumber'],
        university: json['university'],
        skills: json['skills'],
        languages: json['languages'],
        linkedIn: json['linkedIn'],
        github: json['github'],
        status: json['status'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'companyName': companyName,
        'position': position,
        'applicantName': applicantName,
        'nic': nic,
        'contactNumber': contactNumber,
        'university': university,
        'skills': skills,
        'languages': languages,
        'linkedIn': linkedIn,
        'gitHub': github,
        'status': status,
      };
}
