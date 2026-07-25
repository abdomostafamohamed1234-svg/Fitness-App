import 'package:firebase_auth/firebase_auth.dart';
import 'package:flowery/core/const/firebase_constants.dart';
import 'package:flowery/features/auth_with_social_media/data/data_source/social_auth_data_source.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:flowery/core/base/base_response.dart';
import '../models/social_user_model.dart';

@Injectable(as: SocialAuthDataSourceContract)
class SocialAuthDataSourceImpl implements SocialAuthDataSourceContract {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final FacebookAuth _facebookAuth;
  bool _isGoogleSignInInitialized = false;

  SocialAuthDataSourceImpl(
    this._firebaseAuth,
    this._googleSignIn,
    this._facebookAuth,
  );

  Future<void> _ensureGoogleSignInInitialized() async {
    if (_isGoogleSignInInitialized) return;
    await _googleSignIn.initialize(
      serverClientId: FirebaseConstants.serverClientId,
    );
    _isGoogleSignInInitialized = true;
  }

  @override
  Future<Result<SocialUserModel>> signInWithGoogle() async {
    try {
      await _ensureGoogleSignInInitialized();

      final account = await _googleSignIn.authenticate();

      final authentication = account.authentication;

      final credential = GoogleAuthProvider.credential(
        idToken: authentication.idToken,
      );

      final userCredential = await _firebaseAuth.signInWithCredential(
        credential,
      );

      final user = userCredential.user!;

      final names = (user.displayName ?? '').trim().split(' ');

      final firstName = names.isNotEmpty ? names.first : '';

      final lastName = names.length > 1 ? names.sublist(1).join(' ') : '';

      final rawIdToken = authentication.idToken;
      if (rawIdToken == null) {
        return Error(
          exception: Exception('Google Sign-In returned a null idToken'),
        );
      }

      return Success(
        data: SocialUserModel(
          uid: user.uid,
          email: user.email ?? '',
          firstName: firstName,
          lastName: lastName,
          photoUrl: user.photoURL,
          provider: 'google',
          providerToken: rawIdToken,
        ),
      );
    } catch (e) {
      return Error(exception: Exception(e.toString()));
    }
  }

  @override
  Future<Result<SocialUserModel>> signInWithFacebook() async {
    try {
      final loginResult = await _facebookAuth.login();

      if (loginResult.status != LoginStatus.success) {
        return Error(
          exception: Exception(
            loginResult.message ?? 'Facebook Login Cancelled',
          ),
        );
      }

      final rawAccessToken = loginResult.accessToken!.tokenString;

      final credential = FacebookAuthProvider.credential(rawAccessToken);

      final userCredential = await _firebaseAuth.signInWithCredential(
        credential,
      );

      final user = userCredential.user!;

      final names = (user.displayName ?? '').trim().split(' ');

      final firstName = names.isNotEmpty ? names.first : '';

      final lastName = names.length > 1 ? names.sublist(1).join(' ') : '';

      return Success(
        data: SocialUserModel(
          uid: user.uid,
          email: user.email ?? '',
          firstName: firstName,
          lastName: lastName,
          photoUrl: user.photoURL,
          provider: 'facebook',
          providerToken: rawAccessToken,
        ),
      );
    } catch (e) {
      return Error(exception: Exception(e.toString()));
    }
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    await _googleSignIn.signOut();
    await _facebookAuth.logOut();
  }
}
