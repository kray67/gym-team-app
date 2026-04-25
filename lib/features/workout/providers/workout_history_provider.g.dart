// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_history_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$workoutHistoryHash() => r'c8a26ed11477fa64444696a909b2a2aca6602cc0';

/// See also [workoutHistory].
@ProviderFor(workoutHistory)
final workoutHistoryProvider =
    AutoDisposeFutureProvider<List<WorkoutSession>>.internal(
      workoutHistory,
      name: r'workoutHistoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$workoutHistoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef WorkoutHistoryRef = AutoDisposeFutureProviderRef<List<WorkoutSession>>;
String _$workoutDetailHash() => r'c3ae7760440a630be3a9197d4235fc4f3ee001c5';

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

/// See also [workoutDetail].
@ProviderFor(workoutDetail)
const workoutDetailProvider = WorkoutDetailFamily();

/// See also [workoutDetail].
class WorkoutDetailFamily extends Family<AsyncValue<WorkoutSession>> {
  /// See also [workoutDetail].
  const WorkoutDetailFamily();

  /// See also [workoutDetail].
  WorkoutDetailProvider call(String sessionId) {
    return WorkoutDetailProvider(sessionId);
  }

  @override
  WorkoutDetailProvider getProviderOverride(
    covariant WorkoutDetailProvider provider,
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
  String? get name => r'workoutDetailProvider';
}

/// See also [workoutDetail].
class WorkoutDetailProvider extends AutoDisposeFutureProvider<WorkoutSession> {
  /// See also [workoutDetail].
  WorkoutDetailProvider(String sessionId)
    : this._internal(
        (ref) => workoutDetail(ref as WorkoutDetailRef, sessionId),
        from: workoutDetailProvider,
        name: r'workoutDetailProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$workoutDetailHash,
        dependencies: WorkoutDetailFamily._dependencies,
        allTransitiveDependencies:
            WorkoutDetailFamily._allTransitiveDependencies,
        sessionId: sessionId,
      );

  WorkoutDetailProvider._internal(
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
    FutureOr<WorkoutSession> Function(WorkoutDetailRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: WorkoutDetailProvider._internal(
        (ref) => create(ref as WorkoutDetailRef),
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
  AutoDisposeFutureProviderElement<WorkoutSession> createElement() {
    return _WorkoutDetailProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is WorkoutDetailProvider && other.sessionId == sessionId;
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
mixin WorkoutDetailRef on AutoDisposeFutureProviderRef<WorkoutSession> {
  /// The parameter `sessionId` of this provider.
  String get sessionId;
}

class _WorkoutDetailProviderElement
    extends AutoDisposeFutureProviderElement<WorkoutSession>
    with WorkoutDetailRef {
  _WorkoutDetailProviderElement(super.provider);

  @override
  String get sessionId => (origin as WorkoutDetailProvider).sessionId;
}

String _$previousPerformanceHash() =>
    r'c5a3b6e1d6640bb1c705462909f324990e6db2e2';

/// Returns a formatted string like "90 kg × 8" or "× 12" for the last time
/// the current user performed [exerciseId]. Returns null if never done.
///
/// Copied from [previousPerformance].
@ProviderFor(previousPerformance)
const previousPerformanceProvider = PreviousPerformanceFamily();

/// Returns a formatted string like "90 kg × 8" or "× 12" for the last time
/// the current user performed [exerciseId]. Returns null if never done.
///
/// Copied from [previousPerformance].
class PreviousPerformanceFamily extends Family<AsyncValue<String?>> {
  /// Returns a formatted string like "90 kg × 8" or "× 12" for the last time
  /// the current user performed [exerciseId]. Returns null if never done.
  ///
  /// Copied from [previousPerformance].
  const PreviousPerformanceFamily();

  /// Returns a formatted string like "90 kg × 8" or "× 12" for the last time
  /// the current user performed [exerciseId]. Returns null if never done.
  ///
  /// Copied from [previousPerformance].
  PreviousPerformanceProvider call(String exerciseId) {
    return PreviousPerformanceProvider(exerciseId);
  }

  @override
  PreviousPerformanceProvider getProviderOverride(
    covariant PreviousPerformanceProvider provider,
  ) {
    return call(provider.exerciseId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'previousPerformanceProvider';
}

/// Returns a formatted string like "90 kg × 8" or "× 12" for the last time
/// the current user performed [exerciseId]. Returns null if never done.
///
/// Copied from [previousPerformance].
class PreviousPerformanceProvider extends AutoDisposeFutureProvider<String?> {
  /// Returns a formatted string like "90 kg × 8" or "× 12" for the last time
  /// the current user performed [exerciseId]. Returns null if never done.
  ///
  /// Copied from [previousPerformance].
  PreviousPerformanceProvider(String exerciseId)
    : this._internal(
        (ref) => previousPerformance(ref as PreviousPerformanceRef, exerciseId),
        from: previousPerformanceProvider,
        name: r'previousPerformanceProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$previousPerformanceHash,
        dependencies: PreviousPerformanceFamily._dependencies,
        allTransitiveDependencies:
            PreviousPerformanceFamily._allTransitiveDependencies,
        exerciseId: exerciseId,
      );

  PreviousPerformanceProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.exerciseId,
  }) : super.internal();

  final String exerciseId;

  @override
  Override overrideWith(
    FutureOr<String?> Function(PreviousPerformanceRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: PreviousPerformanceProvider._internal(
        (ref) => create(ref as PreviousPerformanceRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        exerciseId: exerciseId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<String?> createElement() {
    return _PreviousPerformanceProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PreviousPerformanceProvider &&
        other.exerciseId == exerciseId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, exerciseId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin PreviousPerformanceRef on AutoDisposeFutureProviderRef<String?> {
  /// The parameter `exerciseId` of this provider.
  String get exerciseId;
}

class _PreviousPerformanceProviderElement
    extends AutoDisposeFutureProviderElement<String?>
    with PreviousPerformanceRef {
  _PreviousPerformanceProviderElement(super.provider);

  @override
  String get exerciseId => (origin as PreviousPerformanceProvider).exerciseId;
}

String _$planCompletedSessionsHash() =>
    r'dbe59b641ad92c1a79b5821eeadb9ffd5b18b5ee';

/// Returns the set of (weekNumber, sessionNumber) pairs that have been
/// completed for the given plan by the current user.
/// Only counts sessions started after the most recent plan restart (if any).
///
/// Copied from [planCompletedSessions].
@ProviderFor(planCompletedSessions)
const planCompletedSessionsProvider = PlanCompletedSessionsFamily();

/// Returns the set of (weekNumber, sessionNumber) pairs that have been
/// completed for the given plan by the current user.
/// Only counts sessions started after the most recent plan restart (if any).
///
/// Copied from [planCompletedSessions].
class PlanCompletedSessionsFamily extends Family<AsyncValue<Set<(int, int)>>> {
  /// Returns the set of (weekNumber, sessionNumber) pairs that have been
  /// completed for the given plan by the current user.
  /// Only counts sessions started after the most recent plan restart (if any).
  ///
  /// Copied from [planCompletedSessions].
  const PlanCompletedSessionsFamily();

  /// Returns the set of (weekNumber, sessionNumber) pairs that have been
  /// completed for the given plan by the current user.
  /// Only counts sessions started after the most recent plan restart (if any).
  ///
  /// Copied from [planCompletedSessions].
  PlanCompletedSessionsProvider call(String planId) {
    return PlanCompletedSessionsProvider(planId);
  }

  @override
  PlanCompletedSessionsProvider getProviderOverride(
    covariant PlanCompletedSessionsProvider provider,
  ) {
    return call(provider.planId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'planCompletedSessionsProvider';
}

/// Returns the set of (weekNumber, sessionNumber) pairs that have been
/// completed for the given plan by the current user.
/// Only counts sessions started after the most recent plan restart (if any).
///
/// Copied from [planCompletedSessions].
class PlanCompletedSessionsProvider
    extends AutoDisposeFutureProvider<Set<(int, int)>> {
  /// Returns the set of (weekNumber, sessionNumber) pairs that have been
  /// completed for the given plan by the current user.
  /// Only counts sessions started after the most recent plan restart (if any).
  ///
  /// Copied from [planCompletedSessions].
  PlanCompletedSessionsProvider(String planId)
    : this._internal(
        (ref) => planCompletedSessions(ref as PlanCompletedSessionsRef, planId),
        from: planCompletedSessionsProvider,
        name: r'planCompletedSessionsProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$planCompletedSessionsHash,
        dependencies: PlanCompletedSessionsFamily._dependencies,
        allTransitiveDependencies:
            PlanCompletedSessionsFamily._allTransitiveDependencies,
        planId: planId,
      );

  PlanCompletedSessionsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.planId,
  }) : super.internal();

  final String planId;

  @override
  Override overrideWith(
    FutureOr<Set<(int, int)>> Function(PlanCompletedSessionsRef provider)
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: PlanCompletedSessionsProvider._internal(
        (ref) => create(ref as PlanCompletedSessionsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        planId: planId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Set<(int, int)>> createElement() {
    return _PlanCompletedSessionsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PlanCompletedSessionsProvider && other.planId == planId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, planId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin PlanCompletedSessionsRef
    on AutoDisposeFutureProviderRef<Set<(int, int)>> {
  /// The parameter `planId` of this provider.
  String get planId;
}

class _PlanCompletedSessionsProviderElement
    extends AutoDisposeFutureProviderElement<Set<(int, int)>>
    with PlanCompletedSessionsRef {
  _PlanCompletedSessionsProviderElement(super.provider);

  @override
  String get planId => (origin as PlanCompletedSessionsProvider).planId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
