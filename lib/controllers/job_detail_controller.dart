import 'package:creative_it/models/job_model.dart';
import 'package:creative_it/services/storage_service.dart';
import 'package:get/get.dart';

class JobDetailController extends GetxController {
  final StorageService storageService = StorageService();
  late JobModel job;
  var isSaved = false.obs;

  @override
  void onInit() {
    super.onInit();
    job = Get.arguments as JobModel;
    isSaved.value = job.isSaved;
  }

  Future<void> toggleSaveJob() async {
    try {
      isSaved.value = !isSaved.value;
      job.isSaved = isSaved.value;

      if (isSaved.value) {
        await storageService.saveJob(job);
        Get.snackbar('Success', 'Job saved');
      } else {
        await storageService.removeJob(job.id);
        Get.snackbar('Success', 'Job removed from saved');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to update job');
    }
  }
}
