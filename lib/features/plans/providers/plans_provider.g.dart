// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plans_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$allPlansHash() => r'817e0e3be1c8d67fddaec0bd610e77d2e7b45038';

/// All plans visible to the current user: public source plans + user's own
/// non-copy private plans. Copies (source_plan_id IS NOT NULL) and
/// soft-deleted plans are excluded.
///
/// Copied from [allPlans].
@ProviderFor(allPlans)
final allPlansProvider = AutoDisposeFutureProvider<List<WorkoutPlan>>.internal(
  allPlans,
  name: r'allPlansProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$allPlansHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AllPlansRef = AutoDisposeFutureProviderRef<List<WorkoutPlan>>;
String _$planDetailHash() => r'a7ea908735580a18059f2fb0edc3736c699cb0fb';

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

/// Full plan detail including exercises + sets. Works for both source plans
/// and personal copies.
///
/// Copied from [planDetail].
@ProviderFor(planDetail)
const planDetailProvider = PlanDetailFamily();

/// Full plan detail including exercises + sets. Works for both source plans
/// and personal copies.
///
/// Copied from [planDetail].
class PlanDetailFamily extends Family<AsyncValue<WorkoutPlan>> {
  /// Full plan detail including exercises + sets. Works for both source plans
  /// and personal copies.
  ///
  /// Copied from [planDetail].
  const PlanDetailFamily();

  /// Full plan detail including exercises + sets. Works for both source plans
  /// and personal copies.
  ///
  /// Copied from [planDetail].
  PlanDetailProvider call(String planId) {
    return PlanDetailProvider(planId);
  }

  @override
  PlanDetailProvider getProviderOverride(
    covariant PlanDetailProvider provider,
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
  String? get name => r'planDetailProvider';
}

/// Full plan detail including exercises + sets. Works for both source plans
/// and personal copies.
///
/// Copied from [planDetail].
class PlanDetailProvider extends AutoDisposeFutureProvider<WorkoutPlan> {
  /// Full plan detail including exercises + sets. Works for both source plans
  /// and personal copies.
  ///
  /// Copied from [planDetail].
  PlanDetailProvider(String planId)
    : this._internal(
        (ref) => planDetail(ref as PlanDetailRef, planId),
        from: planDetailProvider,
        name: r'planDetailProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$planDetailHash,
        dependencies: PlanDetailFamily._dependencies,
        allTransitiveDependencies: PlanDetailFamily._allTransitiveDependencies,
        planId: planId,
      );

  PlanDetailProvider._internal(
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
    FutureOr<WorkoutPlan> Function(PlanDetailRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: PlanDetailProvider._internal(
        (ref) => create(ref as PlanDetailRef),
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
  AutoDisposeFutureProviderElement<WorkoutPlan> createElement() {
    return _PlanDetailProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PlanDetailProvider && other.planId == planId;
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
mixin PlanDetailRef on AutoDisposeFutureProviderRef<WorkoutPlan> {
  /// The parameter `planId` of this provider.
  String get planId;
}

class _PlanDetailProviderElement
    extends AutoDisposeFutureProviderElement<WorkoutPlan>
    with PlanDetailRef {
  _PlanDetailProviderElement(super.provider);

  @override
  String get planId => (origin as PlanDetailProvider).planId;
}

String _$userFavoritePlanIdsHash() =>
    r'951ffb6cf86de837115590e94a7e96631be8193d';

/// Set of plan IDs the current user has favorited (references source plans only).
///
/// Copied from [userFavoritePlanIds].
@ProviderFor(userFavoritePlanIds)
final userFavoritePlanIdsProvider =
    AutoDisposeFutureProvider<Set<String>>.internal(
      userFavoritePlanIds,
      name: r'userFavoritePlanIdsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$userFavoritePlanIdsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef UserFavoritePlanIdsRef = AutoDisposeFutureProviderRef<Set<String>>;
String _$isPlanFavoritedHash() => r'1ad48418e4d350d079c6f9ec3d221fd05326631e';

/// Whether the current user has favorited a specific source plan.
///
/// Copied from [isPlanFavorited].
@ProviderFor(isPlanFavorited)
const isPlanFavoritedProvider = IsPlanFavoritedFamily();

/// Whether the current user has favorited a specific source plan.
///
/// Copied from [isPlanFavorited].
class IsPlanFavoritedFamily extends Family<AsyncValue<bool>> {
  /// Whether the current user has favorited a specific source plan.
  ///
  /// Copied from [isPlanFavorited].
  const IsPlanFavoritedFamily();

  /// Whether the current user has favorited a specific source plan.
  ///
  /// Copied from [isPlanFavorited].
  IsPlanFavoritedProvider call(String planId) {
    return IsPlanFavoritedProvider(planId);
  }

  @override
  IsPlanFavoritedProvider getProviderOverride(
    covariant IsPlanFavoritedProvider provider,
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
  String? get name => r'isPlanFavoritedProvider';
}

/// Whether the current user has favorited a specific source plan.
///
/// Copied from [isPlanFavorited].
class IsPlanFavoritedProvider extends AutoDisposeFutureProvider<bool> {
  /// Whether the current user has favorited a specific source plan.
  ///
  /// Copied from [isPlanFavorited].
  IsPlanFavoritedProvider(String planId)
    : this._internal(
        (ref) => isPlanFavorited(ref as IsPlanFavoritedRef, planId),
        from: isPlanFavoritedProvider,
        name: r'isPlanFavoritedProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$isPlanFavoritedHash,
        dependencies: IsPlanFavoritedFamily._dependencies,
        allTransitiveDependencies:
            IsPlanFavoritedFamily._allTransitiveDependencies,
        planId: planId,
      );

  IsPlanFavoritedProvider._internal(
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
    FutureOr<bool> Function(IsPlanFavoritedRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: IsPlanFavoritedProvider._internal(
        (ref) => create(ref as IsPlanFavoritedRef),
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
  AutoDisposeFutureProviderElement<bool> createElement() {
    return _IsPlanFavoritedProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is IsPlanFavoritedProvider && other.planId == planId;
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
mixin IsPlanFavoritedRef on AutoDisposeFutureProviderRef<bool> {
  /// The parameter `planId` of this provider.
  String get planId;
}

class _IsPlanFavoritedProviderElement
    extends AutoDisposeFutureProviderElement<bool>
    with IsPlanFavoritedRef {
  _IsPlanFavoritedProviderElement(super.provider);

  @override
  String get planId => (origin as IsPlanFavoritedProvider).planId;
}

String _$gymTeamUserIdHash() => r'8927796d44318b1230e2a7284932b09f33167d28';

/// UUID of the GymTeam App official account (is_official = true on profiles).
/// Returns null if the account has not been created yet.
///
/// Copied from [gymTeamUserId].
@ProviderFor(gymTeamUserId)
final gymTeamUserIdProvider = AutoDisposeFutureProvider<String?>.internal(
  gymTeamUserId,
  name: r'gymTeamUserIdProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$gymTeamUserIdHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GymTeamUserIdRef = AutoDisposeFutureProviderRef<String?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
