import 'package:creative_it/models/job_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static const String baseUrl = 'https://dummyjson.com';

  Future<List<JobModel>> fetchJobs() async {
    final response = await http.get(Uri.parse('$baseUrl/products'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List products = data['products'];
      return products.map((product) => JobModel.fromJson(product)).toList();
    } else {
      throw Exception('Failed to load jobs');
    }
  }
}
