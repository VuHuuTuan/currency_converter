/// AuthenRepo
abstract class AuthenRepo {
  void dispose();

  /// Data for sign in
  Future<bool> signIn(
    String email,
    String password,
  );
}
