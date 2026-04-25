/// A single personal-record row from the `exercise_records` table.
///
/// One row per (user, exercise, record_type) — upserted whenever a workout
/// produces a new best. [exerciseName] is populated via a joined query.
class ExerciseRecord {
  final String id;
  final String exerciseId;

  /// 'max_weight' | 'max_reps' | 'max_volume' | 'estimated_1rm'
  final String recordType;
  final double value;
  final String? sessionId;

  /// session_sets.id of the set that set this record.
  final String? setId;
  final DateTime achievedAt;
  final String? exerciseName;

  const ExerciseRecord({
    required this.id,
    required this.exerciseId,
    required this.recordType,
    required this.value,
    this.sessionId,
    this.setId,
    required this.achievedAt,
    this.exerciseName,
  });

  static ExerciseRecord fromRow(Map<String, dynamic> row) {
    final exerciseRow = row['exercises'] as Map<String, dynamic>?;
    return ExerciseRecord(
      id: row['id'] as String,
      exerciseId: row['exercise_id'] as String,
      recordType: row['record_type'] as String,
      value: (row['value'] as num).toDouble(),
      sessionId: row['session_id'] as String?,
      setId: row['set_id'] as String?,
      achievedAt: DateTime.parse(row['achieved_at'] as String),
      exerciseName: exerciseRow?['name'] as String?,
    );
  }

  /// Human-readable label for [recordType].
  String get typeLabel => switch (recordType) {
        'max_weight' => 'Max Weight',
        'max_volume' => 'Highest Volume Set',
        'estimated_1rm' => 'Est. 1RM',
        _ => recordType,
      };

  /// Formatted value string with unit.
  String get valueLabel {
    switch (recordType) {
      case 'max_weight':
      case 'estimated_1rm':
      case 'max_volume':
        final v = value % 1 == 0 ? value.toInt().toString() : value.toStringAsFixed(1);
        return '$v kg';
      default:
        return value.toStringAsFixed(1);
    }
  }
}
