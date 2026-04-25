// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'session_set.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SessionSet {

 String get id;@JsonKey(name: 'session_exercise_id') String get sessionExerciseId;@JsonKey(name: 'set_number') int get setNumber; int? get reps;@JsonKey(name: 'weight_kg') double? get weightKg;@JsonKey(name: 'duration_secs') int? get durationSecs;@JsonKey(name: 'distance_m') double? get distanceM; bool get completed;@JsonKey(name: 'is_warmup') bool get isWarmup;
/// Create a copy of SessionSet
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SessionSetCopyWith<SessionSet> get copyWith => _$SessionSetCopyWithImpl<SessionSet>(this as SessionSet, _$identity);

  /// Serializes this SessionSet to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionSet&&(identical(other.id, id) || other.id == id)&&(identical(other.sessionExerciseId, sessionExerciseId) || other.sessionExerciseId == sessionExerciseId)&&(identical(other.setNumber, setNumber) || other.setNumber == setNumber)&&(identical(other.reps, reps) || other.reps == reps)&&(identical(other.weightKg, weightKg) || other.weightKg == weightKg)&&(identical(other.durationSecs, durationSecs) || other.durationSecs == durationSecs)&&(identical(other.distanceM, distanceM) || other.distanceM == distanceM)&&(identical(other.completed, completed) || other.completed == completed)&&(identical(other.isWarmup, isWarmup) || other.isWarmup == isWarmup));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,sessionExerciseId,setNumber,reps,weightKg,durationSecs,distanceM,completed,isWarmup);

@override
String toString() {
  return 'SessionSet(id: $id, sessionExerciseId: $sessionExerciseId, setNumber: $setNumber, reps: $reps, weightKg: $weightKg, durationSecs: $durationSecs, distanceM: $distanceM, completed: $completed, isWarmup: $isWarmup)';
}


}

/// @nodoc
abstract mixin class $SessionSetCopyWith<$Res>  {
  factory $SessionSetCopyWith(SessionSet value, $Res Function(SessionSet) _then) = _$SessionSetCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'session_exercise_id') String sessionExerciseId,@JsonKey(name: 'set_number') int setNumber, int? reps,@JsonKey(name: 'weight_kg') double? weightKg,@JsonKey(name: 'duration_secs') int? durationSecs,@JsonKey(name: 'distance_m') double? distanceM, bool completed,@JsonKey(name: 'is_warmup') bool isWarmup
});




}
/// @nodoc
class _$SessionSetCopyWithImpl<$Res>
    implements $SessionSetCopyWith<$Res> {
  _$SessionSetCopyWithImpl(this._self, this._then);

  final SessionSet _self;
  final $Res Function(SessionSet) _then;

/// Create a copy of SessionSet
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? sessionExerciseId = null,Object? setNumber = null,Object? reps = freezed,Object? weightKg = freezed,Object? durationSecs = freezed,Object? distanceM = freezed,Object? completed = null,Object? isWarmup = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,sessionExerciseId: null == sessionExerciseId ? _self.sessionExerciseId : sessionExerciseId // ignore: cast_nullable_to_non_nullable
as String,setNumber: null == setNumber ? _self.setNumber : setNumber // ignore: cast_nullable_to_non_nullable
as int,reps: freezed == reps ? _self.reps : reps // ignore: cast_nullable_to_non_nullable
as int?,weightKg: freezed == weightKg ? _self.weightKg : weightKg // ignore: cast_nullable_to_non_nullable
as double?,durationSecs: freezed == durationSecs ? _self.durationSecs : durationSecs // ignore: cast_nullable_to_non_nullable
as int?,distanceM: freezed == distanceM ? _self.distanceM : distanceM // ignore: cast_nullable_to_non_nullable
as double?,completed: null == completed ? _self.completed : completed // ignore: cast_nullable_to_non_nullable
as bool,isWarmup: null == isWarmup ? _self.isWarmup : isWarmup // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [SessionSet].
extension SessionSetPatterns on SessionSet {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SessionSet value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SessionSet() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SessionSet value)  $default,){
final _that = this;
switch (_that) {
case _SessionSet():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SessionSet value)?  $default,){
final _that = this;
switch (_that) {
case _SessionSet() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'session_exercise_id')  String sessionExerciseId, @JsonKey(name: 'set_number')  int setNumber,  int? reps, @JsonKey(name: 'weight_kg')  double? weightKg, @JsonKey(name: 'duration_secs')  int? durationSecs, @JsonKey(name: 'distance_m')  double? distanceM,  bool completed, @JsonKey(name: 'is_warmup')  bool isWarmup)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SessionSet() when $default != null:
return $default(_that.id,_that.sessionExerciseId,_that.setNumber,_that.reps,_that.weightKg,_that.durationSecs,_that.distanceM,_that.completed,_that.isWarmup);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'session_exercise_id')  String sessionExerciseId, @JsonKey(name: 'set_number')  int setNumber,  int? reps, @JsonKey(name: 'weight_kg')  double? weightKg, @JsonKey(name: 'duration_secs')  int? durationSecs, @JsonKey(name: 'distance_m')  double? distanceM,  bool completed, @JsonKey(name: 'is_warmup')  bool isWarmup)  $default,) {final _that = this;
switch (_that) {
case _SessionSet():
return $default(_that.id,_that.sessionExerciseId,_that.setNumber,_that.reps,_that.weightKg,_that.durationSecs,_that.distanceM,_that.completed,_that.isWarmup);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'session_exercise_id')  String sessionExerciseId, @JsonKey(name: 'set_number')  int setNumber,  int? reps, @JsonKey(name: 'weight_kg')  double? weightKg, @JsonKey(name: 'duration_secs')  int? durationSecs, @JsonKey(name: 'distance_m')  double? distanceM,  bool completed, @JsonKey(name: 'is_warmup')  bool isWarmup)?  $default,) {final _that = this;
switch (_that) {
case _SessionSet() when $default != null:
return $default(_that.id,_that.sessionExerciseId,_that.setNumber,_that.reps,_that.weightKg,_that.durationSecs,_that.distanceM,_that.completed,_that.isWarmup);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SessionSet implements SessionSet {
  const _SessionSet({required this.id, @JsonKey(name: 'session_exercise_id') required this.sessionExerciseId, @JsonKey(name: 'set_number') required this.setNumber, this.reps, @JsonKey(name: 'weight_kg') this.weightKg, @JsonKey(name: 'duration_secs') this.durationSecs, @JsonKey(name: 'distance_m') this.distanceM, this.completed = false, @JsonKey(name: 'is_warmup') this.isWarmup = false});
  factory _SessionSet.fromJson(Map<String, dynamic> json) => _$SessionSetFromJson(json);

@override final  String id;
@override@JsonKey(name: 'session_exercise_id') final  String sessionExerciseId;
@override@JsonKey(name: 'set_number') final  int setNumber;
@override final  int? reps;
@override@JsonKey(name: 'weight_kg') final  double? weightKg;
@override@JsonKey(name: 'duration_secs') final  int? durationSecs;
@override@JsonKey(name: 'distance_m') final  double? distanceM;
@override@JsonKey() final  bool completed;
@override@JsonKey(name: 'is_warmup') final  bool isWarmup;

/// Create a copy of SessionSet
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SessionSetCopyWith<_SessionSet> get copyWith => __$SessionSetCopyWithImpl<_SessionSet>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SessionSetToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SessionSet&&(identical(other.id, id) || other.id == id)&&(identical(other.sessionExerciseId, sessionExerciseId) || other.sessionExerciseId == sessionExerciseId)&&(identical(other.setNumber, setNumber) || other.setNumber == setNumber)&&(identical(other.reps, reps) || other.reps == reps)&&(identical(other.weightKg, weightKg) || other.weightKg == weightKg)&&(identical(other.durationSecs, durationSecs) || other.durationSecs == durationSecs)&&(identical(other.distanceM, distanceM) || other.distanceM == distanceM)&&(identical(other.completed, completed) || other.completed == completed)&&(identical(other.isWarmup, isWarmup) || other.isWarmup == isWarmup));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,sessionExerciseId,setNumber,reps,weightKg,durationSecs,distanceM,completed,isWarmup);

@override
String toString() {
  return 'SessionSet(id: $id, sessionExerciseId: $sessionExerciseId, setNumber: $setNumber, reps: $reps, weightKg: $weightKg, durationSecs: $durationSecs, distanceM: $distanceM, completed: $completed, isWarmup: $isWarmup)';
}


}

