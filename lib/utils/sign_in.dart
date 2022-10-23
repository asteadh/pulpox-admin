// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

late bool authSignedIn;
// bool detailsUploaded;
late String uid;
late String name;
late String userEmail;
late String imageUrl;

/// The main Firestore collection
// final CollectionReference mainCollection =
//     Firestore.instance.collection('sofia');

// Use this for production
// final DocumentReference documentReference = mainCollection.document('prod');

// Use this for testing
// final DocumentReference documentReference = mainCollection.document('test');

/// For checking if the user is already signed into the
/// app using Google Sign In
Future getUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  authSignedIn = prefs.getBool('auth') ?? false;
  // detailsUploaded = prefs.getBool('details_uploaded') ?? false;

  User user = await FirebaseAuth.instance.currentUser!;

  if (authSignedIn == true) {
    uid = user.uid;
    name = user.displayName!;
    userEmail = user.email!;
    imageUrl = user.photoURL!;
  }
}

/// For authenticating user using Google Sign In
/// with Firebase Authentication API.
///
/// Retrieves some general user related information
/// from their Google account for ease of the login process
Future<String> signInWithGoogle() async {
  final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount!.authentication;

  final AuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  final UserCredential authResult =
      await _auth.signInWithCredential(credential);
  final User? user = authResult.user;

  // Checking if email and name is null
  assert(user!.email != null);
  assert(user!.displayName != null);
  assert(user!.photoURL != null);

  uid = user!.uid;
  name = user.displayName!;
  userEmail = user.email!;
  imageUrl = user.photoURL!;

  assert(!user.isAnonymous);

  // final User currentUser = await _auth.currentUser();
  assert(user.uid == _auth.currentUser!.uid);

  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('auth', true);
  authSignedIn = true;

  return 'Google sign in successful, User UID: ${user.uid}';
}

Future<String> registerWithEmailPassword(String email, String password) async {
  final UserCredential authResult = await _auth.createUserWithEmailAndPassword(
    email: email,
    password: password,
  );

  final User? user = authResult.user;

  // checking if uid or email is null
  assert(user!.email != null);

  uid = user!.uid;
  userEmail = user.email!;

  assert(!user.isAnonymous);

  // final FirebaseUser currentUser = await _auth.currentUser();
  // assert(user.uid == currentUser.uid);

  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // prefs.setBool('auth', true);
  // authSignedIn = true;

  return 'Successfully registered, User UID: ${user.uid}';
}

Future<String> signInWithEmailPassword(String email, String password) async {
  final UserCredential authResult = await _auth.signInWithEmailAndPassword(
    email: email,
    password: password,
  );

  final User? user = authResult.user;

  // checking if uid or email is null
  assert(user!.email != null);

  uid = user!.uid;
  userEmail = user.email!;

  assert(!user.isAnonymous);

  // final User currentUser = await _auth.currentUser();
  assert(user.uid == FirebaseAuth.instance.currentUser!.uid);

  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('auth', true);
  authSignedIn = true;

  return 'Successfully logged in, User UID: ${user.uid}';
}

Future<String> signOut() async {
  await _auth.signOut();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('auth', false);
  authSignedIn = false;

  uid = '';
  userEmail = '';

  return 'User signed out';
}

/// For signing out of their Google account
void signOutGoogle() async {
  await googleSignIn.signOut();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('auth', false);
  authSignedIn = false;

  print("User Sign Out");
}
