import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mini_job_portal/models/job_model.dart';
import 'package:mini_job_portal/models/user_model.dart';
import 'package:mini_job_portal/screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(JobModelAdapter());
  Hive.registerAdapter(UserModelAdapter());
  await Hive.openBox<JobModel>('jobs');
  await Hive.openBox<JobModel>('savedJobs');
  await Hive.openBox<UserModel>('user');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Mini Job Portal',
      home: LoginScreen(),
      getPages: [
        GetPage(name: '/', page: () => LoginScreen()),
        GetPage(name: '/home', page: () => HomeScreen()),
        GetPage(name: '/job_detail', page: () => JobDetailScreen()),
        GetPage(name: '/saved_jobs', page: () => SavedJobsScreen()),
        GetPage(name: '/profile', page: () => ProfileScreen()),
      ],
    );
  }
}
