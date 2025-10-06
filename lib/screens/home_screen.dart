import 'package:creative_it/controllers/home_controller.dart';
import 'package:creative_it/screens/job_card.dart';
import 'package:creative_it/screens/job_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  final HomeController homeController = Get.put(HomeController());
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Job Portal'),
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark),
            onPressed: () => Get.toNamed('/saved_jobs'),
          ),
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () => Get.toNamed('/profile'),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: searchController,
              onChanged: homeController.searchJobs,
              decoration: const InputDecoration(
                labelText: 'Search jobs',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (homeController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (homeController.jobs.isEmpty) {
                return const Center(child: Text('No jobs found'));
              }

              return ListView.builder(
                itemCount: homeController.jobs.length,
                itemBuilder: (context, index) {
                  final job = homeController.jobs[index];
                  return JobCard(
                    job: job,
                    onTap: () =>
                        Get.to(() => JobDetailScreen(), arguments: job),
                    onSaveToggle: () => homeController.toggleSaveJob(index),
                    onApply: () => homeController.applyForJob(job),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
