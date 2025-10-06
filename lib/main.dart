import 'package:creative_it/models/job_model.dart';
import 'package:creative_it/models/user_model.dart';
import 'package:creative_it/screens/home_screen.dart';
import 'package:creative_it/screens/job_details_screen.dart';
import 'package:creative_it/screens/login_screen.dart';
import 'package:creative_it/screens/profile_screen.dart';
import 'package:creative_it/screens/saved_jobs_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

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
