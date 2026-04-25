// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$activityFeedHash() => r'0d43dffe9bd2a346fec60dee3d13c5585e1ae3c0';

/// See also [activityFeed].
@ProviderFor(activityFeed)
final activityFeedProvider = AutoDisposeFutureProvider<List<FeedItem>>.internal(
  activityFeed,
  name: r'activityFeedProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$activityFeedHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ActivityFeedRef = AutoDisposeFutureProviderRef<List<FeedItem>>;
String _$workoutFeedItemIdHash() => r'89bb1835621ca11a2ac1a6ee6467757522b1966f';

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

/// Returns the activity_feed row id for a given workout session (if one exists).
///
/// Copied from [workoutFeedItemId].
@ProviderFor(workoutFeedItemId)
const workoutFeedItemIdProvider = WorkoutFeedItemIdFamily();

/// Returns the activity_feed row id for a given workout session (if one exists).
///
/// Copied from [workoutFeedItemId].
class WorkoutFeedItemIdFamily extends Family<AsyncValue<String?>> {
  /// Returns the activity_feed row id for a given workout session (if one exists).
  ///
  /// Copied from [workoutFeedItemId].
  const WorkoutFeedItemIdFamily();

  /// Returns the activity_feed row id for a given workout session (if one exists).
  ///
  /// Copied from [workoutFeedItemId].
  WorkoutFeedItemIdProvider call(String sessionId) {
    return WorkoutFeedItemIdProvider(sessionId);
  }

  @override
  WorkoutFeedItemIdProvider getProviderOverride(
    covariant WorkoutFeedItemIdProvider provider,
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
  String? get name => r'workoutFeedItemIdProvider';
}

/// Returns the activity_feed row id for a given workout session (if one exists).
///
/// Copied from [workoutFeedItemId].
class WorkoutFeedItemIdProvider extends AutoDisposeFutureProvider<String?> {
  /// Returns the activity_feed row id for a given workout session (if one exists).
  ///
  /// Copied from [workoutFeedItemId].
  WorkoutFeedItemIdProvider(String sessionId)
    : this._internal(
        (ref) => workoutFeedItemId(ref as WorkoutFeedItemIdRef, sessionId),
        from: workoutFeedItemIdProvider,
        name: r'workoutFeedItemIdProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$workoutFeedItemIdHash,
        dependencies: WorkoutFeedItemIdFamily._dependencies,
        allTransitiveDependencies:
            WorkoutFeedItemIdFamily._allTransitiveDependencies,
        sessionId: sessionId,
      );

  WorkoutFeedItemIdProvider._internal(
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
    FutureOr<String?> Function(WorkoutFeedItemIdRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: WorkoutFeedItemIdProvider._internal(
        (ref) => create(ref as WorkoutFeedItemIdRef),
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
  AutoDisposeFutureProviderElement<String?> createElement() {
    return _WorkoutFeedItemIdProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is WorkoutFeedItemIdProvider && other.sessionId == sessionId;
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
mixin WorkoutFeedItemIdRef on AutoDisposeFutureProviderRef<String?> {
  /// The parameter `sessionId` of this provider.
  String get sessionId;
}

class _WorkoutFeedItemIdProviderElement
    extends AutoDisposeFutureProviderElement<String?>
    with WorkoutFeedItemIdRef {
  _WorkoutFeedItemIdProviderElement(super.provider);

  @override
  String get sessionId => (origin as WorkoutFeedItemIdProvider).sessionId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
