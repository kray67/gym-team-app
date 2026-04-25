class LeaderboardEntry {
  final String userId;
  final String username;
  final String? displayName;
  final int? avatarId;
  final String? avatarColor;
  final double value;

  const LeaderboardEntry({
    required this.userId,
    required this.username,
    this.displayName,
    this.avatarId,
    this.avatarColor,
    required this.value,
  });

  String get name => displayName ?? username;

  factory LeaderboardEntry.fromRow(Map row, String valueKey) {
    return LeaderboardEntry(
      userId: row['user_id'] as String,
      username: row['username'] as String,
      displayName: row['display_name'] as String?,
      avatarId: row['avatar_id'] as int?,
      avatarColor: row['avatar_color'] as String?,
      value: (row[valueKey] as num).toDouble(),
    );
  }
}
