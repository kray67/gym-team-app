// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'active_workout_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ActiveSetEntry {

 String get id; int get setNumber; int? get reps; double? get weightKg; double? get rpe; bool get completed; bool get isWarmup;/// Pre-computed target text shown in TARGET column for plan-based workouts.
/// Line 1 and line 2 separated by '\n'. Null for free workouts.
 String? get targetText;
/// Create a copy of ActiveSetEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ActiveSetEntryCopyWith<ActiveSetEntry> get copyWith => _$ActiveSetEntryCopyWithImpl<ActiveSetEntry>(this as ActiveSetEntry, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ActiveSetEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.setNumber, setNumber) || other.setNumber == setNumber)&&(identical(other.reps, reps) || other.reps == reps)&&(identical(other.weightKg, weightKg) || other.weightKg == weightKg)&&(identical(other.rpe, rpe) || other.rpe == rpe)&&(identical(other.completed, completed) || other.completed == completed)&&(identical(other.isWarmup, isWarmup) || other.isWarmup == isWarmup)&&(identical(other.targetText, targetText) || other.targetText == targetText));
}


@override
int get hashCode => Object.hash(runtimeType,id,setNumber,reps,weightKg,rpe,completed,isWarmup,targetText);

@override
String toString() {
  return 'ActiveSetEntry(id: $id, setNumber: $setNumber, reps: $reps, weightKg: $weightKg, rpe: $rpe, completed: $completed, isWarmup: $isWarmup, targetText: $targetText)';
}


}

/// @nodoc
abstract mixin class $ActiveSetEntryCopyWith<$Res>  {
  factory $ActiveSetEntryCopyWith(ActiveSetEntry value, $Res Function(ActiveSetEntry) _then) = _$ActiveSetEntryCopyWithImpl;
@useResult
$Res call({
 String id, int setNumber, int? reps, double? weightKg, double? rpe, bool completed, bool isWarmup, String? targetText
});




}
/// @nodoc
class _$ActiveSetEntryCopyWithImpl<$Res>
    implements $ActiveSetEntryCopyWith<$Res> {
  _$ActiveSetEntryCopyWithImpl(this._self, this._then);

  final ActiveSetEntry _self;
  final $Res Function(ActiveSetEntry) _then;

/// Create a copy of ActiveSetEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? setNumber = null,Object? reps = freezed,Object? weightKg = freezed,Object? rpe = freezed,Object? completed = null,Object? isWarmup = null,Object? targetText = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,setNumber: null == setNumber ? _self.setNumber : setNumber // ignore: cast_nullable_to_non_nullable
as int,reps: freezed == reps ? _self.reps : reps // ignore: cast_nullable_to_non_nullable
as int?,weightKg: freezed == weightKg ? _self.weightKg : weightKg // ignore: cast_nullable_to_non_nullable
as double?,rpe: freezed == rpe ? _self.rpe : rpe // ignore: cast_nullable_to_non_nullable
as double?,completed: null == completed ? _self.completed : completed // ignore: cast_nullable_to_non_nullable
as bool,isWarmup: null == isWarmup ? _self.isWarmup : isWarmup // ignore: cast_nullable_to_non_nullable
as bool,targetText: freezed == targetText ? _self.targetText : targetText // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ActiveSetEntry].
extension ActiveSetEntryPatterns on ActiveSetEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ActiveSetEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ActiveSetEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ActiveSetEntry value)  $default,){
final _that = this;
switch (_that) {
case _ActiveSetEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ActiveSetEntry value)?  $default,){
final _that = this;
switch (_that) {
case _ActiveSetEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  int setNumber,  int? reps,  double? weightKg,  double? rpe,  bool completed,  bool isWarmup,  String? targetText)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ActiveSetEntry() when $default != null:
return $default(_that.id,_that.setNumber,_that.reps,_that.weightKg,_that.rpe,_that.completed,_that.isWarmup,_that.targetText);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  int setNumber,  int? reps,  double? weightKg,  double? rpe,  bool completed,  bool isWarmup,  String? targetText)  $default,) {final _that = this;
switch (_that) {
case _ActiveSetEntry():
return $default(_that.id,_that.setNumber,_that.reps,_that.weightKg,_that.rpe,_that.completed,_that.isWarmup,_that.targetText);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  int setNumber,  int? reps,  double? weightKg,  double? rpe,  bool completed,  bool isWarmup,  String? targetText)?  $default,) {final _that = this;
switch (_that) {
case _ActiveSetEntry() when $default != null:
return $default(_that.id,_that.setNumber,_that.reps,_that.weightKg,_that.rpe,_that.completed,_that.isWarmup,_that.targetText);case _:
  return null;

}
}

}

