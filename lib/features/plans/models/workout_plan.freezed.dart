// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'workout_plan.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WorkoutPlanOwner {

 String get username;@JsonKey(name: 'display_name') String? get displayName;@JsonKey(name: 'avatar_id') int? get avatarId;@JsonKey(name: 'avatar_color') String? get avatarColor;@JsonKey(name: 'is_official') bool get isOfficial;
/// Create a copy of WorkoutPlanOwner
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WorkoutPlanOwnerCopyWith<WorkoutPlanOwner> get copyWith => _$WorkoutPlanOwnerCopyWithImpl<WorkoutPlanOwner>(this as WorkoutPlanOwner, _$identity);

  /// Serializes this WorkoutPlanOwner to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WorkoutPlanOwner&&(identical(other.username, username) || other.username == username)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.avatarId, avatarId) || other.avatarId == avatarId)&&(identical(other.avatarColor, avatarColor) || other.avatarColor == avatarColor)&&(identical(other.isOfficial, isOfficial) || other.isOfficial == isOfficial));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,username,displayName,avatarId,avatarColor,isOfficial);

@override
String toString() {
  return 'WorkoutPlanOwner(username: $username, displayName: $displayName, avatarId: $avatarId, avatarColor: $avatarColor, isOfficial: $isOfficial)';
}


}

/// @nodoc
abstract mixin class $WorkoutPlanOwnerCopyWith<$Res>  {
  factory $WorkoutPlanOwnerCopyWith(WorkoutPlanOwner value, $Res Function(WorkoutPlanOwner) _then) = _$WorkoutPlanOwnerCopyWithImpl;
@useResult
$Res call({
 String username,@JsonKey(name: 'display_name') String? displayName,@JsonKey(name: 'avatar_id') int? avatarId,@JsonKey(name: 'avatar_color') String? avatarColor,@JsonKey(name: 'is_official') bool isOfficial
});




}
/// @nodoc
class _$WorkoutPlanOwnerCopyWithImpl<$Res>
    implements $WorkoutPlanOwnerCopyWith<$Res> {
  _$WorkoutPlanOwnerCopyWithImpl(this._self, this._then);

  final WorkoutPlanOwner _self;
  final $Res Function(WorkoutPlanOwner) _then;

/// Create a copy of WorkoutPlanOwner
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? username = null,Object? displayName = freezed,Object? avatarId = freezed,Object? avatarColor = freezed,Object? isOfficial = null,}) {
  return _then(_self.copyWith(
username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,displayName: freezed == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String?,avatarId: freezed == avatarId ? _self.avatarId : avatarId // ignore: cast_nullable_to_non_nullable
as int?,avatarColor: freezed == avatarColor ? _self.avatarColor : avatarColor // ignore: cast_nullable_to_non_nullable
as String?,isOfficial: null == isOfficial ? _self.isOfficial : isOfficial // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [WorkoutPlanOwner].
extension WorkoutPlanOwnerPatterns on WorkoutPlanOwner {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WorkoutPlanOwner value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WorkoutPlanOwner() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WorkoutPlanOwner value)  $default,){
final _that = this;
switch (_that) {
case _WorkoutPlanOwner():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WorkoutPlanOwner value)?  $default,){
final _that = this;
switch (_that) {
case _WorkoutPlanOwner() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String username, @JsonKey(name: 'display_name')  String? displayName, @JsonKey(name: 'avatar_id')  int? avatarId, @JsonKey(name: 'avatar_color')  String? avatarColor, @JsonKey(name: 'is_official')  bool isOfficial)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WorkoutPlanOwner() when $default != null:
return $default(_that.username,_that.displayName,_that.avatarId,_that.avatarColor,_that.isOfficial);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String username, @JsonKey(name: 'display_name')  String? displayName, @JsonKey(name: 'avatar_id')  int? avatarId, @JsonKey(name: 'avatar_color')  String? avatarColor, @JsonKey(name: 'is_official')  bool isOfficial)  $default,) {final _that = this;
switch (_that) {
case _WorkoutPlanOwner():
return $default(_that.username,_that.displayName,_that.avatarId,_that.avatarColor,_that.isOfficial);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String username, @JsonKey(name: 'display_name')  String? displayName, @JsonKey(name: 'avatar_id')  int? avatarId, @JsonKey(name: 'avatar_color')  String? avatarColor, @JsonKey(name: 'is_official')  bool isOfficial)?  $default,) {final _that = this;
switch (_that) {
case _WorkoutPlanOwner() when $default != null:
return $default(_that.username,_that.displayName,_that.avatarId,_that.avatarColor,_that.isOfficial);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WorkoutPlanOwner implements WorkoutPlanOwner {
  const _WorkoutPlanOwner({required this.username, @JsonKey(name: 'display_name') this.displayName, @JsonKey(name: 'avatar_id') this.avatarId, @JsonKey(name: 'avatar_color') this.avatarColor, @JsonKey(name: 'is_official') this.isOfficial = false});
  factory _WorkoutPlanOwner.fromJson(Map<String, dynamic> json) => _$WorkoutPlanOwnerFromJson(json);

@override final  String username;
@override@JsonKey(name: 'display_name') final  String? displayName;
@override@JsonKey(name: 'avatar_id') final  int? avatarId;
@override@JsonKey(name: 'avatar_color') final  String? avatarColor;
@override@JsonKey(name: 'is_official') final  bool isOfficial;

/// Create a copy of WorkoutPlanOwner
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WorkoutPlanOwnerCopyWith<_WorkoutPlanOwner> get copyWith => __$WorkoutPlanOwnerCopyWithImpl<_WorkoutPlanOwner>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WorkoutPlanOwnerToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WorkoutPlanOwner&&(identical(other.username, username) || other.username == username)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.avatarId, avatarId) || other.avatarId == avatarId)&&(identical(other.avatarColor, avatarColor) || other.avatarColor == avatarColor)&&(identical(other.isOfficial, isOfficial) || other.isOfficial == isOfficial));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,username,displayName,avatarId,avatarColor,isOfficial);

