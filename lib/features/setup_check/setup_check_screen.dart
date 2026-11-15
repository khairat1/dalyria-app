import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:material_ui/material_ui.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../auth/data/auth_service.dart';

/// TEMPORARY developer screen: proves that .env, Supabase, Google sign-in and
/// Google Maps all work. It will be replaced by the real home screen when the
/// app foundation (theme, navigation, localization) is built.
class SetupCheckScreen extends StatefulWidget {
  const SetupCheckScreen({super.key});

  @override
  State<SetupCheckScreen> createState() => _SetupCheckScreenState();
}

class _SetupCheckScreenState extends State<SetupCheckScreen> {
  final _auth = AuthService(Supabase.instance.client);

  String _supabaseStatus = 'Checking...';
  String _authStatus = 'Not signed in';
  bool _busy = false;

  @override
  void initState() {
    super.initState();
    _checkSupabase();
    _authStatus = _describeUser(_auth.currentUser);
  }

  String _describeUser(User? user) =>
      user == null ? 'Not signed in' : 'Signed in as ${user.email}';

  /// Asks for a table that does not exist. "Table not found" means the server
  /// answered and accepted our key. An "Invalid API key" error means it didn't.
  Future<void> _checkSupabase() async {
    try {
      await Supabase.instance.client.from('_connection_check').select().limit(1);
      _setSupabase('Connected');
    } on PostgrestException catch (e) {
      const tableMissing = {'PGRST205', 'PGRST125', '42P01'};
      if (tableMissing.contains(e.code)) {
        _setSupabase('Connected (server reachable, key accepted)');
      } else {
        _setSupabase('Error ${e.code}: ${e.message}');
      }
    } catch (e) {
      _setSupabase('Error: $e');
    }
  }

  void _setSupabase(String text) {
    if (mounted) setState(() => _supabaseStatus = text);
  }

  Future<void> _signIn() async {
    setState(() => _busy = true);
    try {
      final response = await _auth.signInWithGoogle();
      setState(() => _authStatus = _describeUser(response.user));
    } catch (e) {
      setState(() => _authStatus = 'Sign-in failed: $e');
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _signOut() async {
    await _auth.signOut();
    setState(() => _authStatus = _describeUser(_auth.currentUser));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dalyria setup check')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('1. .env loaded', style: TextStyle(fontWeight: FontWeight.bold)),
          const Text('OK (the app would not have started otherwise)'),
          const SizedBox(height: 16),
          const Text('2. Supabase', style: TextStyle(fontWeight: FontWeight.bold)),
          Text(_supabaseStatus),
          const SizedBox(height: 16),
          const Text('3. Google sign-in', style: TextStyle(fontWeight: FontWeight.bold)),
          Text(_authStatus),
          const SizedBox(height: 8),
          Row(
            children: [
              ElevatedButton(
                onPressed: _busy ? null : _signIn,
                child: const Text('Sign in with Google'),
              ),
              const SizedBox(width: 8),
              OutlinedButton(
                onPressed: _busy ? null : _signOut,
                child: const Text('Sign out'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text('4. Google Maps (Damascus)', style: TextStyle(fontWeight: FontWeight.bold)),
          const Text('A grey map with no tiles means the Maps key has a problem.'),
          const SizedBox(height: 8),
          SizedBox(
            height: 260,
            child: GoogleMap(
              initialCameraPosition: const CameraPosition(
                target: LatLng(33.5138, 36.2765),
                zoom: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