/// @nodoc


class _ActiveSetEntry implements ActiveSetEntry {
  const _ActiveSetEntry({required this.id, required this.setNumber, this.reps, this.weightKg, this.rpe, this.completed = false, this.isWarmup = false, this.targetText});
  

@override final  String id;
@override final  int setNumber;
@override final  int? reps;
@override final  double? weightKg;
@override final  double? rpe;
@override@JsonKey() final  bool completed;
@override@JsonKey() final  bool isWarmup;
/// Pre-computed target text shown in TARGET column for plan-based workouts.
/// Line 1 and line 2 separated by '\n'. Null for free workouts.
@override final  String? targetText;

/// Create a copy of ActiveSetEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ActiveSetEntryCopyWith<_ActiveSetEntry> get copyWith => __$ActiveSetEntryCopyWithImpl<_ActiveSetEntry>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ActiveSetEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.setNumber, setNumber) || other.setNumber == setNumber)&&(identical(other.reps, reps) || other.reps == reps)&&(identical(other.weightKg, weightKg) || other.weightKg == weightKg)&&(identical(other.rpe, rpe) || other.rpe == rpe)&&(identical(other.completed, completed) || other.completed == completed)&&(identical(other.isWarmup, isWarmup) || other.isWarmup == isWarmup)&&(identical(other.targetText, targetText) || other.targetText == targetText));
}


@override
int get hashCode => Object.hash(runtimeType,id,setNumber,reps,weightKg,rpe,completed,isWarmup,targetText);

@override
String toString() {
  return 'ActiveSetEntry(id: $id, setNumber: $setNumber, reps: $reps, weightKg: $weightKg, rpe: $rpe, completed: $completed, isWarmup: $isWarmup, targetText: $targetText)';
}


}

/// @nodoc
abstract mixin class _$ActiveSetEntryCopyWith<$Res> implements $ActiveSetEntryCopyWith<$Res> {
  factory _$ActiveSetEntryCopyWith(_ActiveSetEntry value, $Res Function(_ActiveSetEntry) _then) = __$ActiveSetEntryCopyWithImpl;
@override @useResult
$Res call({
 String id, int setNumber, int? reps, double? weightKg, double? rpe, bool completed, bool isWarmup, String? targetText
});




}
/// @nodoc
class __$ActiveSetEntryCopyWithImpl<$Res>
    implements _$ActiveSetEntryCopyWith<$Res> {
  __$ActiveSetEntryCopyWithImpl(this._self, this._then);

  final _ActiveSetEntry _self;
  final $Res Function(_ActiveSetEntry) _then;

/// Create a copy of ActiveSetEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? setNumber = null,Object? reps = freezed,Object? weightKg = freezed,Object? rpe = freezed,Object? completed = null,Object? isWarmup = null,Object? targetText = freezed,}) {
  return _then(_ActiveSetEntry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,setNumber: null == setNumber ? _self.setNumber : setNumber // ignore: cast_nullable_to_non_nullable
as int,reps: freezed == reps ? _self.reps : reps // ignore: cast_nullable_to_non_nullable
as int?,weightKg: freezed == weightKg ? _self.weightKg : weightKg // ignore: cast_nullable_to_non_nullable
as double?,rpe: freezed == rpe ? _self.rpe : rpe // ignore: cast_nullable_to_non_nullable
as double?,completed: null == completed ? _self.completed : completed // ignore: cast_nullable_to_non_nullable
as bool,isWarmup: null == isWarmup ? _self.isWarmup : isWarmup // ignore: cast_nullable_to_non_nullable
as bool,targetText: freezed == targetText ? _self.targetText : targetText // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$ActiveExerciseEntry {

 String get id; Exercise get exercise;/// 'kg' | 'percent_1rm' | 'rpe'
 String get weightType; List<ActiveSetEntry> get sets; String? get supersetGroupId;/// Optional coach/user note shown below the muscle group label.
 String? get note;
/// Create a copy of ActiveExerciseEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ActiveExerciseEntryCopyWith<ActiveExerciseEntry> get copyWith => _$ActiveExerciseEntryCopyWithImpl<ActiveExerciseEntry>(this as ActiveExerciseEntry, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ActiveExerciseEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.exercise, exercise) || other.exercise == exercise)&&(identical(other.weightType, weightType) || other.weightType == weightType)&&const DeepCollectionEquality().equals(other.sets, sets)&&(identical(other.supersetGroupId, supersetGroupId) || other.supersetGroupId == supersetGroupId)&&(identical(other.note, note) || other.note == note));
}


@override
int get hashCode => Object.hash(runtimeType,id,exercise,weightType,const DeepCollectionEquality().hash(sets),supersetGroupId,note);

@override
String toString() {
  return 'ActiveExerciseEntry(id: $id, exercise: $exercise, weightType: $weightType, sets: $sets, supersetGroupId: $supersetGroupId, note: $note)';
}


}

