import 'package:covid19/Model/User.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User> get user {
    print('method executed');
    return _auth.onAuthStateChanged
        .map((FirebaseUser user) => User(user: user));
  }

  Future loginThroughGoogle() async {
    print("## Authentication Process Started");
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    try {
      print("try");
      final FirebaseUser _user =
          (await _auth.signInWithCredential(credential)).user;
      return _user != null;
    } catch (e) {
      print("Error ###: " + e);
      return e;
    }
  }
}
