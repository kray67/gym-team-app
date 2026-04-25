// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'plan_exercise.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PlanExercise {

 String get id;@JsonKey(name: 'plan_id') String get planId;@JsonKey(name: 'exercise_id') String get exerciseId; int get position;@JsonKey(name: 'goal_type') String get goalType;// 'reps' | 'reps_range' | 'amrap'
@JsonKey(name: 'weight_type') String get weightType;// 'percent_1rm' | 'rpe' | 'rpe_range'
@JsonKey(name: 'week_number') int get weekNumber;@JsonKey(name: 'session_number') int get sessionNumber;@JsonKey(name: 'exercises') Exercise? get exercise;@JsonKey(name: 'plan_exercise_sets') List<PlanExerciseSet> get sets;@JsonKey(name: 'superset_group_id') String? get supersetGroupId;
/// Create a copy of PlanExercise
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlanExerciseCopyWith<PlanExercise> get copyWith => _$PlanExerciseCopyWithImpl<PlanExercise>(this as PlanExercise, _$identity);

  /// Serializes this PlanExercise to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlanExercise&&(identical(other.id, id) || other.id == id)&&(identical(other.planId, planId) || other.planId == planId)&&(identical(other.exerciseId, exerciseId) || other.exerciseId == exerciseId)&&(identical(other.position, position) || other.position == position)&&(identical(other.goalType, goalType) || other.goalType == goalType)&&(identical(other.weightType, weightType) || other.weightType == weightType)&&(identical(other.weekNumber, weekNumber) || other.weekNumber == weekNumber)&&(identical(other.sessionNumber, sessionNumber) || other.sessionNumber == sessionNumber)&&(identical(other.exercise, exercise) || other.exercise == exercise)&&const DeepCollectionEquality().equals(other.sets, sets)&&(identical(other.supersetGroupId, supersetGroupId) || other.supersetGroupId == supersetGroupId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,planId,exerciseId,position,goalType,weightType,weekNumber,sessionNumber,exercise,const DeepCollectionEquality().hash(sets),supersetGroupId);

@override
String toString() {
  return 'PlanExercise(id: $id, planId: $planId, exerciseId: $exerciseId, position: $position, goalType: $goalType, weightType: $weightType, weekNumber: $weekNumber, sessionNumber: $sessionNumber, exercise: $exercise, sets: $sets, supersetGroupId: $supersetGroupId)';
}


}

/// @nodoc
abstract mixin class $PlanExerciseCopyWith<$Res>  {
  factory $PlanExerciseCopyWith(PlanExercise value, $Res Function(PlanExercise) _then) = _$PlanExerciseCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'plan_id') String planId,@JsonKey(name: 'exercise_id') String exerciseId, int position,@JsonKey(name: 'goal_type') String goalType,@JsonKey(name: 'weight_type') String weightType,@JsonKey(name: 'week_number') int weekNumber,@JsonKey(name: 'session_number') int sessionNumber,@JsonKey(name: 'exercises') Exercise? exercise,@JsonKey(name: 'plan_exercise_sets') List<PlanExerciseSet> sets,@JsonKey(name: 'superset_group_id') String? supersetGroupId
});


$ExerciseCopyWith<$Res>? get exercise;

}
/// @nodoc
class _$PlanExerciseCopyWithImpl<$Res>
    implements $PlanExerciseCopyWith<$Res> {
  _$PlanExerciseCopyWithImpl(this._self, this._then);

  final PlanExercise _self;
  final $Res Function(PlanExercise) _then;

/// Create a copy of PlanExercise
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? planId = null,Object? exerciseId = null,Object? position = null,Object? goalType = null,Object? weightType = null,Object? weekNumber = null,Object? sessionNumber = null,Object? exercise = freezed,Object? sets = null,Object? supersetGroupId = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,planId: null == planId ? _self.planId : planId // ignore: cast_nullable_to_non_nullable
as String,exerciseId: null == exerciseId ? _self.exerciseId : exerciseId // ignore: cast_nullable_to_non_nullable
as String,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as int,goalType: null == goalType ? _self.goalType : goalType // ignore: cast_nullable_to_non_nullable
as String,weightType: null == weightType ? _self.weightType : weightType // ignore: cast_nullable_to_non_nullable
as String,weekNumber: null == weekNumber ? _self.weekNumber : weekNumber // ignore: cast_nullable_to_non_nullable
as int,sessionNumber: null == sessionNumber ? _self.sessionNumber : sessionNumber // ignore: cast_nullable_to_non_nullable
as int,exercise: freezed == exercise ? _self.exercise : exercise // ignore: cast_nullable_to_non_nullable
as Exercise?,sets: null == sets ? _self.sets : sets // ignore: cast_nullable_to_non_nullable
as List<PlanExerciseSet>,supersetGroupId: freezed == supersetGroupId ? _self.supersetGroupId : supersetGroupId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of PlanExercise
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ExerciseCopyWith<$Res>? get exercise {
    if (_self.exercise == null) {
    return null;
  }

  return $ExerciseCopyWith<$Res>(_self.exercise!, (value) {
    return _then(_self.copyWith(exercise: value));
  });
}
}


