class Job {
  String id;
  String companyLogo;
  String companyName;
  String jobImage;
  String position;
  String salary;
  String description;

  Job.createJobConstructor({
    this.id,
    this.companyLogo,
    this.companyName,
    this.jobImage,
    this.position,
    this.salary,
    this.description,
  });

  Job({
    this.id,
    this.companyLogo,
    this.companyName,
    this.jobImage,
    this.position,
    this.salary,
    this.description,
  });

  factory Job.fromJson(
    Map<String, dynamic> json,
  ) =>
      Job(
        id: json['_id'],
        companyLogo: json['companyLogo'],
        companyName: json['companyName'],
        jobImage: json['jobImage'],
        position: json['position'],
        salary: json['salary'],
        description: json['description'],
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'companyLogo': companyLogo,
        'companyName': companyName,
        'jobImage': jobImage,
        'position': position,
        'salary': salary,
        'description': description,
      };
}
