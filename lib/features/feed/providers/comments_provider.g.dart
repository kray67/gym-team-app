// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comments_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$feedCommentsHash() => r'27f2c4b65f8a380c9ba368396279005c83c50a6d';

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

/// See also [feedComments].
@ProviderFor(feedComments)
const feedCommentsProvider = FeedCommentsFamily();

/// See also [feedComments].
class FeedCommentsFamily extends Family<AsyncValue<List<FeedComment>>> {
  /// See also [feedComments].
  const FeedCommentsFamily();

  /// See also [feedComments].
  FeedCommentsProvider call(String feedItemId) {
    return FeedCommentsProvider(feedItemId);
  }

  @override
  FeedCommentsProvider getProviderOverride(
    covariant FeedCommentsProvider provider,
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
  String? get name => r'feedCommentsProvider';
}

/// See also [feedComments].
class FeedCommentsProvider
    extends AutoDisposeFutureProvider<List<FeedComment>> {
  /// See also [feedComments].
  FeedCommentsProvider(String feedItemId)
    : this._internal(
        (ref) => feedComments(ref as FeedCommentsRef, feedItemId),
        from: feedCommentsProvider,
        name: r'feedCommentsProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$feedCommentsHash,
        dependencies: FeedCommentsFamily._dependencies,
        allTransitiveDependencies:
            FeedCommentsFamily._allTransitiveDependencies,
        feedItemId: feedItemId,
      );

  FeedCommentsProvider._internal(
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
    FutureOr<List<FeedComment>> Function(FeedCommentsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FeedCommentsProvider._internal(
        (ref) => create(ref as FeedCommentsRef),
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
  AutoDisposeFutureProviderElement<List<FeedComment>> createElement() {
    return _FeedCommentsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FeedCommentsProvider && other.feedItemId == feedItemId;
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
mixin FeedCommentsRef on AutoDisposeFutureProviderRef<List<FeedComment>> {
  /// The parameter `feedItemId` of this provider.
  String get feedItemId;
}

class _FeedCommentsProviderElement
    extends AutoDisposeFutureProviderElement<List<FeedComment>>
    with FeedCommentsRef {
  _FeedCommentsProviderElement(super.provider);

  @override
  String get feedItemId => (origin as FeedCommentsProvider).feedItemId;
}

String _$commentsNotifierHash() => r'696f96f5e7a8e34bf1c30aee5d7cb62a3ba39cfd';

/// See also [CommentsNotifier].
@ProviderFor(CommentsNotifier)
final commentsNotifierProvider =
    AutoDisposeNotifierProvider<CommentsNotifier, void>.internal(
      CommentsNotifier.new,
      name: r'commentsNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$commentsNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$CommentsNotifier = AutoDisposeNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
