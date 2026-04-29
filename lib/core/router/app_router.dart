import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:gym_team/core/supabase/supabase_client.dart';
import 'package:supabase_flutter/supabase_flutter.dart' show AuthState;
import 'package:gym_team/features/auth/screens/login_screen.dart';
import 'package:gym_team/features/auth/screens/register_screen.dart';
import 'package:gym_team/features/feed/screens/social_screen.dart';
import 'package:gym_team/features/feed/screens/feed_workout_detail_screen.dart';
import 'package:gym_team/features/feed/models/feed_item.dart';
import 'package:gym_team/features/workout/screens/workout_screen.dart';
import 'package:gym_team/features/workout/screens/workout_detail_screen.dart';
import 'package:gym_team/features/workout/screens/active_workout_screen.dart';
import 'package:gym_team/features/workout/screens/exercise_picker_screen.dart';
import 'package:gym_team/features/workout/screens/workout_summary_screen.dart';
import 'package:gym_team/features/plans/screens/plans_list_screen.dart';
import 'package:gym_team/features/plans/screens/plan_detail_screen.dart';
import 'package:gym_team/features/plans/screens/plan_editor_screen.dart';
import 'package:gym_team/features/plans/screens/plan_session_builder_screen.dart';
import 'package:gym_team/features/profile/screens/my_profile_screen.dart';
import 'package:gym_team/features/profile/screens/edit_profile_screen.dart';
import 'package:gym_team/features/profile/screens/settings_screen.dart';
import 'package:gym_team/features/profile/screens/user_profile_screen.dart';
import 'package:gym_team/features/profile/screens/followers_screen.dart';
import 'package:gym_team/features/profile/screens/my_exercises_screen.dart';
import 'package:gym_team/shared/widgets/main_scaffold.dart';

part 'app_router.g.dart';

/// Notifies GoRouter to re-run redirect whenever Supabase auth state changes.
class _AuthChangeNotifier extends ChangeNotifier {
  _AuthChangeNotifier() {
    _sub = supabase.auth.onAuthStateChange.listen((_) => notifyListeners());
  }

  late final StreamSubscription<AuthState> _sub;

  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }
}

@riverpod
GoRouter appRouter(AppRouterRef ref) {
  return GoRouter(
    initialLocation: '/social',
    refreshListenable: _AuthChangeNotifier(),
    redirect: (context, state) {
      final session = supabase.auth.currentSession;
      final isAuth = session != null;
      final isAuthRoute = state.matchedLocation == '/login' ||
          state.matchedLocation == '/register';

      if (!isAuth && !isAuthRoute) return '/login';
      if (isAuth && isAuthRoute) return '/social';
      return null;
    },
    routes: [
      // ── Auth ────────────────────────────────────────────────────────────
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),

      // ── Full-screen workout flow (no bottom nav) ─────────────────────────
      GoRoute(
        path: '/workout/active',
        builder: (context, state) => const ActiveWorkoutScreen(),
      ),
      GoRoute(
        path: '/workout/pick-exercise',
        builder: (context, state) {
          final single = state.uri.queryParameters['mode'] == 'swap';
          return ExercisePickerScreen(singleSelect: single);
        },
      ),

      // ── Post-workout summary (no bottom nav) ────────────────────────────
      GoRoute(
        path: '/workout/done/:id',
        builder: (context, state) => WorkoutSummaryScreen(
          sessionId: state.pathParameters['id']!,
        ),
      ),

      // ── Full-screen plan editor flow (no bottom nav) ─────────────────────
      GoRoute(
        path: '/plans/new',
        builder: (context, state) => const PlanEditorScreen(),
      ),
      GoRoute(
        path: '/plans/sessions-builder',
        builder: (context, state) => const PlanSessionBuilderScreen(),
      ),
      GoRoute(
        path: '/plans/session-editor',
        builder: (context, state) {
          final week =
              int.tryParse(state.uri.queryParameters['week'] ?? '') ?? 1;
          final day =
              int.tryParse(state.uri.queryParameters['day'] ?? '') ?? 1;
          return SessionEditorScreen(weekNumber: week, dayNumber: day);
        },
      ),

      // ── Shell (bottom nav) ───────────────────────────────────────────────
      ShellRoute(
        builder: (context, state, child) => MainScaffold(child: child),
        routes: [
          GoRoute(
            path: '/social',
            builder: (context, state) => const SocialScreen(),
            routes: [
              GoRoute(
                path: 'workout',
                builder: (context, state) => FeedWorkoutDetailScreen(
                  item: state.extra as FeedItem,
                ),
              ),
            ],
          ),
          GoRoute(
            path: '/workout',
            builder: (context, state) => const WorkoutScreen(),
            routes: [
              GoRoute(
                path: ':id',
                builder: (context, state) => WorkoutDetailScreen(
                  sessionId: state.pathParameters['id']!,
                ),
              ),
            ],
          ),
          GoRoute(
            path: '/plans',
            builder: (context, state) => const PlansListScreen(),
            routes: [
              GoRoute(
                path: ':id',
                builder: (context, state) => PlanDetailScreen(
                  planId: state.pathParameters['id']!,
                ),
              ),
            ],
          ),
          GoRoute(
            path: '/profile',
            builder: (context, state) => const MyProfileScreen(),
            routes: [
              GoRoute(
                path: 'edit',
                builder: (context, state) => const EditProfileScreen(),
              ),
              GoRoute(
                path: 'settings',
                builder: (context, state) => const SettingsScreen(),
              ),
              GoRoute(
                path: 'my-exercises',
                builder: (context, state) => const MyExercisesScreen(),
              ),
            ],
          ),
          GoRoute(
            path: '/user/:userId',
            builder: (context, state) => UserProfileScreen(
              userId: state.pathParameters['userId']!,
            ),
            routes: [
              GoRoute(
                path: 'followers',
                builder: (context, state) => FollowersScreen(
                  userId: state.pathParameters['userId']!,
                  initialTab: state.uri.queryParameters['tab'] == 'following' ? 1 : 0,
                ),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
