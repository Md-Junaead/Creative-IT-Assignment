import 'package:get/get.dart';
import '../data/datasource/local_storage_datasource.dart';

class AuthViewModel extends GetxController {
  final LocalStorageDatasource _storage = LocalStorageDatasource();
  final RxBool isLoggedIn = false.obs;

  @override
  void onInit() {
    super.onInit();
    checkLoginStatus();
  }

  void checkLoginStatus() async {
    isLoggedIn.value = await _storage.isLoggedIn();
  }

  void loginUser(String userId, Map<String, dynamic> userData) async {
    await _storage.saveUser(userId, userData);
    isLoggedIn.value = true;
    Get.offNamed('/home');
  }

  void logout() async {
    await _storage.logoutUser();
    isLoggedIn.value = false;
    Get.offAllNamed('/login');
  }
}
