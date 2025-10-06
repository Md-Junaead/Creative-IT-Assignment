import 'package:get/get.dart';
import 'package:mini_job_portal/models/job_model.dart';
import 'package:mini_job_portal/services/api_service.dart';
import 'package:mini_job_portal/services/storage_service.dart';

class HomeController extends GetxController {
  final ApiService apiService = ApiService();
  final StorageService storageService = StorageService();

  var jobs = <JobModel>[].obs;
  var isLoading = true.obs;
  var searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchJobs();
  }

  Future<void> fetchJobs() async {
    try {
      isLoading.value = true;

      // Try local storage first
      final localJobs = await storageService.getJobs();
      if (localJobs.isNotEmpty) {
        jobs.assignAll(localJobs);
      }

      // Fetch from API
      final apiJobs = await apiService.fetchJobs();
      await storageService.saveJobs(apiJobs);
      jobs.assignAll(apiJobs);
    } catch (e) {
      Get.snackbar('Error', 'Failed to load jobs');
    } finally {
      isLoading.value = false;
    }
  }

  void searchJobs(String query) {
    searchQuery.value = query;
    if (query.isEmpty) {
      fetchJobs();
    } else {
      final allJobs = jobs.where((job) {
        return job.title.toLowerCase().contains(query.toLowerCase()) ||
            job.company.toLowerCase().contains(query.toLowerCase());
      }).toList();
      jobs.assignAll(allJobs);
    }
  }

  Future<void> toggleSaveJob(int index) async {
    try {
      final job = jobs[index];
      job.isSaved = !job.isSaved;

      if (job.isSaved) {
        await storageService.saveJob(job);
        Get.snackbar('Success', 'Job saved');
      } else {
        await storageService.removeJob(job.id);
        Get.snackbar('Success', 'Job removed from saved');
      }

      jobs.refresh();
    } catch (e) {
      Get.snackbar('Error', 'Failed to update job');
    }
  }
}
