// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reactions_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$feedReactionsHash() => r'4014de1b50fa120d87c133ec02ad60b893cad34b';

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

/// See also [feedReactions].
@ProviderFor(feedReactions)
const feedReactionsProvider = FeedReactionsFamily();

/// See also [feedReactions].
class FeedReactionsFamily extends Family<AsyncValue<List<FeedReaction>>> {
  /// See also [feedReactions].
  const FeedReactionsFamily();

  /// See also [feedReactions].
  FeedReactionsProvider call(String feedItemId) {
    return FeedReactionsProvider(feedItemId);
  }

  @override
  FeedReactionsProvider getProviderOverride(
    covariant FeedReactionsProvider provider,
  ) {
    return call(provider.feedItemId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'feedReactionsProvider';
}

/// See also [feedReactions].
class FeedReactionsProvider
    extends AutoDisposeFutureProvider<List<FeedReaction>> {
  /// See also [feedReactions].
  FeedReactionsProvider(String feedItemId)
    : this._internal(
        (ref) => feedReactions(ref as FeedReactionsRef, feedItemId),
        from: feedReactionsProvider,
        name: r'feedReactionsProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$feedReactionsHash,
        dependencies: FeedReactionsFamily._dependencies,
        allTransitiveDependencies:
            FeedReactionsFamily._allTransitiveDependencies,
        feedItemId: feedItemId,
      );

  FeedReactionsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.feedItemId,
  }) : super.internal();

  final String feedItemId;

  @override
  Override overrideWith(
    FutureOr<List<FeedReaction>> Function(FeedReactionsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FeedReactionsProvider._internal(
        (ref) => create(ref as FeedReactionsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        feedItemId: feedItemId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<FeedReaction>> createElement() {
    return _FeedReactionsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FeedReactionsProvider && other.feedItemId == feedItemId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, feedItemId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FeedReactionsRef on AutoDisposeFutureProviderRef<List<FeedReaction>> {
  /// The parameter `feedItemId` of this provider.
  String get feedItemId;
}

class _FeedReactionsProviderElement
    extends AutoDisposeFutureProviderElement<List<FeedReaction>>
    with FeedReactionsRef {
  _FeedReactionsProviderElement(super.provider);

  @override
  String get feedItemId => (origin as FeedReactionsProvider).feedItemId;
}

String _$reactionsNotifierHash() => r'c8feba9279621396239a210d550f61a5a090e8e8';

/// See also [ReactionsNotifier].
@ProviderFor(ReactionsNotifier)
final reactionsNotifierProvider =
    AutoDisposeNotifierProvider<ReactionsNotifier, void>.internal(
      ReactionsNotifier.new,
      name: r'reactionsNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$reactionsNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ReactionsNotifier = AutoDisposeNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
