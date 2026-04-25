// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'workout_session.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WorkoutPlanRef {

 String get title;
/// Create a copy of WorkoutPlanRef
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WorkoutPlanRefCopyWith<WorkoutPlanRef> get copyWith => _$WorkoutPlanRefCopyWithImpl<WorkoutPlanRef>(this as WorkoutPlanRef, _$identity);

  /// Serializes this WorkoutPlanRef to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WorkoutPlanRef&&(identical(other.title, title) || other.title == title));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title);

@override
String toString() {
  return 'WorkoutPlanRef(title: $title)';
}


}

/// @nodoc
abstract mixin class $WorkoutPlanRefCopyWith<$Res>  {
  factory $WorkoutPlanRefCopyWith(WorkoutPlanRef value, $Res Function(WorkoutPlanRef) _then) = _$WorkoutPlanRefCopyWithImpl;
@useResult
$Res call({
 String title
});




}
/// @nodoc
class _$WorkoutPlanRefCopyWithImpl<$Res>
    implements $WorkoutPlanRefCopyWith<$Res> {
  _$WorkoutPlanRefCopyWithImpl(this._self, this._then);

  final WorkoutPlanRef _self;
  final $Res Function(WorkoutPlanRef) _then;

/// Create a copy of WorkoutPlanRef
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [WorkoutPlanRef].
extension WorkoutPlanRefPatterns on WorkoutPlanRef {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WorkoutPlanRef value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WorkoutPlanRef() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WorkoutPlanRef value)  $default,){
final _that = this;
switch (_that) {
case _WorkoutPlanRef():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WorkoutPlanRef value)?  $default,){
final _that = this;
switch (_that) {
case _WorkoutPlanRef() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WorkoutPlanRef() when $default != null:
return $default(_that.title);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title)  $default,) {final _that = this;
switch (_that) {
case _WorkoutPlanRef():
return $default(_that.title);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title)?  $default,) {final _that = this;
switch (_that) {
case _WorkoutPlanRef() when $default != null:
return $default(_that.title);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WorkoutPlanRef implements WorkoutPlanRef {
  const _WorkoutPlanRef({required this.title});
  factory _WorkoutPlanRef.fromJson(Map<String, dynamic> json) => _$WorkoutPlanRefFromJson(json);

@override final  String title;

/// Create a copy of WorkoutPlanRef
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WorkoutPlanRefCopyWith<_WorkoutPlanRef> get copyWith => __$WorkoutPlanRefCopyWithImpl<_WorkoutPlanRef>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WorkoutPlanRefToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WorkoutPlanRef&&(identical(other.title, title) || other.title == title));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title);

@override
String toString() {
  return 'WorkoutPlanRef(title: $title)';
}


}

