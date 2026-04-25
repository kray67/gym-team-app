// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_color_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$themeColorNotifierHash() =>
    r'73aa41f370307e98a75ed4e18aaa9ef0f459fa29';

/// Persists and provides the user's chosen accent color name
/// ('purple' | 'blue' | 'yellow' | 'orange').
/// Re-fetches automatically when auth state changes.
///
/// Copied from [ThemeColorNotifier].
@ProviderFor(ThemeColorNotifier)
final themeColorNotifierProvider =
    AsyncNotifierProvider<ThemeColorNotifier, String>.internal(
      ThemeColorNotifier.new,
      name: r'themeColorNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$themeColorNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ThemeColorNotifier = AsyncNotifier<String>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
