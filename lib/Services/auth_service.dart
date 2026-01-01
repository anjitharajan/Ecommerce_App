import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //-----Signup-----\\
  Future<User?> signup(String email, String password) async {
    final credential = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    return credential.user;
  }

  //--- Login ---\\
  Future<User?> login(String email, String password) async {

    //----- Firebase login -----\\
    final credential =
        await _auth.signInWithEmailAndPassword(email: email, password: password);
    return credential.user;
  }

  //----Logout----\\
  Future<void> logout() async {
    await _auth.signOut();
  }

  //---- Current user ----\\
  User? get currentUser => _auth.currentUser;
}
