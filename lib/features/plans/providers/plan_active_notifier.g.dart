// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plan_active_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$activePlanHash() => r'1f42fc1fcca220ac05621860c5e5d77637fe7036';

/// Fetches the current user's active plan (full detail with exercises + sets).
/// Returns null when no active plan is set.
///
/// Copied from [activePlan].
@ProviderFor(activePlan)
final activePlanProvider = AutoDisposeFutureProvider<WorkoutPlan?>.internal(
  activePlan,
  name: r'activePlanProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$activePlanHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ActivePlanRef = AutoDisposeFutureProviderRef<WorkoutPlan?>;
String _$userPlan1rmHash() => r'6a3bf5d5134942163a79308bae592d98e4c02a7e';

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

/// Fetches all stored 1RM values for the current user + plan.
/// Returns a map of exerciseId → oneRmKg.
///
/// Copied from [userPlan1rm].
@ProviderFor(userPlan1rm)
const userPlan1rmProvider = UserPlan1rmFamily();

/// Fetches all stored 1RM values for the current user + plan.
/// Returns a map of exerciseId → oneRmKg.
///
/// Copied from [userPlan1rm].
class UserPlan1rmFamily extends Family<AsyncValue<Map<String, double>>> {
  /// Fetches all stored 1RM values for the current user + plan.
  /// Returns a map of exerciseId → oneRmKg.
  ///
  /// Copied from [userPlan1rm].
  const UserPlan1rmFamily();

  /// Fetches all stored 1RM values for the current user + plan.
  /// Returns a map of exerciseId → oneRmKg.
  ///
  /// Copied from [userPlan1rm].
  UserPlan1rmProvider call(String planId) {
    return UserPlan1rmProvider(planId);
  }

  @override
  UserPlan1rmProvider getProviderOverride(
    covariant UserPlan1rmProvider provider,
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
  String? get name => r'userPlan1rmProvider';
}

/// Fetches all stored 1RM values for the current user + plan.
/// Returns a map of exerciseId → oneRmKg.
///
/// Copied from [userPlan1rm].
class UserPlan1rmProvider
    extends AutoDisposeFutureProvider<Map<String, double>> {
  /// Fetches all stored 1RM values for the current user + plan.
  /// Returns a map of exerciseId → oneRmKg.
  ///
  /// Copied from [userPlan1rm].
  UserPlan1rmProvider(String planId)
    : this._internal(
        (ref) => userPlan1rm(ref as UserPlan1rmRef, planId),
        from: userPlan1rmProvider,
        name: r'userPlan1rmProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$userPlan1rmHash,
        dependencies: UserPlan1rmFamily._dependencies,
        allTransitiveDependencies: UserPlan1rmFamily._allTransitiveDependencies,
        planId: planId,
      );

  UserPlan1rmProvider._internal(
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
    FutureOr<Map<String, double>> Function(UserPlan1rmRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UserPlan1rmProvider._internal(
        (ref) => create(ref as UserPlan1rmRef),
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
  AutoDisposeFutureProviderElement<Map<String, double>> createElement() {
    return _UserPlan1rmProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UserPlan1rmProvider && other.planId == planId;
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
mixin UserPlan1rmRef on AutoDisposeFutureProviderRef<Map<String, double>> {
  /// The parameter `planId` of this provider.
  String get planId;
}

class _UserPlan1rmProviderElement
    extends AutoDisposeFutureProviderElement<Map<String, double>>
    with UserPlan1rmRef {
  _UserPlan1rmProviderElement(super.provider);

  @override
  String get planId => (origin as UserPlan1rmProvider).planId;
}

String _$planActiveNotifierHash() =>
    r'123b8ddbc43ab37207532a51f1ee8d8457ba683a';

/// See also [PlanActiveNotifier].
@ProviderFor(PlanActiveNotifier)
final planActiveNotifierProvider =
    AutoDisposeNotifierProvider<PlanActiveNotifier, bool>.internal(
      PlanActiveNotifier.new,
      name: r'planActiveNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$planActiveNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$PlanActiveNotifier = AutoDisposeNotifier<bool>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
