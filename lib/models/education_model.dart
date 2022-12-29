class Education {
  String id;
  String educationLogo;
  String period;
  String schoolName;
  String course;

  Education({
    this.id,
    this.educationLogo,
    this.period,
    this.schoolName,
    this.course,
  });

  factory Education.fromJson(
    Map<String, dynamic> json,
  ) =>
      Education(
        id: json['_id'],
        educationLogo: json['educationLogo'],
        period: json['period'],
        schoolName: json['schoolName'],
        course: json['course'],
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'educationLogo': educationLogo,
        'period': period,
        'schoolName': schoolName,
        'course': course,
      };
}