/// Adds pattern-matching-related methods to [PlanExercise].
extension PlanExercisePatterns on PlanExercise {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlanExercise value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlanExercise() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlanExercise value)  $default,){
final _that = this;
switch (_that) {
case _PlanExercise():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlanExercise value)?  $default,){
final _that = this;
switch (_that) {
case _PlanExercise() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'plan_id')  String planId, @JsonKey(name: 'exercise_id')  String exerciseId,  int position, @JsonKey(name: 'goal_type')  String goalType, @JsonKey(name: 'weight_type')  String weightType, @JsonKey(name: 'week_number')  int weekNumber, @JsonKey(name: 'session_number')  int sessionNumber, @JsonKey(name: 'exercises')  Exercise? exercise, @JsonKey(name: 'plan_exercise_sets')  List<PlanExerciseSet> sets, @JsonKey(name: 'superset_group_id')  String? supersetGroupId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlanExercise() when $default != null:
return $default(_that.id,_that.planId,_that.exerciseId,_that.position,_that.goalType,_that.weightType,_that.weekNumber,_that.sessionNumber,_that.exercise,_that.sets,_that.supersetGroupId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'plan_id')  String planId, @JsonKey(name: 'exercise_id')  String exerciseId,  int position, @JsonKey(name: 'goal_type')  String goalType, @JsonKey(name: 'weight_type')  String weightType, @JsonKey(name: 'week_number')  int weekNumber, @JsonKey(name: 'session_number')  int sessionNumber, @JsonKey(name: 'exercises')  Exercise? exercise, @JsonKey(name: 'plan_exercise_sets')  List<PlanExerciseSet> sets, @JsonKey(name: 'superset_group_id')  String? supersetGroupId)  $default,) {final _that = this;
switch (_that) {
case _PlanExercise():
return $default(_that.id,_that.planId,_that.exerciseId,_that.position,_that.goalType,_that.weightType,_that.weekNumber,_that.sessionNumber,_that.exercise,_that.sets,_that.supersetGroupId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'plan_id')  String planId, @JsonKey(name: 'exercise_id')  String exerciseId,  int position, @JsonKey(name: 'goal_type')  String goalType, @JsonKey(name: 'weight_type')  String weightType, @JsonKey(name: 'week_number')  int weekNumber, @JsonKey(name: 'session_number')  int sessionNumber, @JsonKey(name: 'exercises')  Exercise? exercise, @JsonKey(name: 'plan_exercise_sets')  List<PlanExerciseSet> sets, @JsonKey(name: 'superset_group_id')  String? supersetGroupId)?  $default,) {final _that = this;
switch (_that) {
case _PlanExercise() when $default != null:
return $default(_that.id,_that.planId,_that.exerciseId,_that.position,_that.goalType,_that.weightType,_that.weekNumber,_that.sessionNumber,_that.exercise,_that.sets,_that.supersetGroupId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlanExercise implements PlanExercise {
  const _PlanExercise({required this.id, @JsonKey(name: 'plan_id') required this.planId, @JsonKey(name: 'exercise_id') required this.exerciseId, required this.position, @JsonKey(name: 'goal_type') this.goalType = 'reps', @JsonKey(name: 'weight_type') this.weightType = 'percent_1rm', @JsonKey(name: 'week_number') this.weekNumber = 1, @JsonKey(name: 'session_number') this.sessionNumber = 1, @JsonKey(name: 'exercises') this.exercise, @JsonKey(name: 'plan_exercise_sets') final  List<PlanExerciseSet> sets = const [], @JsonKey(name: 'superset_group_id') this.supersetGroupId}): _sets = sets;
  factory _PlanExercise.fromJson(Map<String, dynamic> json) => _$PlanExerciseFromJson(json);

@override final  String id;
@override@JsonKey(name: 'plan_id') final  String planId;
@override@JsonKey(name: 'exercise_id') final  String exerciseId;
@override final  int position;
@override@JsonKey(name: 'goal_type') final  String goalType;
// 'reps' | 'reps_range' | 'amrap'
@override@JsonKey(name: 'weight_type') final  String weightType;
// 'percent_1rm' | 'rpe' | 'rpe_range'
@override@JsonKey(name: 'week_number') final  int weekNumber;
@override@JsonKey(name: 'session_number') final  int sessionNumber;
@override@JsonKey(name: 'exercises') final  Exercise? exercise;
 final  List<PlanExerciseSet> _sets;
@override@JsonKey(name: 'plan_exercise_sets') List<PlanExerciseSet> get sets {
  if (_sets is EqualUnmodifiableListView) return _sets;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sets);
}

@override@JsonKey(name: 'superset_group_id') final  String? supersetGroupId;

/// Create a copy of PlanExercise
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlanExerciseCopyWith<_PlanExercise> get copyWith => __$PlanExerciseCopyWithImpl<_PlanExercise>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlanExerciseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlanExercise&&(identical(other.id, id) || other.id == id)&&(identical(other.planId, planId) || other.planId == planId)&&(identical(other.exerciseId, exerciseId) || other.exerciseId == exerciseId)&&(identical(other.position, position) || other.position == position)&&(identical(other.goalType, goalType) || other.goalType == goalType)&&(identical(other.weightType, weightType) || other.weightType == weightType)&&(identical(other.weekNumber, weekNumber) || other.weekNumber == weekNumber)&&(identical(other.sessionNumber, sessionNumber) || other.sessionNumber == sessionNumber)&&(identical(other.exercise, exercise) || other.exercise == exercise)&&const DeepCollectionEquality().equals(other._sets, _sets)&&(identical(other.supersetGroupId, supersetGroupId) || other.supersetGroupId == supersetGroupId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,planId,exerciseId,position,goalType,weightType,weekNumber,sessionNumber,exercise,const DeepCollectionEquality().hash(_sets),supersetGroupId);

@override
String toString() {
  return 'PlanExercise(id: $id, planId: $planId, exerciseId: $exerciseId, position: $position, goalType: $goalType, weightType: $weightType, weekNumber: $weekNumber, sessionNumber: $sessionNumber, exercise: $exercise, sets: $sets, supersetGroupId: $supersetGroupId)';
}


}

/// @nodoc
abstract mixin class _$PlanExerciseCopyWith<$Res> implements $PlanExerciseCopyWith<$Res> {
  factory _$PlanExerciseCopyWith(_PlanExercise value, $Res Function(_PlanExercise) _then) = __$PlanExerciseCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'plan_id') String planId,@JsonKey(name: 'exercise_id') String exerciseId, int position,@JsonKey(name: 'goal_type') String goalType,@JsonKey(name: 'weight_type') String weightType,@JsonKey(name: 'week_number') int weekNumber,@JsonKey(name: 'session_number') int sessionNumber,@JsonKey(name: 'exercises') Exercise? exercise,@JsonKey(name: 'plan_exercise_sets') List<PlanExerciseSet> sets,@JsonKey(name: 'superset_group_id') String? supersetGroupId
});


