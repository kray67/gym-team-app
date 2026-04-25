// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_records_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userExerciseRecordsHash() =>
    r'6610cfd0c76fb0fbe8ed4496d1211fb70a879289';

/// All personal records for the current user.
///
/// Returns a nested map: exerciseId → recordType → current best value.
/// Used in [ActiveWorkoutScreen] to compute live PR badges during a workout.
///
/// Copied from [userExerciseRecords].
@ProviderFor(userExerciseRecords)
final userExerciseRecordsProvider =
    AutoDisposeFutureProvider<Map<String, Map<String, double>>>.internal(
      userExerciseRecords,
      name: r'userExerciseRecordsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$userExerciseRecordsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef UserExerciseRecordsRef =
    AutoDisposeFutureProviderRef<Map<String, Map<String, double>>>;
String _$sessionNewRecordsHash() => r'dd7f60bdbf16b55b1a65590f5c7050bb5efe20f5';

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

/// Records that were first set (or improved) during a specific workout session.
///
/// Used in [WorkoutSummaryScreen] to show a "New Records" section and in
/// [WorkoutDetailScreen] to badge the specific set rows.
///
/// Copied from [sessionNewRecords].
@ProviderFor(sessionNewRecords)
const sessionNewRecordsProvider = SessionNewRecordsFamily();

/// Records that were first set (or improved) during a specific workout session.
///
/// Used in [WorkoutSummaryScreen] to show a "New Records" section and in
/// [WorkoutDetailScreen] to badge the specific set rows.
///
/// Copied from [sessionNewRecords].
class SessionNewRecordsFamily extends Family<AsyncValue<List<ExerciseRecord>>> {
  /// Records that were first set (or improved) during a specific workout session.
  ///
  /// Used in [WorkoutSummaryScreen] to show a "New Records" section and in
  /// [WorkoutDetailScreen] to badge the specific set rows.
  ///
  /// Copied from [sessionNewRecords].
  const SessionNewRecordsFamily();

  /// Records that were first set (or improved) during a specific workout session.
  ///
  /// Used in [WorkoutSummaryScreen] to show a "New Records" section and in
  /// [WorkoutDetailScreen] to badge the specific set rows.
  ///
  /// Copied from [sessionNewRecords].
  SessionNewRecordsProvider call(String sessionId) {
    return SessionNewRecordsProvider(sessionId);
  }

  @override
  SessionNewRecordsProvider getProviderOverride(
    covariant SessionNewRecordsProvider provider,
  ) {
    return call(provider.sessionId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'sessionNewRecordsProvider';
}

/// Records that were first set (or improved) during a specific workout session.
///
/// Used in [WorkoutSummaryScreen] to show a "New Records" section and in
/// [WorkoutDetailScreen] to badge the specific set rows.
///
/// Copied from [sessionNewRecords].
class SessionNewRecordsProvider
    extends AutoDisposeFutureProvider<List<ExerciseRecord>> {
  /// Records that were first set (or improved) during a specific workout session.
  ///
  /// Used in [WorkoutSummaryScreen] to show a "New Records" section and in
  /// [WorkoutDetailScreen] to badge the specific set rows.
  ///
  /// Copied from [sessionNewRecords].
  SessionNewRecordsProvider(String sessionId)
    : this._internal(
        (ref) => sessionNewRecords(ref as SessionNewRecordsRef, sessionId),
        from: sessionNewRecordsProvider,
        name: r'sessionNewRecordsProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$sessionNewRecordsHash,
        dependencies: SessionNewRecordsFamily._dependencies,
        allTransitiveDependencies:
            SessionNewRecordsFamily._allTransitiveDependencies,
        sessionId: sessionId,
      );

  SessionNewRecordsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.sessionId,
  }) : super.internal();

  final String sessionId;

  @override
  Override overrideWith(
    FutureOr<List<ExerciseRecord>> Function(SessionNewRecordsRef provider)
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SessionNewRecordsProvider._internal(
        (ref) => create(ref as SessionNewRecordsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        sessionId: sessionId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<ExerciseRecord>> createElement() {
    return _SessionNewRecordsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SessionNewRecordsProvider && other.sessionId == sessionId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, sessionId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SessionNewRecordsRef
    on AutoDisposeFutureProviderRef<List<ExerciseRecord>> {
  /// The parameter `sessionId` of this provider.
  String get sessionId;
}

class _SessionNewRecordsProviderElement
    extends AutoDisposeFutureProviderElement<List<ExerciseRecord>>
    with SessionNewRecordsRef {
  _SessionNewRecordsProviderElement(super.provider);

  @override
  String get sessionId => (origin as SessionNewRecordsProvider).sessionId;
}

String _$sessionPrSetIdsHash() => r'77400890d3edba82a7ebc83587281b74d1d3a622';

/// Set IDs (session_sets.id) that achieved a PR during [sessionId].
///
/// Used in [WorkoutDetailScreen] to badge individual set rows.
///
/// Copied from [sessionPrSetIds].
@ProviderFor(sessionPrSetIds)
const sessionPrSetIdsProvider = SessionPrSetIdsFamily();

/// Set IDs (session_sets.id) that achieved a PR during [sessionId].
///
/// Used in [WorkoutDetailScreen] to badge individual set rows.
///
/// Copied from [sessionPrSetIds].
class SessionPrSetIdsFamily extends Family<AsyncValue<Set<String>>> {
  /// Set IDs (session_sets.id) that achieved a PR during [sessionId].
  ///
  /// Used in [WorkoutDetailScreen] to badge individual set rows.
  ///
  /// Copied from [sessionPrSetIds].
  const SessionPrSetIdsFamily();

  /// Set IDs (session_sets.id) that achieved a PR during [sessionId].
  ///
  /// Used in [WorkoutDetailScreen] to badge individual set rows.
  ///
  /// Copied from [sessionPrSetIds].
  SessionPrSetIdsProvider call(String sessionId) {
    return SessionPrSetIdsProvider(sessionId);
  }

  @override
  SessionPrSetIdsProvider getProviderOverride(
    covariant SessionPrSetIdsProvider provider,
  ) {
    return call(provider.sessionId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'sessionPrSetIdsProvider';
}

/// Set IDs (session_sets.id) that achieved a PR during [sessionId].
///
/// Used in [WorkoutDetailScreen] to badge individual set rows.
///
/// Copied from [sessionPrSetIds].
class SessionPrSetIdsProvider extends AutoDisposeFutureProvider<Set<String>> {
  /// Set IDs (session_sets.id) that achieved a PR during [sessionId].
  ///
  /// Used in [WorkoutDetailScreen] to badge individual set rows.
  ///
  /// Copied from [sessionPrSetIds].
  SessionPrSetIdsProvider(String sessionId)
    : this._internal(
        (ref) => sessionPrSetIds(ref as SessionPrSetIdsRef, sessionId),
        from: sessionPrSetIdsProvider,
        name: r'sessionPrSetIdsProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$sessionPrSetIdsHash,
        dependencies: SessionPrSetIdsFamily._dependencies,
        allTransitiveDependencies:
            SessionPrSetIdsFamily._allTransitiveDependencies,
        sessionId: sessionId,
      );

  SessionPrSetIdsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.sessionId,
  }) : super.internal();

  final String sessionId;

  @override
  Override overrideWith(
    FutureOr<Set<String>> Function(SessionPrSetIdsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SessionPrSetIdsProvider._internal(
        (ref) => create(ref as SessionPrSetIdsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        sessionId: sessionId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Set<String>> createElement() {
    return _SessionPrSetIdsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SessionPrSetIdsProvider && other.sessionId == sessionId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, sessionId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SessionPrSetIdsRef on AutoDisposeFutureProviderRef<Set<String>> {
  /// The parameter `sessionId` of this provider.
  String get sessionId;
}

class _SessionPrSetIdsProviderElement
    extends AutoDisposeFutureProviderElement<Set<String>>
    with SessionPrSetIdsRef {
  _SessionPrSetIdsProviderElement(super.provider);

  @override
  String get sessionId => (origin as SessionPrSetIdsProvider).sessionId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