/// @nodoc
abstract mixin class _$WorkoutPlanRefCopyWith<$Res> implements $WorkoutPlanRefCopyWith<$Res> {
  factory _$WorkoutPlanRefCopyWith(_WorkoutPlanRef value, $Res Function(_WorkoutPlanRef) _then) = __$WorkoutPlanRefCopyWithImpl;
@override @useResult
$Res call({
 String title
});




}
/// @nodoc
class __$WorkoutPlanRefCopyWithImpl<$Res>
    implements _$WorkoutPlanRefCopyWith<$Res> {
  __$WorkoutPlanRefCopyWithImpl(this._self, this._then);

  final _WorkoutPlanRef _self;
  final $Res Function(_WorkoutPlanRef) _then;

/// Create a copy of WorkoutPlanRef
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,}) {
  return _then(_WorkoutPlanRef(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$WorkoutSession {

 String get id;@JsonKey(name: 'user_id') String get userId;@JsonKey(name: 'plan_id') String? get planId;@JsonKey(name: 'week_number') int? get weekNumber;@JsonKey(name: 'session_number') int? get sessionNumber;@JsonKey(name: 'started_at') DateTime get startedAt;@JsonKey(name: 'ended_at') DateTime? get endedAt;@JsonKey(name: 'duration_secs') int? get durationSecs;@JsonKey(name: 'workout_plans') WorkoutPlanRef? get plan;@JsonKey(name: 'session_exercises') List<SessionExercise> get exercises;
/// Create a copy of WorkoutSession
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WorkoutSessionCopyWith<WorkoutSession> get copyWith => _$WorkoutSessionCopyWithImpl<WorkoutSession>(this as WorkoutSession, _$identity);

  /// Serializes this WorkoutSession to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WorkoutSession&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.planId, planId) || other.planId == planId)&&(identical(other.weekNumber, weekNumber) || other.weekNumber == weekNumber)&&(identical(other.sessionNumber, sessionNumber) || other.sessionNumber == sessionNumber)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.endedAt, endedAt) || other.endedAt == endedAt)&&(identical(other.durationSecs, durationSecs) || other.durationSecs == durationSecs)&&(identical(other.plan, plan) || other.plan == plan)&&const DeepCollectionEquality().equals(other.exercises, exercises));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,planId,weekNumber,sessionNumber,startedAt,endedAt,durationSecs,plan,const DeepCollectionEquality().hash(exercises));

@override
String toString() {
  return 'WorkoutSession(id: $id, userId: $userId, planId: $planId, weekNumber: $weekNumber, sessionNumber: $sessionNumber, startedAt: $startedAt, endedAt: $endedAt, durationSecs: $durationSecs, plan: $plan, exercises: $exercises)';
}


}

/// @nodoc
abstract mixin class $WorkoutSessionCopyWith<$Res>  {
  factory $WorkoutSessionCopyWith(WorkoutSession value, $Res Function(WorkoutSession) _then) = _$WorkoutSessionCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'user_id') String userId,@JsonKey(name: 'plan_id') String? planId,@JsonKey(name: 'week_number') int? weekNumber,@JsonKey(name: 'session_number') int? sessionNumber,@JsonKey(name: 'started_at') DateTime startedAt,@JsonKey(name: 'ended_at') DateTime? endedAt,@JsonKey(name: 'duration_secs') int? durationSecs,@JsonKey(name: 'workout_plans') WorkoutPlanRef? plan,@JsonKey(name: 'session_exercises') List<SessionExercise> exercises
});


$WorkoutPlanRefCopyWith<$Res>? get plan;

}
/// @nodoc
class _$WorkoutSessionCopyWithImpl<$Res>
    implements $WorkoutSessionCopyWith<$Res> {
  _$WorkoutSessionCopyWithImpl(this._self, this._then);

  final WorkoutSession _self;
  final $Res Function(WorkoutSession) _then;

/// Create a copy of WorkoutSession
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? planId = freezed,Object? weekNumber = freezed,Object? sessionNumber = freezed,Object? startedAt = null,Object? endedAt = freezed,Object? durationSecs = freezed,Object? plan = freezed,Object? exercises = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,planId: freezed == planId ? _self.planId : planId // ignore: cast_nullable_to_non_nullable
as String?,weekNumber: freezed == weekNumber ? _self.weekNumber : weekNumber // ignore: cast_nullable_to_non_nullable
as int?,sessionNumber: freezed == sessionNumber ? _self.sessionNumber : sessionNumber // ignore: cast_nullable_to_non_nullable
as int?,startedAt: null == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime,endedAt: freezed == endedAt ? _self.endedAt : endedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,durationSecs: freezed == durationSecs ? _self.durationSecs : durationSecs // ignore: cast_nullable_to_non_nullable
as int?,plan: freezed == plan ? _self.plan : plan // ignore: cast_nullable_to_non_nullable
as WorkoutPlanRef?,exercises: null == exercises ? _self.exercises : exercises // ignore: cast_nullable_to_non_nullable
as List<SessionExercise>,
  ));
}
/// Create a copy of WorkoutSession
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WorkoutPlanRefCopyWith<$Res>? get plan {
    if (_self.plan == null) {
    return null;
  }

  return $WorkoutPlanRefCopyWith<$Res>(_self.plan!, (value) {
    return _then(_self.copyWith(plan: value));
  });
}
}


