import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:gym_team/core/supabase/supabase_client.dart';
import 'package:gym_team/features/leaderboard/models/leaderboard_entry.dart';

part 'leaderboard_provider.g.dart';

enum LeaderboardPeriod {
  week,
  month,
  allTime;

  String get rpcParam => switch (this) {
        LeaderboardPeriod.week => 'week',
        LeaderboardPeriod.month => 'month',
        LeaderboardPeriod.allTime => 'all_time',
      };

  String get label => switch (this) {
        LeaderboardPeriod.week => 'Week',
        LeaderboardPeriod.month => 'Month',
        LeaderboardPeriod.allTime => 'All Time',
      };
}

@riverpod
Future<List<LeaderboardEntry>> attendanceLeaderboard(
  AttendanceLeaderboardRef ref,
  LeaderboardPeriod period,
) async {
  final data = await supabase.rpc(
    'get_attendance_leaderboard',
    params: {'period': period.rpcParam},
  );
  return (data as List)
      .map((r) => LeaderboardEntry.fromRow(r as Map, 'workout_count'))
      .toList();
}

@riverpod
Future<List<LeaderboardEntry>> prLeaderboard(
  PrLeaderboardRef ref,
  LeaderboardPeriod period,
) async {
  final data = await supabase.rpc(
    'get_pr_leaderboard',
    params: {'period': period.rpcParam},
  );
  return (data as List)
      .map((r) => LeaderboardEntry.fromRow(r as Map, 'pr_count'))
      .toList();
}

@riverpod
Future<List<LeaderboardEntry>> exerciseLeaderboard(
  ExerciseLeaderboardRef ref,
  String exerciseId,
  String recordType,
) async {
  final data = await supabase.rpc(
    'get_exercise_leaderboard',
    params: {
      'p_exercise_id': exerciseId,
      'p_record_type': recordType,
    },
  );
  return (data as List)
      .map((r) => LeaderboardEntry.fromRow(r as Map, 'value'))
      .toList();
}
