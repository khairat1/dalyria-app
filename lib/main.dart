import 'package:google_sign_in/google_sign_in.dart';
import 'package:material_ui/material_ui.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/config/env.dart';
import 'features/setup_check/setup_check_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    Env.validate();
    await Supabase.initialize(
      url: Env.supabaseUrl,
      publishableKey: Env.supabasePublishableKey,
    );
    // Must be called exactly once, before any other Google sign-in call.
    await GoogleSignIn.instance.initialize(serverClientId: Env.googleWebClientId);
  } catch (e) {
    // Show the problem on screen instead of a blank screen / crash.
    runApp(ConfigErrorApp(message: '$e'));
    return;
  }

  runApp(const DalyriaApp());
}

class DalyriaApp extends StatelessWidget {
  const DalyriaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dalyria',
      theme: ThemeData(
        // Damascene teal from the visual identity.
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0E6E76)),
      ),
      home: const SetupCheckScreen(),
    );
  }
}

/// Shown when the .env values are missing or incomplete.
class ConfigErrorApp extends StatelessWidget {
  const ConfigErrorApp({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              'Configuration problem:\n\n$message\n\n'
              'Fill in .env (copy .env.example), then stop the app and run:\n'
              'flutter run --dart-define-from-file=.env',
            ),
          ),
        ),
      ),
    );
  }
}
