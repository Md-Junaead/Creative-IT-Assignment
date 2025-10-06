import 'package:creative_it/models/job_model.dart';
import 'package:creative_it/services/api_service.dart';
import 'package:creative_it/services/storage_service.dart';
import 'package:get/get.dart';

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

      // Check which jobs are saved for the current user
      final savedJobs = await storageService.getSavedJobs();
      final savedJobIds = savedJobs.map((job) => job.id).toSet();

      for (var job in apiJobs) {
        job.isSaved = savedJobIds.contains(job.id);
      }

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

      if (job.isSaved) {
        // Remove from saved jobs
        await storageService.removeJob(job.id);
        job.isSaved = false;
        Get.snackbar('Success', 'Job removed from saved');
      } else {
        // Create a new instance to avoid HiveObject conflict
        final jobCopy = JobModel(
          id: job.id,
          title: job.title,
          company: job.company,
          location: job.location,
          description: job.description,
          salary: job.salary,
          imageUrl: job.imageUrl,
          isSaved: true,
        );
        await storageService.saveJob(jobCopy);
        job.isSaved = true;
        Get.snackbar('Success', 'Job saved');
      }

      // Update the job in the main list
      jobs[index] = job;

      // Refresh the list to update UI
      jobs.refresh();
    } catch (e) {
      Get.snackbar('Error', 'Failed to update job: $e');
    }
  }

  Future<void> applyForJob(JobModel job) async {
    // Find the index of the job in the jobs list
    int index = jobs.indexOf(job);
    if (index != -1) {
      await toggleSaveJob(index);
    }
  }
}