/// @nodoc
abstract mixin class $ActiveExerciseEntryCopyWith<$Res>  {
  factory $ActiveExerciseEntryCopyWith(ActiveExerciseEntry value, $Res Function(ActiveExerciseEntry) _then) = _$ActiveExerciseEntryCopyWithImpl;
@useResult
$Res call({
 String id, Exercise exercise, String weightType, List<ActiveSetEntry> sets, String? supersetGroupId, String? note
});


$ExerciseCopyWith<$Res> get exercise;

}
/// @nodoc
class _$ActiveExerciseEntryCopyWithImpl<$Res>
    implements $ActiveExerciseEntryCopyWith<$Res> {
  _$ActiveExerciseEntryCopyWithImpl(this._self, this._then);

  final ActiveExerciseEntry _self;
  final $Res Function(ActiveExerciseEntry) _then;

/// Create a copy of ActiveExerciseEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? exercise = null,Object? weightType = null,Object? sets = null,Object? supersetGroupId = freezed,Object? note = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,exercise: null == exercise ? _self.exercise : exercise // ignore: cast_nullable_to_non_nullable
as Exercise,weightType: null == weightType ? _self.weightType : weightType // ignore: cast_nullable_to_non_nullable
as String,sets: null == sets ? _self.sets : sets // ignore: cast_nullable_to_non_nullable
as List<ActiveSetEntry>,supersetGroupId: freezed == supersetGroupId ? _self.supersetGroupId : supersetGroupId // ignore: cast_nullable_to_non_nullable
as String?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of ActiveExerciseEntry
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ExerciseCopyWith<$Res> get exercise {
  
  return $ExerciseCopyWith<$Res>(_self.exercise, (value) {
    return _then(_self.copyWith(exercise: value));
  });
}
}


/// Adds pattern-matching-related methods to [ActiveExerciseEntry].
extension ActiveExerciseEntryPatterns on ActiveExerciseEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ActiveExerciseEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ActiveExerciseEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ActiveExerciseEntry value)  $default,){
final _that = this;
switch (_that) {
case _ActiveExerciseEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ActiveExerciseEntry value)?  $default,){
final _that = this;
switch (_that) {
case _ActiveExerciseEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  Exercise exercise,  String weightType,  List<ActiveSetEntry> sets,  String? supersetGroupId,  String? note)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ActiveExerciseEntry() when $default != null:
return $default(_that.id,_that.exercise,_that.weightType,_that.sets,_that.supersetGroupId,_that.note);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  Exercise exercise,  String weightType,  List<ActiveSetEntry> sets,  String? supersetGroupId,  String? note)  $default,) {final _that = this;
switch (_that) {
case _ActiveExerciseEntry():
return $default(_that.id,_that.exercise,_that.weightType,_that.sets,_that.supersetGroupId,_that.note);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  Exercise exercise,  String weightType,  List<ActiveSetEntry> sets,  String? supersetGroupId,  String? note)?  $default,) {final _that = this;
switch (_that) {
case _ActiveExerciseEntry() when $default != null:
return $default(_that.id,_that.exercise,_that.weightType,_that.sets,_that.supersetGroupId,_that.note);case _:
  return null;

}
}

}

