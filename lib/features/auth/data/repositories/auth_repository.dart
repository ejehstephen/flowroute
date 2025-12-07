import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepository {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<AuthResponse> signUp({
    required String email,
    required String password,
    required String username,
  }) async {
    return await _supabase.auth.signUp(
      email: email,
      password: password,
      data: {'username': username},
    );
  }

  Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) async {
    return await _supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }

  Future<void> resetPassword(String email) async {
    await _supabase.auth.resetPasswordForEmail(email);
  }

  Future<void> updatePassword(String newPassword) async {
    await _supabase.auth.updateUser(UserAttributes(password: newPassword));
  }

  Future<void> deleteAccount() async {
    final user = _supabase.auth.currentUser;
    if (user != null) {
      // Delete user from auth
      await _supabase.rpc('delete_user');
      // Sign out
      await _supabase.auth.signOut();
    }
  }

  User? get currentUser => _supabase.auth.currentUser;

  Stream<AuthState> get authStateChanges => _supabase.auth.onAuthStateChange;
}
