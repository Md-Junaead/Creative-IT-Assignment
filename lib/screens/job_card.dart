import 'package:creative_it/models/job_model.dart';
import 'package:flutter/material.dart';

class JobCard extends StatelessWidget {
  final JobModel job;
  final VoidCallback onTap;
  final VoidCallback onApply;

  const JobCard({
    super.key,
    required this.job,
    required this.onTap,
    required this.onApply,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: onTap, // Make the entire card clickable
        borderRadius: BorderRadius.circular(4),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.network(
                    job.imageUrl,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.business);
                    },
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          job.title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${job.company} • ${job.location}',
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    job.salary, // Display salary on the left
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.green,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: job.isSaved ? null : onApply,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: job.isSaved
                          ? Colors.grey
                          : const Color(
                              0xFFFF5722), // Grey if applied, orange if not
                      foregroundColor: Colors.white, // White text for contrast
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 4, // Slight shadow for depth
                    ),
                    child: Text(job.isSaved ? 'Applied' : 'Apply Now'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