/// Adds pattern-matching-related methods to [WorkoutSession].
extension WorkoutSessionPatterns on WorkoutSession {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WorkoutSession value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WorkoutSession() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WorkoutSession value)  $default,){
final _that = this;
switch (_that) {
case _WorkoutSession():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WorkoutSession value)?  $default,){
final _that = this;
switch (_that) {
case _WorkoutSession() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'user_id')  String userId, @JsonKey(name: 'plan_id')  String? planId, @JsonKey(name: 'week_number')  int? weekNumber, @JsonKey(name: 'session_number')  int? sessionNumber, @JsonKey(name: 'started_at')  DateTime startedAt, @JsonKey(name: 'ended_at')  DateTime? endedAt, @JsonKey(name: 'duration_secs')  int? durationSecs, @JsonKey(name: 'workout_plans')  WorkoutPlanRef? plan, @JsonKey(name: 'session_exercises')  List<SessionExercise> exercises)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WorkoutSession() when $default != null:
return $default(_that.id,_that.userId,_that.planId,_that.weekNumber,_that.sessionNumber,_that.startedAt,_that.endedAt,_that.durationSecs,_that.plan,_that.exercises);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'user_id')  String userId, @JsonKey(name: 'plan_id')  String? planId, @JsonKey(name: 'week_number')  int? weekNumber, @JsonKey(name: 'session_number')  int? sessionNumber, @JsonKey(name: 'started_at')  DateTime startedAt, @JsonKey(name: 'ended_at')  DateTime? endedAt, @JsonKey(name: 'duration_secs')  int? durationSecs, @JsonKey(name: 'workout_plans')  WorkoutPlanRef? plan, @JsonKey(name: 'session_exercises')  List<SessionExercise> exercises)  $default,) {final _that = this;
switch (_that) {
case _WorkoutSession():
return $default(_that.id,_that.userId,_that.planId,_that.weekNumber,_that.sessionNumber,_that.startedAt,_that.endedAt,_that.durationSecs,_that.plan,_that.exercises);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'user_id')  String userId, @JsonKey(name: 'plan_id')  String? planId, @JsonKey(name: 'week_number')  int? weekNumber, @JsonKey(name: 'session_number')  int? sessionNumber, @JsonKey(name: 'started_at')  DateTime startedAt, @JsonKey(name: 'ended_at')  DateTime? endedAt, @JsonKey(name: 'duration_secs')  int? durationSecs, @JsonKey(name: 'workout_plans')  WorkoutPlanRef? plan, @JsonKey(name: 'session_exercises')  List<SessionExercise> exercises)?  $default,) {final _that = this;
switch (_that) {
case _WorkoutSession() when $default != null:
return $default(_that.id,_that.userId,_that.planId,_that.weekNumber,_that.sessionNumber,_that.startedAt,_that.endedAt,_that.durationSecs,_that.plan,_that.exercises);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WorkoutSession implements WorkoutSession {
  const _WorkoutSession({required this.id, @JsonKey(name: 'user_id') required this.userId, @JsonKey(name: 'plan_id') this.planId, @JsonKey(name: 'week_number') this.weekNumber, @JsonKey(name: 'session_number') this.sessionNumber, @JsonKey(name: 'started_at') required this.startedAt, @JsonKey(name: 'ended_at') this.endedAt, @JsonKey(name: 'duration_secs') this.durationSecs, @JsonKey(name: 'workout_plans') this.plan, @JsonKey(name: 'session_exercises') final  List<SessionExercise> exercises = const []}): _exercises = exercises;
  factory _WorkoutSession.fromJson(Map<String, dynamic> json) => _$WorkoutSessionFromJson(json);

@override final  String id;
@override@JsonKey(name: 'user_id') final  String userId;
@override@JsonKey(name: 'plan_id') final  String? planId;
@override@JsonKey(name: 'week_number') final  int? weekNumber;
@override@JsonKey(name: 'session_number') final  int? sessionNumber;
@override@JsonKey(name: 'started_at') final  DateTime startedAt;
@override@JsonKey(name: 'ended_at') final  DateTime? endedAt;
@override@JsonKey(name: 'duration_secs') final  int? durationSecs;
@override@JsonKey(name: 'workout_plans') final  WorkoutPlanRef? plan;
 final  List<SessionExercise> _exercises;
@override@JsonKey(name: 'session_exercises') List<SessionExercise> get exercises {
  if (_exercises is EqualUnmodifiableListView) return _exercises;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_exercises);
}


/// Create a copy of WorkoutSession
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WorkoutSessionCopyWith<_WorkoutSession> get copyWith => __$WorkoutSessionCopyWithImpl<_WorkoutSession>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WorkoutSessionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WorkoutSession&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.planId, planId) || other.planId == planId)&&(identical(other.weekNumber, weekNumber) || other.weekNumber == weekNumber)&&(identical(other.sessionNumber, sessionNumber) || other.sessionNumber == sessionNumber)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.endedAt, endedAt) || other.endedAt == endedAt)&&(identical(other.durationSecs, durationSecs) || other.durationSecs == durationSecs)&&(identical(other.plan, plan) || other.plan == plan)&&const DeepCollectionEquality().equals(other._exercises, _exercises));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,planId,weekNumber,sessionNumber,startedAt,endedAt,durationSecs,plan,const DeepCollectionEquality().hash(_exercises));