@override $ExerciseCopyWith<$Res>? get exercise;

}
/// @nodoc
class __$PlanExerciseCopyWithImpl<$Res>
    implements _$PlanExerciseCopyWith<$Res> {
  __$PlanExerciseCopyWithImpl(this._self, this._then);

  final _PlanExercise _self;
  final $Res Function(_PlanExercise) _then;

/// Create a copy of PlanExercise
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? planId = null,Object? exerciseId = null,Object? position = null,Object? goalType = null,Object? weightType = null,Object? weekNumber = null,Object? sessionNumber = null,Object? exercise = freezed,Object? sets = null,Object? supersetGroupId = freezed,}) {
  return _then(_PlanExercise(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,planId: null == planId ? _self.planId : planId // ignore: cast_nullable_to_non_nullable
as String,exerciseId: null == exerciseId ? _self.exerciseId : exerciseId // ignore: cast_nullable_to_non_nullable
as String,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as int,goalType: null == goalType ? _self.goalType : goalType // ignore: cast_nullable_to_non_nullable
as String,weightType: null == weightType ? _self.weightType : weightType // ignore: cast_nullable_to_non_nullable
as String,weekNumber: null == weekNumber ? _self.weekNumber : weekNumber // ignore: cast_nullable_to_non_nullable
as int,sessionNumber: null == sessionNumber ? _self.sessionNumber : sessionNumber // ignore: cast_nullable_to_non_nullable
as int,exercise: freezed == exercise ? _self.exercise : exercise // ignore: cast_nullable_to_non_nullable
as Exercise?,sets: null == sets ? _self._sets : sets // ignore: cast_nullable_to_non_nullable
as List<PlanExerciseSet>,supersetGroupId: freezed == supersetGroupId ? _self.supersetGroupId : supersetGroupId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of PlanExercise
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ExerciseCopyWith<$Res>? get exercise {
    if (_self.exercise == null) {
    return null;
  }

  return $ExerciseCopyWith<$Res>(_self.exercise!, (value) {
    return _then(_self.copyWith(exercise: value));
  });
}
}

// dart format on
