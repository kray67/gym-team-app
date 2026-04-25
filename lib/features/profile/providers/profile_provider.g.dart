// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$myProfileHash() => r'847e9470d92c111446e052a7027c1bed55190028';

/// See also [myProfile].
@ProviderFor(myProfile)
final myProfileProvider = AutoDisposeFutureProvider<UserProfile>.internal(
  myProfile,
  name: r'myProfileProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$myProfileHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef MyProfileRef = AutoDisposeFutureProviderRef<UserProfile>;
String _$userProfileHash() => r'cb12bc92d62faa13cdb09caa8a302bf28a907e66';

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

/// See also [userProfile].
@ProviderFor(userProfile)
const userProfileProvider = UserProfileFamily();

/// See also [userProfile].
class UserProfileFamily extends Family<AsyncValue<UserProfile>> {
  /// See also [userProfile].
  const UserProfileFamily();

  /// See also [userProfile].
  UserProfileProvider call(String userId) {
    return UserProfileProvider(userId);
  }

  @override
  UserProfileProvider getProviderOverride(
    covariant UserProfileProvider provider,
  ) {
    return call(provider.userId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'userProfileProvider';
}

/// See also [userProfile].
class UserProfileProvider extends AutoDisposeFutureProvider<UserProfile> {
  /// See also [userProfile].
  UserProfileProvider(String userId)
    : this._internal(
        (ref) => userProfile(ref as UserProfileRef, userId),
        from: userProfileProvider,
        name: r'userProfileProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$userProfileHash,
        dependencies: UserProfileFamily._dependencies,
        allTransitiveDependencies: UserProfileFamily._allTransitiveDependencies,
        userId: userId,
      );

  UserProfileProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userId,
  }) : super.internal();

  final String userId;

  @override
  Override overrideWith(
    FutureOr<UserProfile> Function(UserProfileRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UserProfileProvider._internal(
        (ref) => create(ref as UserProfileRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userId: userId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<UserProfile> createElement() {
    return _UserProfileProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UserProfileProvider && other.userId == userId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin UserProfileRef on AutoDisposeFutureProviderRef<UserProfile> {
  /// The parameter `userId` of this provider.
  String get userId;
}

class _UserProfileProviderElement
    extends AutoDisposeFutureProviderElement<UserProfile>
    with UserProfileRef {
  _UserProfileProviderElement(super.provider);

  @override
  String get userId => (origin as UserProfileProvider).userId;
}

String _$followersCountHash() => r'ba68849880eb408b775f66d843754d9e83b799b5';

/// See also [followersCount].
@ProviderFor(followersCount)
const followersCountProvider = FollowersCountFamily();

/// See also [followersCount].
class FollowersCountFamily extends Family<AsyncValue<int>> {
  /// See also [followersCount].
  const FollowersCountFamily();

  /// See also [followersCount].
  FollowersCountProvider call(String userId) {
    return FollowersCountProvider(userId);
  }

  @override
  FollowersCountProvider getProviderOverride(
    covariant FollowersCountProvider provider,
  ) {
    return call(provider.userId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'followersCountProvider';
}

/// See also [followersCount].
class FollowersCountProvider extends AutoDisposeFutureProvider<int> {
  /// See also [followersCount].
  FollowersCountProvider(String userId)
    : this._internal(
        (ref) => followersCount(ref as FollowersCountRef, userId),
        from: followersCountProvider,
        name: r'followersCountProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$followersCountHash,
        dependencies: FollowersCountFamily._dependencies,
        allTransitiveDependencies:
            FollowersCountFamily._allTransitiveDependencies,
        userId: userId,
      );

  FollowersCountProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userId,
  }) : super.internal();

  final String userId;

  @override
  Override overrideWith(
    FutureOr<int> Function(FollowersCountRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FollowersCountProvider._internal(
        (ref) => create(ref as FollowersCountRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userId: userId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<int> createElement() {
    return _FollowersCountProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FollowersCountProvider && other.userId == userId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FollowersCountRef on AutoDisposeFutureProviderRef<int> {
  /// The parameter `userId` of this provider.
  String get userId;
}

class _FollowersCountProviderElement
    extends AutoDisposeFutureProviderElement<int>
    with FollowersCountRef {
  _FollowersCountProviderElement(super.provider);

  @override
  String get userId => (origin as FollowersCountProvider).userId;
}

String _$followingCountHash() => r'679865ec2f4d880e5d18a237a736d34f6cf60269';

/// See also [followingCount].
@ProviderFor(followingCount)
const followingCountProvider = FollowingCountFamily();

/// See also [followingCount].
class FollowingCountFamily extends Family<AsyncValue<int>> {
  /// See also [followingCount].
  const FollowingCountFamily();

  /// See also [followingCount].
  FollowingCountProvider call(String userId) {
    return FollowingCountProvider(userId);
  }

  @override
  FollowingCountProvider getProviderOverride(
    covariant FollowingCountProvider provider,
  ) {
    return call(provider.userId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'followingCountProvider';
}

/// See also [followingCount].
class FollowingCountProvider extends AutoDisposeFutureProvider<int> {
  /// See also [followingCount].
  FollowingCountProvider(String userId)
    : this._internal(
        (ref) => followingCount(ref as FollowingCountRef, userId),
        from: followingCountProvider,
        name: r'followingCountProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$followingCountHash,
        dependencies: FollowingCountFamily._dependencies,
        allTransitiveDependencies:
            FollowingCountFamily._allTransitiveDependencies,
        userId: userId,
      );

  FollowingCountProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userId,
  }) : super.internal();

  final String userId;

  @override
  Override overrideWith(
    FutureOr<int> Function(FollowingCountRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FollowingCountProvider._internal(
        (ref) => create(ref as FollowingCountRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userId: userId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<int> createElement() {
    return _FollowingCountProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FollowingCountProvider && other.userId == userId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FollowingCountRef on AutoDisposeFutureProviderRef<int> {
  /// The parameter `userId` of this provider.
  String get userId;
}

class _FollowingCountProviderElement
    extends AutoDisposeFutureProviderElement<int>
    with FollowingCountRef {
  _FollowingCountProviderElement(super.provider);

  @override
  String get userId => (origin as FollowingCountProvider).userId;
}

String _$followersHash() => r'f7560c048883d6ead79247487f9adeb6251d5450';

/// See also [followers].
@ProviderFor(followers)
const followersProvider = FollowersFamily();

/// See also [followers].
class FollowersFamily extends Family<AsyncValue<List<UserProfile>>> {
  /// See also [followers].
  const FollowersFamily();

  /// See also [followers].
  FollowersProvider call(String userId) {
    return FollowersProvider(userId);
  }

  @override
  FollowersProvider getProviderOverride(covariant FollowersProvider provider) {
    return call(provider.userId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'followersProvider';
}

/// See also [followers].
class FollowersProvider extends AutoDisposeFutureProvider<List<UserProfile>> {
  /// See also [followers].
  FollowersProvider(String userId)
    : this._internal(
        (ref) => followers(ref as FollowersRef, userId),
        from: followersProvider,
        name: r'followersProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$followersHash,
        dependencies: FollowersFamily._dependencies,
        allTransitiveDependencies: FollowersFamily._allTransitiveDependencies,
        userId: userId,
      );

  FollowersProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userId,
  }) : super.internal();

  final String userId;

  @override
  Override overrideWith(
    FutureOr<List<UserProfile>> Function(FollowersRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FollowersProvider._internal(
        (ref) => create(ref as FollowersRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userId: userId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<UserProfile>> createElement() {
    return _FollowersProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FollowersProvider && other.userId == userId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FollowersRef on AutoDisposeFutureProviderRef<List<UserProfile>> {
  /// The parameter `userId` of this provider.
  String get userId;
}

class _FollowersProviderElement
    extends AutoDisposeFutureProviderElement<List<UserProfile>>
    with FollowersRef {
  _FollowersProviderElement(super.provider);

  @override
  String get userId => (origin as FollowersProvider).userId;
}

String _$followingHash() => r'faae927c9c0d5f89704518e22d3207456e3a5cf5';

/// See also [following].
@ProviderFor(following)
const followingProvider = FollowingFamily();

/// See also [following].
class FollowingFamily extends Family<AsyncValue<List<UserProfile>>> {
  /// See also [following].
  const FollowingFamily();

  /// See also [following].
  FollowingProvider call(String userId) {
    return FollowingProvider(userId);
  }

  @override
  FollowingProvider getProviderOverride(covariant FollowingProvider provider) {
    return call(provider.userId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'followingProvider';
}

/// See also [following].
class FollowingProvider extends AutoDisposeFutureProvider<List<UserProfile>> {
  /// See also [following].
  FollowingProvider(String userId)
    : this._internal(
        (ref) => following(ref as FollowingRef, userId),
        from: followingProvider,
        name: r'followingProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$followingHash,
        dependencies: FollowingFamily._dependencies,
        allTransitiveDependencies: FollowingFamily._allTransitiveDependencies,
        userId: userId,
      );

  FollowingProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userId,
  }) : super.internal();

  final String userId;

  @override
  Override overrideWith(
    FutureOr<List<UserProfile>> Function(FollowingRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FollowingProvider._internal(
        (ref) => create(ref as FollowingRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userId: userId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<UserProfile>> createElement() {
    return _FollowingProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FollowingProvider && other.userId == userId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FollowingRef on AutoDisposeFutureProviderRef<List<UserProfile>> {
  /// The parameter `userId` of this provider.
  String get userId;
}

class _FollowingProviderElement
    extends AutoDisposeFutureProviderElement<List<UserProfile>>
    with FollowingRef {
  _FollowingProviderElement(super.provider);

  @override
  String get userId => (origin as FollowingProvider).userId;
}

String _$isFollowingHash() => r'977cbdda6407e7b5aee67c3386bd932b2da799ca';

/// See also [isFollowing].
@ProviderFor(isFollowing)
const isFollowingProvider = IsFollowingFamily();

/// See also [isFollowing].
class IsFollowingFamily extends Family<AsyncValue<bool>> {
  /// See also [isFollowing].
  const IsFollowingFamily();

  /// See also [isFollowing].
  IsFollowingProvider call(String userId) {
    return IsFollowingProvider(userId);
  }

  @override
  IsFollowingProvider getProviderOverride(
    covariant IsFollowingProvider provider,
  ) {
    return call(provider.userId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'isFollowingProvider';
}

/// See also [isFollowing].
class IsFollowingProvider extends AutoDisposeFutureProvider<bool> {
  /// See also [isFollowing].
  IsFollowingProvider(String userId)
    : this._internal(
        (ref) => isFollowing(ref as IsFollowingRef, userId),
        from: isFollowingProvider,
        name: r'isFollowingProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$isFollowingHash,
        dependencies: IsFollowingFamily._dependencies,
        allTransitiveDependencies: IsFollowingFamily._allTransitiveDependencies,
        userId: userId,
      );

  IsFollowingProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userId,
  }) : super.internal();

  final String userId;

  @override
  Override overrideWith(
    FutureOr<bool> Function(IsFollowingRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: IsFollowingProvider._internal(
        (ref) => create(ref as IsFollowingRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userId: userId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<bool> createElement() {
    return _IsFollowingProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is IsFollowingProvider && other.userId == userId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin IsFollowingRef on AutoDisposeFutureProviderRef<bool> {
  /// The parameter `userId` of this provider.
  String get userId;
}

class _IsFollowingProviderElement extends AutoDisposeFutureProviderElement<bool>
    with IsFollowingRef {
  _IsFollowingProviderElement(super.provider);

  @override
  String get userId => (origin as IsFollowingProvider).userId;
}

String _$allUsersHash() => r'f1269f0f60b0908a7b02da76de4b90bf487bdb56';

/// See also [allUsers].
@ProviderFor(allUsers)
final allUsersProvider = AutoDisposeFutureProvider<List<UserProfile>>.internal(
  allUsers,
  name: r'allUsersProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$allUsersHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AllUsersRef = AutoDisposeFutureProviderRef<List<UserProfile>>;
String _$socialNotifierHash() => r'aa42152929340d8559c36eeec2af4c24a1465285';

/// See also [SocialNotifier].
@ProviderFor(SocialNotifier)
final socialNotifierProvider =
    AutoDisposeNotifierProvider<SocialNotifier, void>.internal(
      SocialNotifier.new,
      name: r'socialNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$socialNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$SocialNotifier = AutoDisposeNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