@override
String toString() {
  return 'WorkoutPlanOwner(username: $username, displayName: $displayName, avatarId: $avatarId, avatarColor: $avatarColor, isOfficial: $isOfficial)';
}


}

/// @nodoc
abstract mixin class _$WorkoutPlanOwnerCopyWith<$Res> implements $WorkoutPlanOwnerCopyWith<$Res> {
  factory _$WorkoutPlanOwnerCopyWith(_WorkoutPlanOwner value, $Res Function(_WorkoutPlanOwner) _then) = __$WorkoutPlanOwnerCopyWithImpl;
@override @useResult
$Res call({
 String username,@JsonKey(name: 'display_name') String? displayName,@JsonKey(name: 'avatar_id') int? avatarId,@JsonKey(name: 'avatar_color') String? avatarColor,@JsonKey(name: 'is_official') bool isOfficial
});




}
/// @nodoc
class __$WorkoutPlanOwnerCopyWithImpl<$Res>
    implements _$WorkoutPlanOwnerCopyWith<$Res> {
  __$WorkoutPlanOwnerCopyWithImpl(this._self, this._then);

  final _WorkoutPlanOwner _self;
  final $Res Function(_WorkoutPlanOwner) _then;

/// Create a copy of WorkoutPlanOwner
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? username = null,Object? displayName = freezed,Object? avatarId = freezed,Object? avatarColor = freezed,Object? isOfficial = null,}) {
  return _then(_WorkoutPlanOwner(
username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,displayName: freezed == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String?,avatarId: freezed == avatarId ? _self.avatarId : avatarId // ignore: cast_nullable_to_non_nullable
as int?,avatarColor: freezed == avatarColor ? _self.avatarColor : avatarColor // ignore: cast_nullable_to_non_nullable
as String?,isOfficial: null == isOfficial ? _self.isOfficial : isOfficial // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$WorkoutPlan {

 String get id; String get title; String? get description;@JsonKey(name: 'is_public') bool get isPublic;@JsonKey(name: 'owner_id') String? get ownerId; int? get weeks;@JsonKey(name: 'sessions_per_week') int? get sessionsPerWeek;@JsonKey(name: 'avg_duration_mins') int? get avgDurationMins; String? get difficulty; String? get equipment;@JsonKey(name: 'plan_exercises') List<PlanExercise> get exercises;@JsonKey(name: 'profiles') WorkoutPlanOwner? get owner;@JsonKey(name: 'created_at') DateTime? get createdAt;@JsonKey(name: 'updated_at') DateTime? get updatedAt;@JsonKey(name: 'source_plan_id') String? get sourcePlanId;@JsonKey(name: 'is_deleted') bool get isDeleted;
/// Create a copy of WorkoutPlan
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WorkoutPlanCopyWith<WorkoutPlan> get copyWith => _$WorkoutPlanCopyWithImpl<WorkoutPlan>(this as WorkoutPlan, _$identity);

  /// Serializes this WorkoutPlan to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WorkoutPlan&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.isPublic, isPublic) || other.isPublic == isPublic)&&(identical(other.ownerId, ownerId) || other.ownerId == ownerId)&&(identical(other.weeks, weeks) || other.weeks == weeks)&&(identical(other.sessionsPerWeek, sessionsPerWeek) || other.sessionsPerWeek == sessionsPerWeek)&&(identical(other.avgDurationMins, avgDurationMins) || other.avgDurationMins == avgDurationMins)&&(identical(other.difficulty, difficulty) || other.difficulty == difficulty)&&(identical(other.equipment, equipment) || other.equipment == equipment)&&const DeepCollectionEquality().equals(other.exercises, exercises)&&(identical(other.owner, owner) || other.owner == owner)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.sourcePlanId, sourcePlanId) || other.sourcePlanId == sourcePlanId)&&(identical(other.isDeleted, isDeleted) || other.isDeleted == isDeleted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,description,isPublic,ownerId,weeks,sessionsPerWeek,avgDurationMins,difficulty,equipment,const DeepCollectionEquality().hash(exercises),owner,createdAt,updatedAt,sourcePlanId,isDeleted);

@override
String toString() {
  return 'WorkoutPlan(id: $id, title: $title, description: $description, isPublic: $isPublic, ownerId: $ownerId, weeks: $weeks, sessionsPerWeek: $sessionsPerWeek, avgDurationMins: $avgDurationMins, difficulty: $difficulty, equipment: $equipment, exercises: $exercises, owner: $owner, createdAt: $createdAt, updatedAt: $updatedAt, sourcePlanId: $sourcePlanId, isDeleted: $isDeleted)';
}


}

/// @nodoc
abstract mixin class $WorkoutPlanCopyWith<$Res>  {
  factory $WorkoutPlanCopyWith(WorkoutPlan value, $Res Function(WorkoutPlan) _then) = _$WorkoutPlanCopyWithImpl;
@useResult
$Res call({
 String id, String title, String? description,@JsonKey(name: 'is_public') bool isPublic,@JsonKey(name: 'owner_id') String? ownerId, int? weeks,@JsonKey(name: 'sessions_per_week') int? sessionsPerWeek,@JsonKey(name: 'avg_duration_mins') int? avgDurationMins, String? difficulty, String? equipment,@JsonKey(name: 'plan_exercises') List<PlanExercise> exercises,@JsonKey(name: 'profiles') WorkoutPlanOwner? owner,@JsonKey(name: 'created_at') DateTime? createdAt,@JsonKey(name: 'updated_at') DateTime? updatedAt,@JsonKey(name: 'source_plan_id') String? sourcePlanId,@JsonKey(name: 'is_deleted') bool isDeleted
});


$WorkoutPlanOwnerCopyWith<$Res>? get owner;

}
/// @nodoc
class _$WorkoutPlanCopyWithImpl<$Res>
    implements $WorkoutPlanCopyWith<$Res> {
  _$WorkoutPlanCopyWithImpl(this._self, this._then);

  final WorkoutPlan _self;
  final $Res Function(WorkoutPlan) _then;

/// Create a copy of WorkoutPlan
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? description = freezed,Object? isPublic = null,Object? ownerId = freezed,Object? weeks = freezed,Object? sessionsPerWeek = freezed,Object? avgDurationMins = freezed,Object? difficulty = freezed,Object? equipment = freezed,Object? exercises = null,Object? owner = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? sourcePlanId = freezed,Object? isDeleted = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,isPublic: null == isPublic ? _self.isPublic : isPublic // ignore: cast_nullable_to_non_nullable
as bool,ownerId: freezed == ownerId ? _self.ownerId : ownerId // ignore: cast_nullable_to_non_nullable
as String?,weeks: freezed == weeks ? _self.weeks : weeks // ignore: cast_nullable_to_non_nullable
as int?,sessionsPerWeek: freezed == sessionsPerWeek ? _self.sessionsPerWeek : sessionsPerWeek // ignore: cast_nullable_to_non_nullable
as int?,avgDurationMins: freezed == avgDurationMins ? _self.avgDurationMins : avgDurationMins // ignore: cast_nullable_to_non_nullable
as int?,difficulty: freezed == difficulty ? _self.difficulty : difficulty // ignore: cast_nullable_to_non_nullable
as String?,equipment: freezed == equipment ? _self.equipment : equipment // ignore: cast_nullable_to_non_nullable
as String?,exercises: null == exercises ? _self.exercises : exercises // ignore: cast_nullable_to_non_nullable
as List<PlanExercise>,owner: freezed == owner ? _self.owner : owner // ignore: cast_nullable_to_non_nullable
as WorkoutPlanOwner?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,sourcePlanId: freezed == sourcePlanId ? _self.sourcePlanId : sourcePlanId // ignore: cast_nullable_to_non_nullable
as String?,isDeleted: null == isDeleted ? _self.isDeleted : isDeleted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of WorkoutPlan
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WorkoutPlanOwnerCopyWith<$Res>? get owner {
    if (_self.owner == null) {
    return null;
  }

  return $WorkoutPlanOwnerCopyWith<$Res>(_self.owner!, (value) {
    return _then(_self.copyWith(owner: value));
  });
}
}


/// Adds pattern-matching-related methods to [WorkoutPlan].
extension WorkoutPlanPatterns on WorkoutPlan {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WorkoutPlan value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WorkoutPlan() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WorkoutPlan value)  $default,){
final _that = this;
switch (_that) {
case _WorkoutPlan():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WorkoutPlan value)?  $default,){
final _that = this;
switch (_that) {
case _WorkoutPlan() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String? description, @JsonKey(name: 'is_public')  bool isPublic, @JsonKey(name: 'owner_id')  String? ownerId,  int? weeks, @JsonKey(name: 'sessions_per_week')  int? sessionsPerWeek, @JsonKey(name: 'avg_duration_mins')  int? avgDurationMins,  String? difficulty,  String? equipment, @JsonKey(name: 'plan_exercises')  List<PlanExercise> exercises, @JsonKey(name: 'profiles')  WorkoutPlanOwner? owner, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt, @JsonKey(name: 'source_plan_id')  String? sourcePlanId, @JsonKey(name: 'is_deleted')  bool isDeleted)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WorkoutPlan() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.isPublic,_that.ownerId,_that.weeks,_that.sessionsPerWeek,_that.avgDurationMins,_that.difficulty,_that.equipment,_that.exercises,_that.owner,_that.createdAt,_that.updatedAt,_that.sourcePlanId,_that.isDeleted);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String? description, @JsonKey(name: 'is_public')  bool isPublic, @JsonKey(name: 'owner_id')  String? ownerId,  int? weeks, @JsonKey(name: 'sessions_per_week')  int? sessionsPerWeek, @JsonKey(name: 'avg_duration_mins')  int? avgDurationMins,  String? difficulty,  String? equipment, @JsonKey(name: 'plan_exercises')  List<PlanExercise> exercises, @JsonKey(name: 'profiles')  WorkoutPlanOwner? owner, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt, @JsonKey(name: 'source_plan_id')  String? sourcePlanId, @JsonKey(name: 'is_deleted')  bool isDeleted)  $default,) {final _that = this;
switch (_that) {
case _WorkoutPlan():
return $default(_that.id,_that.title,_that.description,_that.isPublic,_that.ownerId,_that.weeks,_that.sessionsPerWeek,_that.avgDurationMins,_that.difficulty,_that.equipment,_that.exercises,_that.owner,_that.createdAt,_that.updatedAt,_that.sourcePlanId,_that.isDeleted);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String? description, @JsonKey(name: 'is_public')  bool isPublic, @JsonKey(name: 'owner_id')  String? ownerId,  int? weeks, @JsonKey(name: 'sessions_per_week')  int? sessionsPerWeek, @JsonKey(name: 'avg_duration_mins')  int? avgDurationMins,  String? difficulty,  String? equipment, @JsonKey(name: 'plan_exercises')  List<PlanExercise> exercises, @JsonKey(name: 'profiles')  WorkoutPlanOwner? owner, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt, @JsonKey(name: 'source_plan_id')  String? sourcePlanId, @JsonKey(name: 'is_deleted')  bool isDeleted)?  $default,) {final _that = this;
switch (_that) {
case _WorkoutPlan() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.isPublic,_that.ownerId,_that.weeks,_that.sessionsPerWeek,_that.avgDurationMins,_that.difficulty,_that.equipment,_that.exercises,_that.owner,_that.createdAt,_that.updatedAt,_that.sourcePlanId,_that.isDeleted);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WorkoutPlan implements WorkoutPlan {
  const _WorkoutPlan({required this.id, required this.title, this.description, @JsonKey(name: 'is_public') this.isPublic = false, @JsonKey(name: 'owner_id') this.ownerId, this.weeks, @JsonKey(name: 'sessions_per_week') this.sessionsPerWeek, @JsonKey(name: 'avg_duration_mins') this.avgDurationMins, this.difficulty, this.equipment, @JsonKey(name: 'plan_exercises') final  List<PlanExercise> exercises = const [], @JsonKey(name: 'profiles') this.owner, @JsonKey(name: 'created_at') this.createdAt, @JsonKey(name: 'updated_at') this.updatedAt, @JsonKey(name: 'source_plan_id') this.sourcePlanId, @JsonKey(name: 'is_deleted') this.isDeleted = false}): _exercises = exercises;
  factory _WorkoutPlan.fromJson(Map<String, dynamic> json) => _$WorkoutPlanFromJson(json);

@override final  String id;
@override final  String title;
@override final  String? description;
@override@JsonKey(name: 'is_public') final  bool isPublic;
@override@JsonKey(name: 'owner_id') final  String? ownerId;
@override final  int? weeks;
@override@JsonKey(name: 'sessions_per_week') final  int? sessionsPerWeek;
@override@JsonKey(name: 'avg_duration_mins') final  int? avgDurationMins;
@override final  String? difficulty;
@override final  String? equipment;
 final  List<PlanExercise> _exercises;
@override@JsonKey(name: 'plan_exercises') List<PlanExercise> get exercises {
  if (_exercises is EqualUnmodifiableListView) return _exercises;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_exercises);
}

@override@JsonKey(name: 'profiles') final  WorkoutPlanOwner? owner;
@override@JsonKey(name: 'created_at') final  DateTime? createdAt;
@override@JsonKey(name: 'updated_at') final  DateTime? updatedAt;
@override@JsonKey(name: 'source_plan_id') final  String? sourcePlanId;
@override@JsonKey(name: 'is_deleted') final  bool isDeleted;

/// Create a copy of WorkoutPlan
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WorkoutPlanCopyWith<_WorkoutPlan> get copyWith => __$WorkoutPlanCopyWithImpl<_WorkoutPlan>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WorkoutPlanToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WorkoutPlan&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.isPublic, isPublic) || other.isPublic == isPublic)&&(identical(other.ownerId, ownerId) || other.ownerId == ownerId)&&(identical(other.weeks, weeks) || other.weeks == weeks)&&(identical(other.sessionsPerWeek, sessionsPerWeek) || other.sessionsPerWeek == sessionsPerWeek)&&(identical(other.avgDurationMins, avgDurationMins) || other.avgDurationMins == avgDurationMins)&&(identical(other.difficulty, difficulty) || other.difficulty == difficulty)&&(identical(other.equipment, equipment) || other.equipment == equipment)&&const DeepCollectionEquality().equals(other._exercises, _exercises)&&(identical(other.owner, owner) || other.owner == owner)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.sourcePlanId, sourcePlanId) || other.sourcePlanId == sourcePlanId)&&(identical(other.isDeleted, isDeleted) || other.isDeleted == isDeleted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,description,isPublic,ownerId,weeks,sessionsPerWeek,avgDurationMins,difficulty,equipment,const DeepCollectionEquality().hash(_exercises),owner,createdAt,updatedAt,sourcePlanId,isDeleted);

