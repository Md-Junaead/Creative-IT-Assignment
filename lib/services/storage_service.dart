import 'package:creative_it/models/job_model.dart';
import 'package:creative_it/models/user_model.dart';
import 'package:hive/hive.dart';

class StorageService {
  // Jobs
  Future<void> saveJobs(List<JobModel> jobs) async {
    final box = await Hive.openBox<JobModel>('jobs');
    await box.clear();
    for (var job in jobs) {
      await box.put(job.id, job);
    }
  }

  Future<List<JobModel>> getJobs() async {
    final box = await Hive.openBox<JobModel>('jobs');
    return box.values.toList();
  }

  // Saved Jobs
  Future<void> saveJob(JobModel job) async {
    final box = await Hive.openBox<JobModel>('savedJobs');
    await box.put(job.id, job);
  }

  Future<void> removeJob(int jobId) async {
    final box = await Hive.openBox<JobModel>('savedJobs');
    await box.delete(jobId);
  }

  Future<List<JobModel>> getSavedJobs() async {
    final box = await Hive.openBox<JobModel>('savedJobs');
    return box.values.toList();
  }

  // User
  Future<void> saveUser(UserModel user) async {
    final box = await Hive.openBox<UserModel>('user');
    await box.clear();
    await box.put('currentUser', user);
  }

  Future<UserModel?> getUser() async {
    final box = await Hive.openBox<UserModel>('user');
    return box.get('currentUser');
  }

  Future<void> logout() async {
    final box = await Hive.openBox<UserModel>('user');
    await box.clear();
  }
}
