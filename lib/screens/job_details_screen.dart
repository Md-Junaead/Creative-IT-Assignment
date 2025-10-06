import 'package:creative_it/controllers/job_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class JobDetailScreen extends StatelessWidget {
  final JobDetailController controller = Get.put(JobDetailController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Job Details',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue[700],
        elevation: 2,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        actions: [
          Obx(() => IconButton(
                icon: Icon(
                  controller.isSaved.value
                      ? Icons.bookmark
                      : Icons.bookmark_border,
                  color: controller.isSaved.value ? Colors.white : null,
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
          ],
        ),
      ),
    );
  }
}
