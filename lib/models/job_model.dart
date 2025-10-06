import 'package:hive/hive.dart';

part 'job_model.g.dart';

@HiveType(typeId: 0)
class JobModel extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String company;

  @HiveField(3)
  String location;

  @HiveField(4)
  String description;

  @HiveField(5)
  String salary;

  @HiveField(6)
  String imageUrl;

  @HiveField(7)
  bool isSaved;

  JobModel({
    required this.id,
    required this.title,
    required this.company,
    required this.location,
    required this.description,
    required this.salary,
    required this.imageUrl,
    this.isSaved = false,
  });

  factory JobModel.fromJson(Map<String, dynamic> json) {
    return JobModel(
      id: json['id'],
      title: json['title'],
      company: json['brand'] ?? 'Unknown Company',
      location: 'Remote',
      description: json['description'],
      salary: '\$${json['price']}k',
      imageUrl: json['thumbnail'],
    );
  }
}
