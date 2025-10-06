import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../viewmodels/job_viewmodel.dart';

class SavedJobsScreen extends StatelessWidget {
  final JobViewModel _jobVM = Get.put(JobViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Saved Jobs')),
      body: Obx(() => ListView.builder(
            itemCount: _jobVM.savedJobs.length,
            itemBuilder: (context, index) {
              final job = _jobVM.savedJobs[index];
              return ListTile(
                title: Text(job['title']),
                subtitle: Text(job['company']),
              );
            },
          )),
    );
  }
}
