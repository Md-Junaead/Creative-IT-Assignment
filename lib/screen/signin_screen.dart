import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../viewmodels/auth_viewmodel.dart';

class LoginScreen extends StatelessWidget {
  final AuthViewModel _authVM = Get.put(AuthViewModel());

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email')),
            TextField(
                controller: passwordController,
                decoration: InputDecoration(labelText: 'Password')),
            ElevatedButton(
              onPressed: () {
                _authVM.loginUser(emailController.text, {
                  'email': emailController.text,
                  'password': passwordController.text
                });
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
