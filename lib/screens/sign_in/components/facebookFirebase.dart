// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

// class FacebookFirebase {
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   Future<User?> signInWithFacebook() async {
//     try {
//       // Trigger the sign-in flow
//       final LoginResult result = await FacebookAuth.instance.login();

//       if (result.status == LoginStatus.success) {
//         // Obtain the auth details from the request
//         final AccessToken? accessToken = result.accessToken;
//         if (accessToken != null) {
//           final OAuthCredential credential = FacebookAuthProvider.credential(accessToken.token);

//           // Sign in to Firebase with the obtained credential
//           final UserCredential authResult = await _auth.signInWithCredential(credential);
//           final User? user = authResult.user;
//           return user;
//         } else {
//           print("Failed to get access token");
//           return null;
//         }
//       } else if (result.status == LoginStatus.cancelled) {
//         print("Login cancelled by the user.");
//         return null;
//       } else {
//         print("Login failed: ${result.message}");
//         return null;
//       }
//     } catch (error) {
//       print("Error during Facebook login: $error");
//       return null;
//     }
//   }

//   Future<void> signOut() async {
//     await _auth.signOut();
//     await FacebookAuth.instance.logOut();
//   }
// }
