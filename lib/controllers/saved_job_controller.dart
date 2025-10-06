import 'package:creative_it/models/job_model.dart';
import 'package:creative_it/services/storage_service.dart';
import 'package:get/get.dart';

class SavedJobsController extends GetxController {
  final StorageService storageService = StorageService();
  var savedJobs = <JobModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchSavedJobs();
  }

  Future<void> fetchSavedJobs() async {
    try {
      isLoading.value = true;
      final jobs = await storageService.getSavedJobs();
      savedJobs.assignAll(jobs);
    } catch (e) {
      Get.snackbar('Error', 'Failed to load saved jobs');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> removeJob(int index) async {
    try {
      final job = savedJobs[index];
      await storageService.removeJob(job.id);
      savedJobs.removeAt(index);
      Get.snackbar('Success', 'Job removed from saved');
    } catch (e) {
      Get.snackbar('Error', 'Failed to remove job');
    }
  }
}
