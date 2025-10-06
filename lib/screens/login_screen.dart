import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_job_portal/controllers/auth_controller.dart';

class LoginScreen extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Mini Job Portal',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 30),
            Obx(() => ElevatedButton(
                  onPressed: authController.isLoading.value
                      ? null
                      : () => authController.login(
                            emailController.text,
                            passwordController.text,
                          ),
                  child: authController.isLoading.value
                      ? const CircularProgressIndicator()
                      : const Text('Login'),
                )),
          ],
        ),
      ),
    );
  }
}