/// @nodoc


class _ActiveExerciseEntry implements ActiveExerciseEntry {
  const _ActiveExerciseEntry({required this.id, required this.exercise, this.weightType = 'kg', final  List<ActiveSetEntry> sets = const [], this.supersetGroupId, this.note}): _sets = sets;
  

@override final  String id;
@override final  Exercise exercise;
/// 'kg' | 'percent_1rm' | 'rpe'
@override@JsonKey() final  String weightType;
 final  List<ActiveSetEntry> _sets;
@override@JsonKey() List<ActiveSetEntry> get sets {
  if (_sets is EqualUnmodifiableListView) return _sets;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sets);
}

@override final  String? supersetGroupId;
/// Optional coach/user note shown below the muscle group label.
@override final  String? note;

/// Create a copy of ActiveExerciseEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ActiveExerciseEntryCopyWith<_ActiveExerciseEntry> get copyWith => __$ActiveExerciseEntryCopyWithImpl<_ActiveExerciseEntry>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ActiveExerciseEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.exercise, exercise) || other.exercise == exercise)&&(identical(other.weightType, weightType) || other.weightType == weightType)&&const DeepCollectionEquality().equals(other._sets, _sets)&&(identical(other.supersetGroupId, supersetGroupId) || other.supersetGroupId == supersetGroupId)&&(identical(other.note, note) || other.note == note));
}


@override
int get hashCode => Object.hash(runtimeType,id,exercise,weightType,const DeepCollectionEquality().hash(_sets),supersetGroupId,note);

@override
String toString() {
  return 'ActiveExerciseEntry(id: $id, exercise: $exercise, weightType: $weightType, sets: $sets, supersetGroupId: $supersetGroupId, note: $note)';
}


}

/// @nodoc
abstract mixin class _$ActiveExerciseEntryCopyWith<$Res> implements $ActiveExerciseEntryCopyWith<$Res> {
  factory _$ActiveExerciseEntryCopyWith(_ActiveExerciseEntry value, $Res Function(_ActiveExerciseEntry) _then) = __$ActiveExerciseEntryCopyWithImpl;
@override @useResult
$Res call({
 String id, Exercise exercise, String weightType, List<ActiveSetEntry> sets, String? supersetGroupId, String? note
});


@override $ExerciseCopyWith<$Res> get exercise;

}
/// @nodoc
class __$ActiveExerciseEntryCopyWithImpl<$Res>
    implements _$ActiveExerciseEntryCopyWith<$Res> {
  __$ActiveExerciseEntryCopyWithImpl(this._self, this._then);

  final _ActiveExerciseEntry _self;
  final $Res Function(_ActiveExerciseEntry) _then;

/// Create a copy of ActiveExerciseEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? exercise = null,Object? weightType = null,Object? sets = null,Object? supersetGroupId = freezed,Object? note = freezed,}) {
  return _then(_ActiveExerciseEntry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,exercise: null == exercise ? _self.exercise : exercise // ignore: cast_nullable_to_non_nullable
as Exercise,weightType: null == weightType ? _self.weightType : weightType // ignore: cast_nullable_to_non_nullable
as String,sets: null == sets ? _self._sets : sets // ignore: cast_nullable_to_non_nullable
as List<ActiveSetEntry>,supersetGroupId: freezed == supersetGroupId ? _self.supersetGroupId : supersetGroupId // ignore: cast_nullable_to_non_nullable
as String?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of ActiveExerciseEntry
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ExerciseCopyWith<$Res> get exercise {
  
  return $ExerciseCopyWith<$Res>(_self.exercise, (value) {
    return _then(_self.copyWith(exercise: value));
  });
}
}

/// @nodoc
mixin _$ActiveWorkoutState {

 String get sessionId; String? get planId; int? get weekNumber; int? get sessionNumber; DateTime get startedAt; List<ActiveExerciseEntry> get exercises;
/// Create a copy of ActiveWorkoutState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ActiveWorkoutStateCopyWith<ActiveWorkoutState> get copyWith => _$ActiveWorkoutStateCopyWithImpl<ActiveWorkoutState>(this as ActiveWorkoutState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ActiveWorkoutState&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.planId, planId) || other.planId == planId)&&(identical(other.weekNumber, weekNumber) || other.weekNumber == weekNumber)&&(identical(other.sessionNumber, sessionNumber) || other.sessionNumber == sessionNumber)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&const DeepCollectionEquality().equals(other.exercises, exercises));
}


@override
int get hashCode => Object.hash(runtimeType,sessionId,planId,weekNumber,sessionNumber,startedAt,const DeepCollectionEquality().hash(exercises));

@override
String toString() {
  return 'ActiveWorkoutState(sessionId: $sessionId, planId: $planId, weekNumber: $weekNumber, sessionNumber: $sessionNumber, startedAt: $startedAt, exercises: $exercises)';
}


}

