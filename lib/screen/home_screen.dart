import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../viewmodels/job_viewmodel.dart';

class HomeScreen extends StatelessWidget {
  final JobViewModel _jobVM = Get.put(JobViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home'), actions: [
        IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => Get.find<AuthViewModel>().logout()),
      ]),
      body: Obx(() => ListView.builder(
            itemCount: 10, // Dummy data for now
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('Job $index'),
                subtitle: Text('Company $index, Location $index'),
                trailing: ElevatedButton(
                  onPressed: () {
                    _jobVM.saveJob('job_$index',
                        {'title': 'Job $index', 'company': 'Company $index'});
                  },
                  child: Text('Save'),
                ),
              );
            },
          )),
    );
  }
}
