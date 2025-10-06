import 'package:get/get.dart';
import 'package:mini_job_portal/models/user_model.dart';
import 'package:mini_job_portal/services/storage_service.dart';

class AuthController extends GetxController {
  final StorageService storageService = StorageService();

  var isLoading = false.obs;
  var isLoggedIn = false.obs;

  @override
  void onInit() {
    super.onInit();
    checkLoginStatus();
  }

  void checkLoginStatus() async {
    final user = await storageService.getUser();
    if (user != null) {
      isLoggedIn.value = true;
      Get.offAllNamed('/home');
    }
  }

  Future<void> login(String email, String password) async {
    try {
      isLoading.value = true;

      // Create user if not exists
      final user = UserModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: 'Demo User',
        email: email,
        password: password,
      );

      await storageService.saveUser(user);
      isLoggedIn.value = true;
      Get.offAllNamed('/home');
    } catch (e) {
      Get.snackbar('Error', 'Login failed');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    await storageService.logout();
    isLoggedIn.value = false;
    Get.offAllNamed('/');
  }
}
