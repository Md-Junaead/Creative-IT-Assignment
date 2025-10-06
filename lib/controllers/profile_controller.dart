import 'package:get/get.dart';
import 'package:mini_job_portal/models/user_model.dart';
import 'package:mini_job_portal/services/storage_service.dart';

class ProfileController extends GetxController {
  final StorageService storageService = StorageService();
  var user = Rxn<UserModel>();
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUser();
  }

  Future<void> fetchUser() async {
    try {
      isLoading.value = true;
      user.value = await storageService.getUser();
    } catch (e) {
      Get.snackbar('Error', 'Failed to load profile');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    await storageService.logout();
    Get.offAllNamed('/');
  }
}