@override
String toString() {
  return 'WorkoutPlan(id: $id, title: $title, description: $description, isPublic: $isPublic, ownerId: $ownerId, weeks: $weeks, sessionsPerWeek: $sessionsPerWeek, avgDurationMins: $avgDurationMins, difficulty: $difficulty, equipment: $equipment, exercises: $exercises, owner: $owner, createdAt: $createdAt, updatedAt: $updatedAt, sourcePlanId: $sourcePlanId, isDeleted: $isDeleted)';
}


}

/// @nodoc
abstract mixin class _$WorkoutPlanCopyWith<$Res> implements $WorkoutPlanCopyWith<$Res> {
  factory _$WorkoutPlanCopyWith(_WorkoutPlan value, $Res Function(_WorkoutPlan) _then) = __$WorkoutPlanCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String? description,@JsonKey(name: 'is_public') bool isPublic,@JsonKey(name: 'owner_id') String? ownerId, int? weeks,@JsonKey(name: 'sessions_per_week') int? sessionsPerWeek,@JsonKey(name: 'avg_duration_mins') int? avgDurationMins, String? difficulty, String? equipment,@JsonKey(name: 'plan_exercises') List<PlanExercise> exercises,@JsonKey(name: 'profiles') WorkoutPlanOwner? owner,@JsonKey(name: 'created_at') DateTime? createdAt,@JsonKey(name: 'updated_at') DateTime? updatedAt,@JsonKey(name: 'source_plan_id') String? sourcePlanId,@JsonKey(name: 'is_deleted') bool isDeleted
});


