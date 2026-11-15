import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Google sign-in (native Android dialog) exchanged for a Supabase session.
///
/// Flow: Google gives us an ID token -> we hand it to Supabase Auth with
/// `signInWithIdToken` -> Supabase checks it and creates the user + session.
class AuthService {
  AuthService(this._client);

  final SupabaseClient _client;

  User? get currentUser => _client.auth.currentUser;

  Stream<AuthState> get authChanges => _client.auth.onAuthStateChange;

  Future<AuthResponse> signInWithGoogle() async {
    final account = await GoogleSignIn.instance.authenticate();

    final idToken = account.authentication.idToken;
    if (idToken == null) {
      throw const AuthException(
        'Google did not return an ID token. Check GOOGLE_WEB_CLIENT_ID '
        'and the Android OAuth client (package name + SHA-1).',
      );
    }

    // The access token is optional for Supabase, but the official sample
    // passes it when available.
    final authorization = await account.authorizationClient
        .authorizationForScopes(const []);

    return _client.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: authorization?.accessToken,
    );
  }

  Future<void> signOut() async {
    await GoogleSignIn.instance.signOut();
    await _client.auth.signOut();
  }
}
