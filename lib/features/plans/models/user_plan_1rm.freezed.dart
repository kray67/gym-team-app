// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_plan_1rm.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserPlan1rm {

 String get id;@JsonKey(name: 'user_id') String get userId;@JsonKey(name: 'plan_id') String get planId;@JsonKey(name: 'exercise_id') String get exerciseId;@JsonKey(name: 'one_rm_kg') double get oneRmKg;@JsonKey(name: 'updated_at') DateTime get updatedAt;
/// Create a copy of UserPlan1rm
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserPlan1rmCopyWith<UserPlan1rm> get copyWith => _$UserPlan1rmCopyWithImpl<UserPlan1rm>(this as UserPlan1rm, _$identity);

  /// Serializes this UserPlan1rm to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserPlan1rm&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.planId, planId) || other.planId == planId)&&(identical(other.exerciseId, exerciseId) || other.exerciseId == exerciseId)&&(identical(other.oneRmKg, oneRmKg) || other.oneRmKg == oneRmKg)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,planId,exerciseId,oneRmKg,updatedAt);

@override
String toString() {
  return 'UserPlan1rm(id: $id, userId: $userId, planId: $planId, exerciseId: $exerciseId, oneRmKg: $oneRmKg, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $UserPlan1rmCopyWith<$Res>  {
  factory $UserPlan1rmCopyWith(UserPlan1rm value, $Res Function(UserPlan1rm) _then) = _$UserPlan1rmCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'user_id') String userId,@JsonKey(name: 'plan_id') String planId,@JsonKey(name: 'exercise_id') String exerciseId,@JsonKey(name: 'one_rm_kg') double oneRmKg,@JsonKey(name: 'updated_at') DateTime updatedAt
});




}
/// @nodoc
class _$UserPlan1rmCopyWithImpl<$Res>
    implements $UserPlan1rmCopyWith<$Res> {
  _$UserPlan1rmCopyWithImpl(this._self, this._then);

  final UserPlan1rm _self;
  final $Res Function(UserPlan1rm) _then;

/// Create a copy of UserPlan1rm
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? planId = null,Object? exerciseId = null,Object? oneRmKg = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,planId: null == planId ? _self.planId : planId // ignore: cast_nullable_to_non_nullable
as String,exerciseId: null == exerciseId ? _self.exerciseId : exerciseId // ignore: cast_nullable_to_non_nullable
as String,oneRmKg: null == oneRmKg ? _self.oneRmKg : oneRmKg // ignore: cast_nullable_to_non_nullable
as double,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [UserPlan1rm].
extension UserPlan1rmPatterns on UserPlan1rm {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserPlan1rm value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserPlan1rm() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserPlan1rm value)  $default,){
final _that = this;
switch (_that) {
case _UserPlan1rm():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserPlan1rm value)?  $default,){
final _that = this;
switch (_that) {
case _UserPlan1rm() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'user_id')  String userId, @JsonKey(name: 'plan_id')  String planId, @JsonKey(name: 'exercise_id')  String exerciseId, @JsonKey(name: 'one_rm_kg')  double oneRmKg, @JsonKey(name: 'updated_at')  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserPlan1rm() when $default != null:
return $default(_that.id,_that.userId,_that.planId,_that.exerciseId,_that.oneRmKg,_that.updatedAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'user_id')  String userId, @JsonKey(name: 'plan_id')  String planId, @JsonKey(name: 'exercise_id')  String exerciseId, @JsonKey(name: 'one_rm_kg')  double oneRmKg, @JsonKey(name: 'updated_at')  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _UserPlan1rm():
return $default(_that.id,_that.userId,_that.planId,_that.exerciseId,_that.oneRmKg,_that.updatedAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'user_id')  String userId, @JsonKey(name: 'plan_id')  String planId, @JsonKey(name: 'exercise_id')  String exerciseId, @JsonKey(name: 'one_rm_kg')  double oneRmKg, @JsonKey(name: 'updated_at')  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _UserPlan1rm() when $default != null:
return $default(_that.id,_that.userId,_that.planId,_that.exerciseId,_that.oneRmKg,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserPlan1rm implements UserPlan1rm {
  const _UserPlan1rm({required this.id, @JsonKey(name: 'user_id') required this.userId, @JsonKey(name: 'plan_id') required this.planId, @JsonKey(name: 'exercise_id') required this.exerciseId, @JsonKey(name: 'one_rm_kg') required this.oneRmKg, @JsonKey(name: 'updated_at') required this.updatedAt});
  factory _UserPlan1rm.fromJson(Map<String, dynamic> json) => _$UserPlan1rmFromJson(json);

@override final  String id;
@override@JsonKey(name: 'user_id') final  String userId;
@override@JsonKey(name: 'plan_id') final  String planId;
@override@JsonKey(name: 'exercise_id') final  String exerciseId;
@override@JsonKey(name: 'one_rm_kg') final  double oneRmKg;
@override@JsonKey(name: 'updated_at') final  DateTime updatedAt;

/// Create a copy of UserPlan1rm
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserPlan1rmCopyWith<_UserPlan1rm> get copyWith => __$UserPlan1rmCopyWithImpl<_UserPlan1rm>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserPlan1rmToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserPlan1rm&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.planId, planId) || other.planId == planId)&&(identical(other.exerciseId, exerciseId) || other.exerciseId == exerciseId)&&(identical(other.oneRmKg, oneRmKg) || other.oneRmKg == oneRmKg)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,planId,exerciseId,oneRmKg,updatedAt);

@override
String toString() {
  return 'UserPlan1rm(id: $id, userId: $userId, planId: $planId, exerciseId: $exerciseId, oneRmKg: $oneRmKg, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$UserPlan1rmCopyWith<$Res> implements $UserPlan1rmCopyWith<$Res> {
  factory _$UserPlan1rmCopyWith(_UserPlan1rm value, $Res Function(_UserPlan1rm) _then) = __$UserPlan1rmCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'user_id') String userId,@JsonKey(name: 'plan_id') String planId,@JsonKey(name: 'exercise_id') String exerciseId,@JsonKey(name: 'one_rm_kg') double oneRmKg,@JsonKey(name: 'updated_at') DateTime updatedAt
});




}
/// @nodoc
class __$UserPlan1rmCopyWithImpl<$Res>
    implements _$UserPlan1rmCopyWith<$Res> {
  __$UserPlan1rmCopyWithImpl(this._self, this._then);

  final _UserPlan1rm _self;
  final $Res Function(_UserPlan1rm) _then;

/// Create a copy of UserPlan1rm
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? planId = null,Object? exerciseId = null,Object? oneRmKg = null,Object? updatedAt = null,}) {
  return _then(_UserPlan1rm(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,planId: null == planId ? _self.planId : planId // ignore: cast_nullable_to_non_nullable
as String,exerciseId: null == exerciseId ? _self.exerciseId : exerciseId // ignore: cast_nullable_to_non_nullable
as String,oneRmKg: null == oneRmKg ? _self.oneRmKg : oneRmKg // ignore: cast_nullable_to_non_nullable
as double,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
