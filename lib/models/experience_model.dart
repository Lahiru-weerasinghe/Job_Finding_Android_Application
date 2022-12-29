class Experience {
  String id;
  String position;
  String companyName;
  String description;

  Experience({
    this.id,
    this.companyName,
    this.position,
    this.description,
  });

  factory Experience.fromJson(
    Map<String, dynamic> json,
  ) =>
      Experience(
        id: json['_id'],
        position: json['position'],
        companyName: json['companyName'],
        description: json['description'],
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'position': position,
        'companyName': companyName,
        'description': description,
      };
}
