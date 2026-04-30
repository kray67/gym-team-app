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

    const _surface = Color(0xFF141218);
    const _surfaceLow = Color(0xFF1D1B20);
    const _surfaceContainer = Color(0xFF211F26);
    const _surfaceHigh = Color(0xFF2B2930);
    const _surfaceHighest = Color(0xFF36343B);
    const _onSurface = Color(0xFFE6E1E5);
    const _onSurfaceVariant = Color(0xFFCAC4D0);

    return ThemeData(
      useMaterial3: true,
      splashFactory: NoSplash.splashFactory,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,

      colorScheme: scheme.copyWith(
        surfaceTint: Colors.transparent,
        surface: _surface,
        surfaceContainerLowest: const Color(0xFF0F0D13),
        surfaceContainerLow: _surfaceLow,
        surfaceContainer: _surfaceContainer,
        surfaceContainerHigh: _surfaceHigh,
        surfaceContainerHighest: _surfaceHighest,
        onSurface: _onSurface,
        onSurfaceVariant: _onSurfaceVariant,
      ),

      // ── Typography ────────────────────────────────────────────────────────
      textTheme: const TextTheme(
        headlineLarge: TextStyle(fontWeight: FontWeight.w800, fontSize: 32, letterSpacing: -0.5),
        headlineMedium: TextStyle(fontWeight: FontWeight.w800, fontSize: 26, letterSpacing: -0.5),
        headlineSmall: TextStyle(fontWeight: FontWeight.w700, fontSize: 22),
        titleLarge: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
        titleMedium: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        titleSmall: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        labelLarge: TextStyle(fontWeight: FontWeight.w700, letterSpacing: 0.3),
      ),

      // ── AppBar ────────────────────────────────────────────────────────────
      appBarTheme: AppBarTheme(
        backgroundColor: _surfaceLow,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        titleTextStyle: TextStyle(
          color: scheme.primary,
          fontSize: 22,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.5,
        ),
        iconTheme: const IconThemeData(color: _onSurface),
        actionsIconTheme: const IconThemeData(color: _onSurfaceVariant),
      ),

      // ── Bottom NavigationBar ──────────────────────────────────────────────
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: _surfaceLow,
        surfaceTintColor: Colors.transparent,
        elevation: 8,
        height: 64,
        indicatorColor: scheme.primaryContainer,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return TextStyle(
            color: selected ? scheme.onPrimaryContainer : _onSurfaceVariant,
            fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
            fontSize: 12,
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return IconThemeData(
            color: selected ? scheme.onPrimaryContainer : _onSurfaceVariant,
            size: 22,
          );
        }),
      ),

      // ── Cards ─────────────────────────────────────────────────────────────
      cardTheme: CardThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        color: _surfaceHigh,
      ),

      // ── Inputs ────────────────────────────────────────────────────────────
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: _surfaceContainer,
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
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),

      // ── TabBar ────────────────────────────────────────────────────────────
      tabBarTheme: TabBarThemeData(
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: scheme.primaryContainer,
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        labelColor: scheme.onPrimaryContainer,
        unselectedLabelColor: _onSurfaceVariant,
        labelStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
      ),

      // ── Chips ─────────────────────────────────────────────────────────────
      chipTheme: const ChipThemeData(
        showCheckmark: false,
        shape: StadiumBorder(),
      ),

      // ── Buttons ───────────────────────────────────────────────────────────
      filledButtonTheme: FilledButtonThemeData(
        style: ButtonStyle(
          splashFactory: NoSplash.splashFactory,
          overlayColor: noOverlay,
          textStyle: WidgetStateProperty.all(
            const TextStyle(fontWeight: FontWeight.w700),
          ),
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

  // Light mode removed — keeping infrastructure if needed later.
  static ThemeData lightWithSeed(Color seed) => darkWithSeed(seed);
}
