import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:gym_team/core/supabase/supabase_client.dart';
import 'package:gym_team/features/auth/providers/auth_provider.dart';

part 'theme_color_notifier.g.dart';

/// Persists and provides the user's chosen accent color name
/// ('purple' | 'blue' | 'yellow' | 'orange').
/// Re-fetches automatically when auth state changes.
@Riverpod(keepAlive: true)
class ThemeColorNotifier extends _$ThemeColorNotifier {
  @override
  Future<String> build() async {
    final user = ref.watch(authNotifierProvider);
    if (user == null) return 'purple';
    final data = await supabase
        .from('profiles')
        .select('theme_color')
        .eq('id', user.id)
        .single();
    return (data['theme_color'] as String?) ?? 'purple';
  }

  /// Updates the color immediately in state and persists to Supabase.
  Future<void> setColor(String color) async {
    state = AsyncData(color);
    final userId = supabase.auth.currentUser?.id;
    if (userId == null) return;
    await supabase
        .from('profiles')
        .update({'theme_color': color})
        .eq('id', userId);
  }
}
