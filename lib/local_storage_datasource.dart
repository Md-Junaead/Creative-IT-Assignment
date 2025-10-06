import 'package:get_storage/get_storage.dart';

class LocalStorageDatasource {
  final GetStorage _storage = GetStorage();

  Future<void> saveUser(String userId, Map<String, dynamic> userData) async {
    await _storage.write('user_$userId', userData);
    await _storage.write('isLoggedIn', true);
  }

  Future<Map<String, dynamic>?> getUser(String userId) async {
    return _storage.read('user_$userId');
  }

  Future<void> saveJob(String jobId, Map<String, dynamic> jobData) async {
    await _storage.write('job_$jobId', jobData);
    final savedJobs = _storage.read<List>('saved_jobs') ?? [];
    savedJobs.add(jobId);
    await _storage.write('saved_jobs', savedJobs);
  }

  Future<List<Map<String, dynamic>>> getSavedJobs() async {
    final savedJobIds = _storage.read<List>('saved_jobs') ?? [];
    return Future.wait(savedJobIds.map((id) => _storage.read('job_$id')));
  }

  Future<void> logoutUser() async {
    await _storage.remove('isLoggedIn');
  }

  Future<bool> isLoggedIn() async {
    return _storage.read('isLoggedIn') ?? false;
  }
}