@override
String toString() {
  return 'WorkoutSession(id: $id, userId: $userId, planId: $planId, weekNumber: $weekNumber, sessionNumber: $sessionNumber, startedAt: $startedAt, endedAt: $endedAt, durationSecs: $durationSecs, plan: $plan, exercises: $exercises)';
}


}

/// @nodoc
abstract mixin class _$WorkoutSessionCopyWith<$Res> implements $WorkoutSessionCopyWith<$Res> {
  factory _$WorkoutSessionCopyWith(_WorkoutSession value, $Res Function(_WorkoutSession) _then) = __$WorkoutSessionCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'user_id') String userId,@JsonKey(name: 'plan_id') String? planId,@JsonKey(name: 'week_number') int? weekNumber,@JsonKey(name: 'session_number') int? sessionNumber,@JsonKey(name: 'started_at') DateTime startedAt,@JsonKey(name: 'ended_at') DateTime? endedAt,@JsonKey(name: 'duration_secs') int? durationSecs,@JsonKey(name: 'workout_plans') WorkoutPlanRef? plan,@JsonKey(name: 'session_exercises') List<SessionExercise> exercises
});


@override $WorkoutPlanRefCopyWith<$Res>? get plan;

}
/// @nodoc
class __$WorkoutSessionCopyWithImpl<$Res>
    implements _$WorkoutSessionCopyWith<$Res> {
  __$WorkoutSessionCopyWithImpl(this._self, this._then);

  final _WorkoutSession _self;
  final $Res Function(_WorkoutSession) _then;

/// Create a copy of WorkoutSession
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? planId = freezed,Object? weekNumber = freezed,Object? sessionNumber = freezed,Object? startedAt = null,Object? endedAt = freezed,Object? durationSecs = freezed,Object? plan = freezed,Object? exercises = null,}) {
  return _then(_WorkoutSession(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,planId: freezed == planId ? _self.planId : planId // ignore: cast_nullable_to_non_nullable
as String?,weekNumber: freezed == weekNumber ? _self.weekNumber : weekNumber // ignore: cast_nullable_to_non_nullable
as int?,sessionNumber: freezed == sessionNumber ? _self.sessionNumber : sessionNumber // ignore: cast_nullable_to_non_nullable
as int?,startedAt: null == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime,endedAt: freezed == endedAt ? _self.endedAt : endedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,durationSecs: freezed == durationSecs ? _self.durationSecs : durationSecs // ignore: cast_nullable_to_non_nullable
as int?,plan: freezed == plan ? _self.plan : plan // ignore: cast_nullable_to_non_nullable
as WorkoutPlanRef?,exercises: null == exercises ? _self._exercises : exercises // ignore: cast_nullable_to_non_nullable
as List<SessionExercise>,
  ));
}

/// Create a copy of WorkoutSession
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WorkoutPlanRefCopyWith<$Res>? get plan {
    if (_self.plan == null) {
    return null;
  }

  return $WorkoutPlanRefCopyWith<$Res>(_self.plan!, (value) {
    return _then(_self.copyWith(plan: value));
  });
}
}

// dart format on