/// @nodoc
abstract mixin class _$SessionSetCopyWith<$Res> implements $SessionSetCopyWith<$Res> {
  factory _$SessionSetCopyWith(_SessionSet value, $Res Function(_SessionSet) _then) = __$SessionSetCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'session_exercise_id') String sessionExerciseId,@JsonKey(name: 'set_number') int setNumber, int? reps,@JsonKey(name: 'weight_kg') double? weightKg,@JsonKey(name: 'duration_secs') int? durationSecs,@JsonKey(name: 'distance_m') double? distanceM, bool completed,@JsonKey(name: 'is_warmup') bool isWarmup
});




}
/// @nodoc
class __$SessionSetCopyWithImpl<$Res>
    implements _$SessionSetCopyWith<$Res> {
  __$SessionSetCopyWithImpl(this._self, this._then);

  final _SessionSet _self;
  final $Res Function(_SessionSet) _then;

/// Create a copy of SessionSet
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? sessionExerciseId = null,Object? setNumber = null,Object? reps = freezed,Object? weightKg = freezed,Object? durationSecs = freezed,Object? distanceM = freezed,Object? completed = null,Object? isWarmup = null,}) {
  return _then(_SessionSet(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,sessionExerciseId: null == sessionExerciseId ? _self.sessionExerciseId : sessionExerciseId // ignore: cast_nullable_to_non_nullable
as String,setNumber: null == setNumber ? _self.setNumber : setNumber // ignore: cast_nullable_to_non_nullable
as int,reps: freezed == reps ? _self.reps : reps // ignore: cast_nullable_to_non_nullable
as int?,weightKg: freezed == weightKg ? _self.weightKg : weightKg // ignore: cast_nullable_to_non_nullable
as double?,durationSecs: freezed == durationSecs ? _self.durationSecs : durationSecs // ignore: cast_nullable_to_non_nullable
as int?,distanceM: freezed == distanceM ? _self.distanceM : distanceM // ignore: cast_nullable_to_non_nullable
as double?,completed: null == completed ? _self.completed : completed // ignore: cast_nullable_to_non_nullable
as bool,isWarmup: null == isWarmup ? _self.isWarmup : isWarmup // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
