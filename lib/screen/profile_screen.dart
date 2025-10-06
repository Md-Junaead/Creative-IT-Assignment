import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../viewmodels/auth_viewmodel.dart';

class ProfileScreen extends StatelessWidget {
  final AuthViewModel _authVM = Get.put(AuthViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: _authVM.checkLoginStatus()
            ? _authVM.getUser('user_1')
            : null, // Dummy userId
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Email: ${snapshot.data!['email']}'),
                  Text('Saved Jobs: 0'), // To be updated with actual count
                ],
              ),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
