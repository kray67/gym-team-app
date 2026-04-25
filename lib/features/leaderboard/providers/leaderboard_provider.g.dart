// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leaderboard_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$attendanceLeaderboardHash() =>
    r'128e802a122c8c97141e80c7a50aab07fa299061';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [attendanceLeaderboard].
@ProviderFor(attendanceLeaderboard)
const attendanceLeaderboardProvider = AttendanceLeaderboardFamily();

/// See also [attendanceLeaderboard].
class AttendanceLeaderboardFamily
    extends Family<AsyncValue<List<LeaderboardEntry>>> {
  /// See also [attendanceLeaderboard].
  const AttendanceLeaderboardFamily();

  /// See also [attendanceLeaderboard].
  AttendanceLeaderboardProvider call(LeaderboardPeriod period) {
    return AttendanceLeaderboardProvider(period);
  }

  @override
  AttendanceLeaderboardProvider getProviderOverride(
    covariant AttendanceLeaderboardProvider provider,
  ) {
    return call(provider.period);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'attendanceLeaderboardProvider';
}

/// See also [attendanceLeaderboard].
class AttendanceLeaderboardProvider
    extends AutoDisposeFutureProvider<List<LeaderboardEntry>> {
  /// See also [attendanceLeaderboard].
  AttendanceLeaderboardProvider(LeaderboardPeriod period)
    : this._internal(
        (ref) => attendanceLeaderboard(ref as AttendanceLeaderboardRef, period),
        from: attendanceLeaderboardProvider,
        name: r'attendanceLeaderboardProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$attendanceLeaderboardHash,
        dependencies: AttendanceLeaderboardFamily._dependencies,
        allTransitiveDependencies:
            AttendanceLeaderboardFamily._allTransitiveDependencies,
        period: period,
      );

  AttendanceLeaderboardProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.period,
  }) : super.internal();

  final LeaderboardPeriod period;

  @override
  Override overrideWith(
    FutureOr<List<LeaderboardEntry>> Function(AttendanceLeaderboardRef provider)
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AttendanceLeaderboardProvider._internal(
        (ref) => create(ref as AttendanceLeaderboardRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        period: period,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<LeaderboardEntry>> createElement() {
    return _AttendanceLeaderboardProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AttendanceLeaderboardProvider && other.period == period;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, period.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin AttendanceLeaderboardRef
    on AutoDisposeFutureProviderRef<List<LeaderboardEntry>> {
  /// The parameter `period` of this provider.
  LeaderboardPeriod get period;
}

class _AttendanceLeaderboardProviderElement
    extends AutoDisposeFutureProviderElement<List<LeaderboardEntry>>
    with AttendanceLeaderboardRef {
  _AttendanceLeaderboardProviderElement(super.provider);

  @override
  LeaderboardPeriod get period =>
      (origin as AttendanceLeaderboardProvider).period;
}

String _$prLeaderboardHash() => r'de8d61b112d900a49af00f04f2cbf47d795f0aab';

/// See also [prLeaderboard].
@ProviderFor(prLeaderboard)
const prLeaderboardProvider = PrLeaderboardFamily();

/// See also [prLeaderboard].
class PrLeaderboardFamily extends Family<AsyncValue<List<LeaderboardEntry>>> {
  /// See also [prLeaderboard].
  const PrLeaderboardFamily();

  /// See also [prLeaderboard].
  PrLeaderboardProvider call(LeaderboardPeriod period) {
    return PrLeaderboardProvider(period);
  }

  @override
  PrLeaderboardProvider getProviderOverride(
    covariant PrLeaderboardProvider provider,
  ) {
    return call(provider.period);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'prLeaderboardProvider';
}

/// See also [prLeaderboard].
class PrLeaderboardProvider
    extends AutoDisposeFutureProvider<List<LeaderboardEntry>> {
  /// See also [prLeaderboard].
  PrLeaderboardProvider(LeaderboardPeriod period)
    : this._internal(
        (ref) => prLeaderboard(ref as PrLeaderboardRef, period),
        from: prLeaderboardProvider,
        name: r'prLeaderboardProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$prLeaderboardHash,
        dependencies: PrLeaderboardFamily._dependencies,
        allTransitiveDependencies:
            PrLeaderboardFamily._allTransitiveDependencies,
        period: period,
      );

  PrLeaderboardProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.period,
  }) : super.internal();

  final LeaderboardPeriod period;

  @override
  Override overrideWith(
    FutureOr<List<LeaderboardEntry>> Function(PrLeaderboardRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: PrLeaderboardProvider._internal(
        (ref) => create(ref as PrLeaderboardRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        period: period,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<LeaderboardEntry>> createElement() {
    return _PrLeaderboardProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PrLeaderboardProvider && other.period == period;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, period.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin PrLeaderboardRef on AutoDisposeFutureProviderRef<List<LeaderboardEntry>> {
  /// The parameter `period` of this provider.
  LeaderboardPeriod get period;
}

class _PrLeaderboardProviderElement
    extends AutoDisposeFutureProviderElement<List<LeaderboardEntry>>
    with PrLeaderboardRef {
  _PrLeaderboardProviderElement(super.provider);

  @override
  LeaderboardPeriod get period => (origin as PrLeaderboardProvider).period;
}

String _$exerciseLeaderboardHash() =>
    r'3cef6d46201424e2f5b8bd22f0050f8dfbca935b';

/// See also [exerciseLeaderboard].
@ProviderFor(exerciseLeaderboard)
const exerciseLeaderboardProvider = ExerciseLeaderboardFamily();

/// See also [exerciseLeaderboard].
class ExerciseLeaderboardFamily
    extends Family<AsyncValue<List<LeaderboardEntry>>> {
  /// See also [exerciseLeaderboard].
  const ExerciseLeaderboardFamily();

  /// See also [exerciseLeaderboard].
  ExerciseLeaderboardProvider call(String exerciseId, String recordType) {
    return ExerciseLeaderboardProvider(exerciseId, recordType);
  }

  @override
  ExerciseLeaderboardProvider getProviderOverride(
    covariant ExerciseLeaderboardProvider provider,
  ) {
    return call(provider.exerciseId, provider.recordType);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'exerciseLeaderboardProvider';
}

/// See also [exerciseLeaderboard].
class ExerciseLeaderboardProvider
    extends AutoDisposeFutureProvider<List<LeaderboardEntry>> {
  /// See also [exerciseLeaderboard].
  ExerciseLeaderboardProvider(String exerciseId, String recordType)
    : this._internal(
        (ref) => exerciseLeaderboard(
          ref as ExerciseLeaderboardRef,
          exerciseId,
          recordType,
        ),
        from: exerciseLeaderboardProvider,
        name: r'exerciseLeaderboardProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$exerciseLeaderboardHash,
        dependencies: ExerciseLeaderboardFamily._dependencies,
        allTransitiveDependencies:
            ExerciseLeaderboardFamily._allTransitiveDependencies,
        exerciseId: exerciseId,
        recordType: recordType,
      );

  ExerciseLeaderboardProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.exerciseId,
    required this.recordType,
  }) : super.internal();

  final String exerciseId;
  final String recordType;

  @override
  Override overrideWith(
    FutureOr<List<LeaderboardEntry>> Function(ExerciseLeaderboardRef provider)
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ExerciseLeaderboardProvider._internal(
        (ref) => create(ref as ExerciseLeaderboardRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        exerciseId: exerciseId,
        recordType: recordType,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<LeaderboardEntry>> createElement() {
    return _ExerciseLeaderboardProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ExerciseLeaderboardProvider &&
        other.exerciseId == exerciseId &&
        other.recordType == recordType;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, exerciseId.hashCode);
    hash = _SystemHash.combine(hash, recordType.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ExerciseLeaderboardRef
    on AutoDisposeFutureProviderRef<List<LeaderboardEntry>> {
  /// The parameter `exerciseId` of this provider.
  String get exerciseId;

  /// The parameter `recordType` of this provider.
  String get recordType;
}

class _ExerciseLeaderboardProviderElement
    extends AutoDisposeFutureProviderElement<List<LeaderboardEntry>>
    with ExerciseLeaderboardRef {
  _ExerciseLeaderboardProviderElement(super.provider);

  @override
  String get exerciseId => (origin as ExerciseLeaderboardProvider).exerciseId;
  @override
  String get recordType => (origin as ExerciseLeaderboardProvider).recordType;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
