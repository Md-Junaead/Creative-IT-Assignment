import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_job_portal/controllers/saved_jobs_controller.dart';
import 'package:mini_job_portal/models/job_model.dart';
import 'package:mini_job_portal/screens/job_detail_screen.dart';

class SavedJobsScreen extends StatelessWidget {
  final SavedJobsController controller = Get.put(SavedJobsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Jobs'),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.savedJobs.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.bookmark_border, size: 64, color: Colors.grey),
                SizedBox(height: 16),
                Text('No saved jobs yet', style: TextStyle(fontSize: 18)),
              ],
            ),
          );
        }

        return ListView.builder(
          itemCount: controller.savedJobs.length,
          itemBuilder: (context, index) {
            final job = controller.savedJobs[index];
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
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => controller.removeJob(index),
                ),
                onTap: () => Get.to(() => JobDetailScreen(), arguments: job),
              ),
            );
          },
        );
      }),
    );
  }
}
