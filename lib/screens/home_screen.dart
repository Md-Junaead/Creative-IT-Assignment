import 'package:creative_it/controllers/home_controller.dart';
import 'package:creative_it/models/job_model.dart';
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
                    onTap: () => Get.toNamed('/job_detail', arguments: job),
                    onSaveToggle: () => homeController.toggleSaveJob(index),
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

class JobCard extends StatelessWidget {
  final JobModel job;
  final VoidCallback onTap;
  final VoidCallback onSaveToggle;

  const JobCard({
    super.key,
    required this.job,
    required this.onTap,
    required this.onSaveToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: Image.network(
          job.imageUrl,
          width: 50,
          height: 50,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.business);
          },
        ),
        title: Text(job.title),
        subtitle: Text('${job.company} • ${job.location}'),
        trailing: IconButton(
          icon: Icon(
            job.isSaved ? Icons.bookmark : Icons.bookmark_border,
            color: job.isSaved ? Colors.blue : null,
          ),
          onPressed: onSaveToggle,
        ),
        onTap: onTap,
      ),
    );
  }
}