@override $WorkoutPlanOwnerCopyWith<$Res>? get owner;

}
/// @nodoc
class __$WorkoutPlanCopyWithImpl<$Res>
    implements _$WorkoutPlanCopyWith<$Res> {
  __$WorkoutPlanCopyWithImpl(this._self, this._then);

  final _WorkoutPlan _self;
  final $Res Function(_WorkoutPlan) _then;

/// Create a copy of WorkoutPlan
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? description = freezed,Object? isPublic = null,Object? ownerId = freezed,Object? weeks = freezed,Object? sessionsPerWeek = freezed,Object? avgDurationMins = freezed,Object? difficulty = freezed,Object? equipment = freezed,Object? exercises = null,Object? owner = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? sourcePlanId = freezed,Object? isDeleted = null,}) {
  return _then(_WorkoutPlan(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,isPublic: null == isPublic ? _self.isPublic : isPublic // ignore: cast_nullable_to_non_nullable
as bool,ownerId: freezed == ownerId ? _self.ownerId : ownerId // ignore: cast_nullable_to_non_nullable
as String?,weeks: freezed == weeks ? _self.weeks : weeks // ignore: cast_nullable_to_non_nullable
as int?,sessionsPerWeek: freezed == sessionsPerWeek ? _self.sessionsPerWeek : sessionsPerWeek // ignore: cast_nullable_to_non_nullable
as int?,avgDurationMins: freezed == avgDurationMins ? _self.avgDurationMins : avgDurationMins // ignore: cast_nullable_to_non_nullable
as int?,difficulty: freezed == difficulty ? _self.difficulty : difficulty // ignore: cast_nullable_to_non_nullable
as String?,equipment: freezed == equipment ? _self.equipment : equipment // ignore: cast_nullable_to_non_nullable
as String?,exercises: null == exercises ? _self._exercises : exercises // ignore: cast_nullable_to_non_nullable
as List<PlanExercise>,owner: freezed == owner ? _self.owner : owner // ignore: cast_nullable_to_non_nullable
as WorkoutPlanOwner?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,sourcePlanId: freezed == sourcePlanId ? _self.sourcePlanId : sourcePlanId // ignore: cast_nullable_to_non_nullable
as String?,isDeleted: null == isDeleted ? _self.isDeleted : isDeleted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of WorkoutPlan
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WorkoutPlanOwnerCopyWith<$Res>? get owner {
    if (_self.owner == null) {
    return null;
  }

  return $WorkoutPlanOwnerCopyWith<$Res>(_self.owner!, (value) {
    return _then(_self.copyWith(owner: value));
  });
}
}

// dart format on
