import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:gym_team/core/supabase/supabase_client.dart';

part 'auth_provider.g.dart';

@riverpod
class AuthNotifier extends _$AuthNotifier {
  @override
  User? build() => supabase.auth.currentUser;

  Future<void> signIn({required String username, required String password}) async {
    final email = await supabase.rpc('get_email_by_username', params: {'p_username': username}) as String?;
    if (email == null) throw Exception('Username not found');
    await supabase.auth.signInWithPassword(email: email, password: password);
    state = supabase.auth.currentUser;
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String username,
  }) async {
    await supabase.auth.signUp(
      email: email,
      password: password,
      data: {'username': username},
    );
    state = supabase.auth.currentUser;
  }

  Future<void> signOut() async {
    await supabase.auth.signOut();
    state = null;
  }

  Future<void> deleteAccount() async {
    await supabase.rpc('delete_account');
    await supabase.auth.signOut();
    state = null;
  }
}