/// @nodoc
abstract mixin class $ActiveWorkoutStateCopyWith<$Res>  {
  factory $ActiveWorkoutStateCopyWith(ActiveWorkoutState value, $Res Function(ActiveWorkoutState) _then) = _$ActiveWorkoutStateCopyWithImpl;
@useResult
$Res call({
 String sessionId, String? planId, int? weekNumber, int? sessionNumber, DateTime startedAt, List<ActiveExerciseEntry> exercises
});




}
/// @nodoc
class _$ActiveWorkoutStateCopyWithImpl<$Res>
    implements $ActiveWorkoutStateCopyWith<$Res> {
  _$ActiveWorkoutStateCopyWithImpl(this._self, this._then);

  final ActiveWorkoutState _self;
  final $Res Function(ActiveWorkoutState) _then;

/// Create a copy of ActiveWorkoutState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sessionId = null,Object? planId = freezed,Object? weekNumber = freezed,Object? sessionNumber = freezed,Object? startedAt = null,Object? exercises = null,}) {
  return _then(_self.copyWith(
sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String,planId: freezed == planId ? _self.planId : planId // ignore: cast_nullable_to_non_nullable
as String?,weekNumber: freezed == weekNumber ? _self.weekNumber : weekNumber // ignore: cast_nullable_to_non_nullable
as int?,sessionNumber: freezed == sessionNumber ? _self.sessionNumber : sessionNumber // ignore: cast_nullable_to_non_nullable
as int?,startedAt: null == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime,exercises: null == exercises ? _self.exercises : exercises // ignore: cast_nullable_to_non_nullable
as List<ActiveExerciseEntry>,
  ));
}

}


/// Adds pattern-matching-related methods to [ActiveWorkoutState].
extension ActiveWorkoutStatePatterns on ActiveWorkoutState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ActiveWorkoutState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ActiveWorkoutState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ActiveWorkoutState value)  $default,){
final _that = this;
switch (_that) {
case _ActiveWorkoutState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ActiveWorkoutState value)?  $default,){
final _that = this;
switch (_that) {
case _ActiveWorkoutState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String sessionId,  String? planId,  int? weekNumber,  int? sessionNumber,  DateTime startedAt,  List<ActiveExerciseEntry> exercises)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ActiveWorkoutState() when $default != null:
return $default(_that.sessionId,_that.planId,_that.weekNumber,_that.sessionNumber,_that.startedAt,_that.exercises);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String sessionId,  String? planId,  int? weekNumber,  int? sessionNumber,  DateTime startedAt,  List<ActiveExerciseEntry> exercises)  $default,) {final _that = this;
switch (_that) {
case _ActiveWorkoutState():
return $default(_that.sessionId,_that.planId,_that.weekNumber,_that.sessionNumber,_that.startedAt,_that.exercises);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String sessionId,  String? planId,  int? weekNumber,  int? sessionNumber,  DateTime startedAt,  List<ActiveExerciseEntry> exercises)?  $default,) {final _that = this;
switch (_that) {
case _ActiveWorkoutState() when $default != null:
return $default(_that.sessionId,_that.planId,_that.weekNumber,_that.sessionNumber,_that.startedAt,_that.exercises);case _:
  return null;

}
}

}

