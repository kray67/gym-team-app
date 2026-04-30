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
    final noOverlay = WidgetStateProperty.all(Colors.transparent);
    return ThemeData(
      useMaterial3: true,
      splashFactory: NoSplash.splashFactory,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
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
      cardTheme: CardThemeData(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16)),
        margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF211F26),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: seed, width: 1.5),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      tabBarTheme: TabBarThemeData(
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: scheme.primaryContainer,
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        labelColor: scheme.onPrimaryContainer,
        unselectedLabelColor: scheme.onSurfaceVariant,
      ),
      chipTheme: const ChipThemeData(
        showCheckmark: false,
        shape: StadiumBorder(),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: ButtonStyle(
          splashFactory: NoSplash.splashFactory,
          overlayColor: noOverlay,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          splashFactory: NoSplash.splashFactory,
          overlayColor: noOverlay,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          splashFactory: NoSplash.splashFactory,
          overlayColor: noOverlay,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          splashFactory: NoSplash.splashFactory,
          overlayColor: noOverlay,
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
          splashFactory: NoSplash.splashFactory,
          overlayColor: noOverlay,
        ),
      ),
      listTileTheme: const ListTileThemeData(
        selectedTileColor: Colors.transparent,
      ),
    );
  }

  static ThemeData lightWithSeed(Color seed) {
    final scheme =
        ColorScheme.fromSeed(seedColor: seed, brightness: Brightness.light);
    final noOverlay = WidgetStateProperty.all(Colors.transparent);
    return ThemeData(
      useMaterial3: true,
      splashFactory: NoSplash.splashFactory,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      colorScheme: scheme,
      cardTheme: CardThemeData(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16)),
        margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: scheme.surfaceContainerHighest,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: seed, width: 1.5),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      tabBarTheme: TabBarThemeData(
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: scheme.primaryContainer,
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        labelColor: scheme.onPrimaryContainer,
        unselectedLabelColor: scheme.onSurfaceVariant,
      ),
      chipTheme: const ChipThemeData(
        showCheckmark: false,
        shape: StadiumBorder(),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: ButtonStyle(
          splashFactory: NoSplash.splashFactory,
          overlayColor: noOverlay,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          splashFactory: NoSplash.splashFactory,
          overlayColor: noOverlay,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          splashFactory: NoSplash.splashFactory,
          overlayColor: noOverlay,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          splashFactory: NoSplash.splashFactory,
          overlayColor: noOverlay,
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
          splashFactory: NoSplash.splashFactory,
          overlayColor: noOverlay,
        ),
      ),
      listTileTheme: const ListTileThemeData(
        selectedTileColor: Colors.transparent,
      ),
    );
  }
}
