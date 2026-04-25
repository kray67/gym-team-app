// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plans_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$myPlansHash() => r'344402d3659e5ff58eced04742723a1a3df195c1';

/// See also [myPlans].
@ProviderFor(myPlans)
final myPlansProvider = AutoDisposeFutureProvider<List<WorkoutPlan>>.internal(
  myPlans,
  name: r'myPlansProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$myPlansHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef MyPlansRef = AutoDisposeFutureProviderRef<List<WorkoutPlan>>;
String _$savedPlansHash() => r'3666455b9e230f163fa6e5ee910fbd534d40bcdc';

/// See also [savedPlans].
@ProviderFor(savedPlans)
final savedPlansProvider =
    AutoDisposeFutureProvider<List<WorkoutPlan>>.internal(
      savedPlans,
      name: r'savedPlansProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$savedPlansHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SavedPlansRef = AutoDisposeFutureProviderRef<List<WorkoutPlan>>;
String _$publicPlansHash() => r'352b061139994c0cd665d6f7acae04bd08caa88c';

/// See also [publicPlans].
@ProviderFor(publicPlans)
final publicPlansProvider =
    AutoDisposeFutureProvider<List<WorkoutPlan>>.internal(
      publicPlans,
      name: r'publicPlansProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$publicPlansHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PublicPlansRef = AutoDisposeFutureProviderRef<List<WorkoutPlan>>;
String _$planDetailHash() => r'2bba72c9314333198b6f85d67ab25637482d2de9';

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

/// See also [planDetail].
@ProviderFor(planDetail)
const planDetailProvider = PlanDetailFamily();

/// See also [planDetail].
class PlanDetailFamily extends Family<AsyncValue<WorkoutPlan>> {
  /// See also [planDetail].
  const PlanDetailFamily();

  /// See also [planDetail].
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

/// See also [planDetail].
class PlanDetailProvider extends AutoDisposeFutureProvider<WorkoutPlan> {
  /// See also [planDetail].
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

String _$isPlanSavedHash() => r'd40cf01e9aaba610d8a6382638d12911c3a83683';

/// See also [isPlanSaved].
@ProviderFor(isPlanSaved)
const isPlanSavedProvider = IsPlanSavedFamily();

/// See also [isPlanSaved].
class IsPlanSavedFamily extends Family<AsyncValue<bool>> {
  /// See also [isPlanSaved].
  const IsPlanSavedFamily();

  /// See also [isPlanSaved].
  IsPlanSavedProvider call(String planId) {
    return IsPlanSavedProvider(planId);
  }

  @override
  IsPlanSavedProvider getProviderOverride(
    covariant IsPlanSavedProvider provider,
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
  String? get name => r'isPlanSavedProvider';
}

/// See also [isPlanSaved].
class IsPlanSavedProvider extends AutoDisposeFutureProvider<bool> {
  /// See also [isPlanSaved].
  IsPlanSavedProvider(String planId)
    : this._internal(
        (ref) => isPlanSaved(ref as IsPlanSavedRef, planId),
        from: isPlanSavedProvider,
        name: r'isPlanSavedProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$isPlanSavedHash,
        dependencies: IsPlanSavedFamily._dependencies,
        allTransitiveDependencies: IsPlanSavedFamily._allTransitiveDependencies,
        planId: planId,
      );

  IsPlanSavedProvider._internal(
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
    FutureOr<bool> Function(IsPlanSavedRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: IsPlanSavedProvider._internal(
        (ref) => create(ref as IsPlanSavedRef),
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
    return _IsPlanSavedProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is IsPlanSavedProvider && other.planId == planId;
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
mixin IsPlanSavedRef on AutoDisposeFutureProviderRef<bool> {
  /// The parameter `planId` of this provider.
  String get planId;
}

class _IsPlanSavedProviderElement extends AutoDisposeFutureProviderElement<bool>
    with IsPlanSavedRef {
  _IsPlanSavedProviderElement(super.provider);

  @override
  String get planId => (origin as IsPlanSavedProvider).planId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
