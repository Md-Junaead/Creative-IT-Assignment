import 'package:get/get.dart';
import '../data/datasource/local_storage_datasource.dart';

class JobViewModel extends GetxController {
  final LocalStorageDatasource _storage = LocalStorageDatasource();
  final RxList<Map<String, dynamic>> savedJobs = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchSavedJobs();
  }

  void fetchSavedJobs() async {
    savedJobs.value = await _storage.getSavedJobs();
  }

  void saveJob(String jobId, Map<String, dynamic> jobData) async {
    await _storage.saveJob(jobId, jobData);
    fetchSavedJobs();
  }
}
