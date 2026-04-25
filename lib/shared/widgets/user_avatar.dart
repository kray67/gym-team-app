import 'package:flutter/material.dart';

/// Ordered list of avatar icon choices (index = avatar_id in DB).
const List<IconData> kAvatarIcons = [
  Icons.person,
  Icons.directions_run,
  Icons.fitness_center,
  Icons.sports_gymnastics,
  Icons.sports_martial_arts,
  Icons.self_improvement,
  Icons.accessibility_new,
  Icons.sports_handball,
  Icons.sports_basketball,
  Icons.sports_soccer,
  Icons.sports_tennis,
  Icons.emoji_people,
];

/// Solid background colors — stored as hex strings in DB.
const List<Color> kAvatarColors = [
  Color(0xFFEF5350), // Red
  Color(0xFFFF7043), // Deep Orange
  Color(0xFFFFA726), // Amber
  Color(0xFF66BB6A), // Green
  Color(0xFF26A69A), // Teal
  Color(0xFF42A5F5), // Blue
  Color(0xFF5C6BC0), // Indigo
  Color(0xFFAB47BC), // Purple
  Color(0xFFEC407A), // Pink
  Color(0xFF8D6E63), // Brown
  Color(0xFF546E7A), // Blue Grey
  Color(0xFF29B6F6), // Light Blue
  Color(0xFF7E57C2), // Deep Purple
  Color(0xFFE91E63), // Rose
  Color(0xFF00897B), // Dark Teal
  Color(0xFFF57F17), // Dark Amber
];

const List<String> kAvatarColorHex = [
  '#EF5350',
  '#FF7043',
  '#FFA726',
  '#66BB6A',
  '#26A69A',
  '#42A5F5',
  '#5C6BC0',
  '#AB47BC',
  '#EC407A',
  '#8D6E63',
  '#546E7A',
  '#29B6F6',
  '#7E57C2',
  '#E91E63',
  '#00897B',
  '#F57F17',
];

/// Gradient pairs — stored as 'gradient:N' in DB.
const List<List<Color>> kAvatarGradients = [
  [Color(0xFFFF7043), Color(0xFFEC407A)], // Sunset
  [Color(0xFF42A5F5), Color(0xFF26A69A)], // Ocean
  [Color(0xFF5C6BC0), Color(0xFFAB47BC)], // Cosmos
  [Color(0xFF66BB6A), Color(0xFF00897B)], // Forest
  [Color(0xFFEC407A), Color(0xFFAB47BC)], // Flamingo
  [Color(0xFFFFA726), Color(0xFFEF5350)], // Ember
];

const List<String> kAvatarGradientHex = [
  'gradient:0',
  'gradient:1',
  'gradient:2',
  'gradient:3',
  'gradient:4',
  'gradient:5',
];

const List<String> kGradientLabels = [
  'Sunset',
  'Ocean',
  'Cosmos',
  'Forest',
  'Flamingo',
  'Ember',
];

const Color _kDefaultBg = Color(0xFF546E7A);

/// Returns the first solid color parsed from a hex string (e.g. '#EF5350').
/// Used as fallback and for solid-color rendering.
Color parseAvatarColor(String? hex) {
  if (hex == null || hex.startsWith('gradient:')) return _kDefaultBg;
  final cleaned = hex.replaceFirst('#', '');
  final val = int.tryParse('ff$cleaned', radix: 16);
  return val != null ? Color(val) : _kDefaultBg;
}

/// Builds the [BoxDecoration] (circle) for a given avatar color/gradient string.
BoxDecoration buildAvatarDecoration(String? avatarColor) {
  if (avatarColor != null && avatarColor.startsWith('gradient:')) {
    final idx = int.tryParse(avatarColor.substring(9)) ?? 0;
    if (idx >= 0 && idx < kAvatarGradients.length) {
      return BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: kAvatarGradients[idx],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      );
    }
  }
  return BoxDecoration(
    shape: BoxShape.circle,
    color: parseAvatarColor(avatarColor),
  );
}

/// Renders a circular avatar using the stored [avatarId] and [avatarColor].
/// Falls back to the first letter of [name] on a default background.
class UserAvatar extends StatelessWidget {
  final String name;
  final int? avatarId;
  final String? avatarColor;
  final double radius;

  const UserAvatar({
    super.key,
    required this.name,
    this.avatarId,
    this.avatarColor,
    this.radius = 20,
  });

  @override
  Widget build(BuildContext context) {
    final size = radius * 2;
    final icon = (avatarId != null && avatarId! >= 0 && avatarId! < kAvatarIcons.length)
        ? kAvatarIcons[avatarId!]
        : null;

    return Container(
      width: size,
      height: size,
      decoration: buildAvatarDecoration(avatarColor),
      child: Center(
        child: icon != null
            ? Icon(icon, size: radius * 1.1, color: Colors.white)
            : Text(
                name.isNotEmpty ? name[0].toUpperCase() : '?',
                style: TextStyle(
                  fontSize: radius * 0.9,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }
}
