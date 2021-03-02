import '../reposity/authen_reposity.dart';
import '../reposity_implement/authen_repo_impl.dart';

/// Authen service
class AuthenService {
  AuthenService([AuthenRepoImpl _repo]) {
    _authenRepo = _repo ?? AuthenRepoImpl();
  }
  AuthenRepo _authenRepo;

  void dispose() => _authenRepo?.dispose();

  ///
  /// Handle sign in to system
  ///
  Future<bool> signIn(String email, String password) =>
      _authenRepo.signIn(email, password);
}
