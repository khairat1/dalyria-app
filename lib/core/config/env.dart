/// Values from the `.env` file, passed in at build time with
/// `flutter run --dart-define-from-file=.env` (see docs/SETUP.md).
///
/// Only public client keys live here. See `.env.example`.
/// `GOOGLE_MAPS_API_KEY` is not read in Dart: Gradle injects it into
/// AndroidManifest.xml at build time (see android/app/build.gradle.kts).
class Env {
  const Env._();

  static const supabaseUrl = String.fromEnvironment('SUPABASE_URL');
  static const supabasePublishableKey =
      String.fromEnvironment('SUPABASE_PUBLISHABLE_KEY');
  static const googleWebClientId =
      String.fromEnvironment('GOOGLE_WEB_CLIENT_ID');

  /// Throws a readable error if a required value is missing or empty.
  static void validate() {
    const values = {
      'SUPABASE_URL': supabaseUrl,
      'SUPABASE_PUBLISHABLE_KEY': supabasePublishableKey,
      'GOOGLE_WEB_CLIENT_ID': googleWebClientId,
    };
    final missing = [
      for (final entry in values.entries)
        if (entry.value.trim().isEmpty) entry.key,
    ];
    if (missing.isNotEmpty) {
      throw StateError('Missing or empty: ${missing.join(', ')}.');
    }
  }
}