/// @nodoc


class _ActiveWorkoutState implements ActiveWorkoutState {
  const _ActiveWorkoutState({required this.sessionId, this.planId, this.weekNumber, this.sessionNumber, required this.startedAt, final  List<ActiveExerciseEntry> exercises = const []}): _exercises = exercises;
  

@override final  String sessionId;
@override final  String? planId;
@override final  int? weekNumber;
@override final  int? sessionNumber;
@override final  DateTime startedAt;
 final  List<ActiveExerciseEntry> _exercises;
@override@JsonKey() List<ActiveExerciseEntry> get exercises {
  if (_exercises is EqualUnmodifiableListView) return _exercises;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_exercises);
}


/// Create a copy of ActiveWorkoutState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ActiveWorkoutStateCopyWith<_ActiveWorkoutState> get copyWith => __$ActiveWorkoutStateCopyWithImpl<_ActiveWorkoutState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ActiveWorkoutState&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.planId, planId) || other.planId == planId)&&(identical(other.weekNumber, weekNumber) || other.weekNumber == weekNumber)&&(identical(other.sessionNumber, sessionNumber) || other.sessionNumber == sessionNumber)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&const DeepCollectionEquality().equals(other._exercises, _exercises));
}


@override
int get hashCode => Object.hash(runtimeType,sessionId,planId,weekNumber,sessionNumber,startedAt,const DeepCollectionEquality().hash(_exercises));

@override
String toString() {
  return 'ActiveWorkoutState(sessionId: $sessionId, planId: $planId, weekNumber: $weekNumber, sessionNumber: $sessionNumber, startedAt: $startedAt, exercises: $exercises)';
}


}

/// @nodoc
abstract mixin class _$ActiveWorkoutStateCopyWith<$Res> implements $ActiveWorkoutStateCopyWith<$Res> {
  factory _$ActiveWorkoutStateCopyWith(_ActiveWorkoutState value, $Res Function(_ActiveWorkoutState) _then) = __$ActiveWorkoutStateCopyWithImpl;
@override @useResult
$Res call({
 String sessionId, String? planId, int? weekNumber, int? sessionNumber, DateTime startedAt, List<ActiveExerciseEntry> exercises
});




}
/// @nodoc
class __$ActiveWorkoutStateCopyWithImpl<$Res>
    implements _$ActiveWorkoutStateCopyWith<$Res> {
  __$ActiveWorkoutStateCopyWithImpl(this._self, this._then);

  final _ActiveWorkoutState _self;
  final $Res Function(_ActiveWorkoutState) _then;

/// Create a copy of ActiveWorkoutState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sessionId = null,Object? planId = freezed,Object? weekNumber = freezed,Object? sessionNumber = freezed,Object? startedAt = null,Object? exercises = null,}) {
  return _then(_ActiveWorkoutState(
sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String,planId: freezed == planId ? _self.planId : planId // ignore: cast_nullable_to_non_nullable
as String?,weekNumber: freezed == weekNumber ? _self.weekNumber : weekNumber // ignore: cast_nullable_to_non_nullable
as int?,sessionNumber: freezed == sessionNumber ? _self.sessionNumber : sessionNumber // ignore: cast_nullable_to_non_nullable
as int?,startedAt: null == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime,exercises: null == exercises ? _self._exercises : exercises // ignore: cast_nullable_to_non_nullable
as List<ActiveExerciseEntry>,
  ));
}


}

// dart format on
