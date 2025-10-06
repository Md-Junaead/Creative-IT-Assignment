import 'package:creative_it/models/user_model.dart';
import 'package:creative_it/services/storage_service.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final StorageService storageService = StorageService();

  var isLoading = false.obs;
  var isLoggedIn = false.obs;
  var users = <UserModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _initializeDemoUsers();
    checkLoginStatus();
  }

  // Initialize demo users
  void _initializeDemoUsers() {
    final demoUsers = [
      UserModel(
        id: '1',
        name: 'John Doe',
        email: 'john@gmail.com',
        password: '1234',
      ),
      UserModel(
        id: '2',
        name: 'Jane Smith',
        email: 'jane@gmail.com',
        password: '1234',
      ),
      UserModel(
        id: '3',
        name: 'Admin User',
        email: 'admin@gmail.com',
        password: '1234',
      ),
    ];
    users.assignAll(demoUsers);
  }

  void checkLoginStatus() async {
    final user = await storageService.getUser();
    if (user != null) {
      isLoggedIn.value = true;
      Get.offAllNamed('/home');
    }
  }

  // Login with existing user
  Future<void> login(String email, String password) async {
    try {
      isLoading.value = true;

      // Check if user exists in demo users
      final existingUser = users.firstWhereOrNull(
        (user) => user.email == email && user.password == password,
      );

      if (existingUser != null) {
        await storageService.saveUser(existingUser);
        isLoggedIn.value = true;
        Get.offAllNamed('/home');
        Get.snackbar('Success', 'Login successful');
      } else {
        // Check if user exists in local storage
        final localUser = await storageService.getUser();
        if (localUser != null &&
            localUser.email == email &&
            localUser.password == password) {
          isLoggedIn.value = true;
          Get.offAllNamed('/home');
          Get.snackbar('Success', 'Login successful');
        } else {
          Get.snackbar('Error', 'Invalid email or password');
        }
      }
    } catch (e) {
      Get.snackbar('Error', 'Login failed');
    } finally {
      isLoading.value = false;
    }
  }

  // Signup new user
  Future<void> signup(String name, String email, String password) async {
    try {
      isLoading.value = true;

      // Check if email already exists
      final emailExists = users.any((user) => user.email == email);
      if (emailExists) {
        Get.snackbar('Error', 'Email already exists');
        return;
      }

      // Create new user
      final newUser = UserModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: name,
        email: email,
        password: password,
      );

      // Add to users list
      users.add(newUser);

      // Save to local storage
      await storageService.saveUser(newUser);

      isLoggedIn.value = true;
      Get.offAllNamed('/home');
      Get.snackbar('Success', 'Account created successfully');
    } catch (e) {
      Get.snackbar('Error', 'Signup failed');
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
