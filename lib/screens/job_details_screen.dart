import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_job_portal/controllers/job_detail_controller.dart';

class JobDetailScreen extends StatelessWidget {
  final JobDetailController controller = Get.put(JobDetailController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Job Details'),
        actions: [
          Obx(() => IconButton(
                icon: Icon(
                  controller.isSaved.value
                      ? Icons.bookmark
                      : Icons.bookmark_border,
                  color: controller.isSaved.value ? Colors.blue : null,
                ),
                onPressed: controller.toggleSaveJob,
              )),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              controller.job.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              controller.job.company,
              style: const TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(Icons.location_on),
                const SizedBox(width: 8),
                Text(controller.job.location),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.attach_money),
                const SizedBox(width: 8),
                Text(controller.job.salary),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Description',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(controller.job.description),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () =>
                    Get.snackbar('Success', 'Application submitted'),
                child: const Text('Apply Now'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
