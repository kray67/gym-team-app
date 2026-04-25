import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_team/features/leaderboard/models/leaderboard_entry.dart';
import 'package:gym_team/features/leaderboard/providers/leaderboard_provider.dart';
import 'package:gym_team/features/workout/screens/exercise_picker_screen.dart';
import 'package:gym_team/shared/models/exercise.dart';
import 'package:gym_team/shared/widgets/user_avatar.dart';

enum _Category { attendance, records, lifts }

class LeaderboardTab extends ConsumerStatefulWidget {
  const LeaderboardTab({super.key});

  @override
  ConsumerState<LeaderboardTab> createState() => _LeaderboardTabState();
}

class _LeaderboardTabState extends ConsumerState<LeaderboardTab> {
  LeaderboardPeriod _period = LeaderboardPeriod.week;
  _Category _category = _Category.attendance;
  Exercise? _exercise;
  String _recordType = 'max_weight';

  Future<void> _pickExercise() async {
    final result = await context.push<ExercisePickerResult>(
      '/workout/pick-exercise?mode=swap',
    );
    if (result != null && mounted) {
      setState(() => _exercise = result.exercises.first);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
          child: SegmentedButton<_Category>(
            segments: const [
              ButtonSegment(
                value: _Category.attendance,
                label: Text('Workouts'),
                icon: Icon(Icons.calendar_today, size: 14),
              ),
              ButtonSegment(
                value: _Category.records,
                label: Text('Records'),
                icon: Icon(Icons.emoji_events, size: 14),
              ),
              ButtonSegment(
                value: _Category.lifts,
                label: Text('Lifts'),
                icon: Icon(Icons.fitness_center, size: 14),
              ),
            ],
            selected: {_category},
            onSelectionChanged: (s) => setState(() => _category = s.first),
            showSelectedIcon: false,
          ),
        ),
        if (_category != _Category.lifts)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
            child: SegmentedButton<LeaderboardPeriod>(
              segments: [
                for (final p in LeaderboardPeriod.values)
                  ButtonSegment(value: p, label: Text(p.label)),
              ],
              selected: {_period},
              onSelectionChanged: (s) => setState(() => _period = s.first),
              showSelectedIcon: false,
            ),
          ),
        const SizedBox(height: 12),
        const Divider(height: 1),
        Expanded(child: _buildBody()),
      ],
    );
  }

  Widget _buildBody() {
    switch (_category) {
      case _Category.attendance:
        return _LeaderboardList(
          async: ref.watch(attendanceLeaderboardProvider(_period)),
          valueLabel: (v) {
            final n = v.toInt();
            return '$n ${n == 1 ? 'workout' : 'workouts'}';
          },
        );
      case _Category.records:
        return _LeaderboardList(
          async: ref.watch(prLeaderboardProvider(_period)),
          valueLabel: (v) {
            final n = v.toInt();
            return '$n ${n == 1 ? 'PR' : 'PRs'}';
          },
        );
      case _Category.lifts:
        return _LiftsBody(
          exercise: _exercise,
          recordType: _recordType,
          onSelectExercise: _pickExercise,
          onRecordTypeChanged: (t) => setState(() => _recordType = t),
          ref: ref,
        );
    }
  }
}


// ── Lifts body ────────────────────────────────────────────────────────────────

class _LiftsBody extends StatelessWidget {
  final Exercise? exercise;
  final String recordType;
  final VoidCallback onSelectExercise;
  final void Function(String) onRecordTypeChanged;
  final WidgetRef ref;

  const _LiftsBody({
    required this.exercise,
    required this.recordType,
    required this.onSelectExercise,
    required this.onRecordTypeChanged,
    required this.ref,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              OutlinedButton.icon(
                icon: const Icon(Icons.fitness_center, size: 18),
                label: Text(exercise?.name ?? 'Select exercise…'),
                onPressed: onSelectExercise,
                style: OutlinedButton.styleFrom(
                  alignment: Alignment.centerLeft,
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: SegmentedButton<String>(
                  segments: const [
                    ButtonSegment(
                      value: 'max_weight',
                      label: Text('Max Weight'),
                    ),
                    ButtonSegment(
                      value: 'estimated_1rm',
                      label: Text('Est. 1RM'),
                    ),
                  ],
                  selected: {recordType},
                  onSelectionChanged: (s) => onRecordTypeChanged(s.first),
                  showSelectedIcon: false,
                ),
              ),
            ],
          ),
        ),
        const Divider(height: 1),
        if (exercise == null)
          const Expanded(
            child: Center(
              child: Text(
                'Select an exercise to see rankings',
                style: TextStyle(color: Colors.white38),
              ),
            ),
          )
        else
          Expanded(
            child: _LeaderboardList(
              async: ref.watch(
                exerciseLeaderboardProvider(exercise!.id, recordType),
              ),
              valueLabel: (v) => '${v % 1 == 0 ? v.toInt() : v.toStringAsFixed(1)} kg',
            ),
          ),
      ],
    );
  }
}

// ── Leaderboard list ──────────────────────────────────────────────────────────

class _LeaderboardList extends StatelessWidget {
  final AsyncValue<List<LeaderboardEntry>> async;
  final String Function(double) valueLabel;

  const _LeaderboardList({required this.async, required this.valueLabel});

  @override
  Widget build(BuildContext context) {
    return async.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
      data: (entries) {
        final nonZero = entries.where((e) => e.value > 0).toList();
        if (nonZero.isEmpty) {
          return const Center(
            child: Text(
              'No data yet',
              style: TextStyle(color: Colors.white38),
            ),
          );
        }
        return ListView.builder(
          itemCount: nonZero.length,
          itemBuilder: (context, i) {
            final e = nonZero[i];
            final rank = i + 1;
            return ListTile(
              leading: _RankWidget(rank: rank),
              title: Row(
                children: [
                  UserAvatar(
                    name: e.name,
                    avatarId: e.avatarId,
                    avatarColor: e.avatarColor,
                    radius: 14,
                  ),
                  const SizedBox(width: 10),
                  Expanded(child: Text(e.name)),
                ],
              ),
              trailing: Text(
                valueLabel(e.value),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: switch (rank) {
                    1 => Colors.amber,
                    2 => Colors.grey.shade400,
                    3 => Colors.brown.shade300,
                    _ => null,
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class _RankWidget extends StatelessWidget {
  final int rank;
  const _RankWidget({required this.rank});

  @override
  Widget build(BuildContext context) {
    if (rank <= 3) {
      final medals = ['🥇', '🥈', '🥉'];
      return SizedBox(
        width: 32,
        child: Text(
          medals[rank - 1],
          style: const TextStyle(fontSize: 22),
          textAlign: TextAlign.center,
        ),
      );
    }
    return SizedBox(
      width: 32,
      child: Text(
        '$rank',
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white38,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
