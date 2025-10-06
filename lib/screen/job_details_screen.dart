import 'package:flutter/material.dart';

class JobDetailScreen extends StatelessWidget {
  final Map<String, dynamic> job;

  JobDetailScreen({required this.job});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Job Detail')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Title: ${job['title']}'),
            Text('Company: ${job['company']}'),
            ElevatedButton(
              onPressed: () {},
              child: Text('Apply'),
            ),
          ],
        ),
      ),
    );
  }
}
