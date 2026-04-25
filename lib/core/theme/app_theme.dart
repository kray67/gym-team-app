import 'package:flutter/material.dart';

class AppTheme {
  static const Map<String, Color> seedColors = {
    'purple': Color(0xFF6C63FF),
    'blue': Color(0xFF2196F3),
    'yellow': Color(0xFFFFBF00),
    'orange': Color(0xFFFF6D00),
  };

  static const Map<String, String> colorLabels = {
    'purple': 'Purple',
    'blue': 'Blue',
    'yellow': 'Yellow',
    'orange': 'Orange',
  };

  static Color seedForName(String? name) =>
      seedColors[name ?? 'purple'] ?? seedColors['purple']!;

  static ThemeData get dark => darkWithSeed(seedColors['purple']!);

  static ThemeData darkWithSeed(Color seed) {
    final scheme = ColorScheme.fromSeed(
      seedColor: seed,
      brightness: Brightness.dark,
    );
    // Keep accent/primary colors from the seed but pin all surface/background
    // colors to neutral dark values — prevents the yellow/orange "tint" effect
    // that Material 3 applies to every surface when a warm seed is used.
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme.copyWith(
        surfaceTint: Colors.transparent,
        surface: const Color(0xFF141218),
        surfaceContainerLowest: const Color(0xFF0F0D13),
        surfaceContainerLow: const Color(0xFF1D1B20),
        surfaceContainer: const Color(0xFF211F26),
        surfaceContainerHigh: const Color(0xFF2B2930),
        surfaceContainerHighest: const Color(0xFF36343B),
        onSurface: const Color(0xFFE6E1E5),
        onSurfaceVariant: const Color(0xFFCAC4D0),
      ),
    );
  }
}
