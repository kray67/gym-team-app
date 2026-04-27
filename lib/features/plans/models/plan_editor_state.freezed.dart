// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'plan_editor_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PlanEditorSet {

 String get id; int get setNumber; int? get targetReps; int? get targetRepsMax; double? get targetWeight;// % 1RM value
 double? get targetRpe; double? get targetRpeMax; bool get isWarmup; double? get weightIncrement; int? get targetDurationSecs;
/// Create a copy of PlanEditorSet
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlanEditorSetCopyWith<PlanEditorSet> get copyWith => _$PlanEditorSetCopyWithImpl<PlanEditorSet>(this as PlanEditorSet, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlanEditorSet&&(identical(other.id, id) || other.id == id)&&(identical(other.setNumber, setNumber) || other.setNumber == setNumber)&&(identical(other.targetReps, targetReps) || other.targetReps == targetReps)&&(identical(other.targetRepsMax, targetRepsMax) || other.targetRepsMax == targetRepsMax)&&(identical(other.targetWeight, targetWeight) || other.targetWeight == targetWeight)&&(identical(other.targetRpe, targetRpe) || other.targetRpe == targetRpe)&&(identical(other.targetRpeMax, targetRpeMax) || other.targetRpeMax == targetRpeMax)&&(identical(other.isWarmup, isWarmup) || other.isWarmup == isWarmup)&&(identical(other.weightIncrement, weightIncrement) || other.weightIncrement == weightIncrement)&&(identical(other.targetDurationSecs, targetDurationSecs) || other.targetDurationSecs == targetDurationSecs));
}


@override
int get hashCode => Object.hash(runtimeType,id,setNumber,targetReps,targetRepsMax,targetWeight,targetRpe,targetRpeMax,isWarmup,weightIncrement,targetDurationSecs);

@override
String toString() {
  return 'PlanEditorSet(id: $id, setNumber: $setNumber, targetReps: $targetReps, targetRepsMax: $targetRepsMax, targetWeight: $targetWeight, targetRpe: $targetRpe, targetRpeMax: $targetRpeMax, isWarmup: $isWarmup, weightIncrement: $weightIncrement, targetDurationSecs: $targetDurationSecs)';
}


}

/// @nodoc
abstract mixin class $PlanEditorSetCopyWith<$Res>  {
  factory $PlanEditorSetCopyWith(PlanEditorSet value, $Res Function(PlanEditorSet) _then) = _$PlanEditorSetCopyWithImpl;
@useResult
$Res call({
 String id, int setNumber, int? targetReps, int? targetRepsMax, double? targetWeight, double? targetRpe, double? targetRpeMax, bool isWarmup, double? weightIncrement, int? targetDurationSecs
});




}
/// @nodoc
class _$PlanEditorSetCopyWithImpl<$Res>
    implements $PlanEditorSetCopyWith<$Res> {
  _$PlanEditorSetCopyWithImpl(this._self, this._then);

  final PlanEditorSet _self;
  final $Res Function(PlanEditorSet) _then;

/// Create a copy of PlanEditorSet
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? setNumber = null,Object? targetReps = freezed,Object? targetRepsMax = freezed,Object? targetWeight = freezed,Object? targetRpe = freezed,Object? targetRpeMax = freezed,Object? isWarmup = null,Object? weightIncrement = freezed,Object? targetDurationSecs = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,setNumber: null == setNumber ? _self.setNumber : setNumber // ignore: cast_nullable_to_non_nullable
as int,targetReps: freezed == targetReps ? _self.targetReps : targetReps // ignore: cast_nullable_to_non_nullable
as int?,targetRepsMax: freezed == targetRepsMax ? _self.targetRepsMax : targetRepsMax // ignore: cast_nullable_to_non_nullable
as int?,targetWeight: freezed == targetWeight ? _self.targetWeight : targetWeight // ignore: cast_nullable_to_non_nullable
as double?,targetRpe: freezed == targetRpe ? _self.targetRpe : targetRpe // ignore: cast_nullable_to_non_nullable
as double?,targetRpeMax: freezed == targetRpeMax ? _self.targetRpeMax : targetRpeMax // ignore: cast_nullable_to_non_nullable
as double?,isWarmup: null == isWarmup ? _self.isWarmup : isWarmup // ignore: cast_nullable_to_non_nullable
as bool,weightIncrement: freezed == weightIncrement ? _self.weightIncrement : weightIncrement // ignore: cast_nullable_to_non_nullable
as double?,targetDurationSecs: freezed == targetDurationSecs ? _self.targetDurationSecs : targetDurationSecs // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [PlanEditorSet].
extension PlanEditorSetPatterns on PlanEditorSet {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlanEditorSet value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlanEditorSet() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlanEditorSet value)  $default,){
final _that = this;
switch (_that) {
case _PlanEditorSet():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlanEditorSet value)?  $default,){
final _that = this;
switch (_that) {
case _PlanEditorSet() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  int setNumber,  int? targetReps,  int? targetRepsMax,  double? targetWeight,  double? targetRpe,  double? targetRpeMax,  bool isWarmup,  double? weightIncrement,  int? targetDurationSecs)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlanEditorSet() when $default != null:
return $default(_that.id,_that.setNumber,_that.targetReps,_that.targetRepsMax,_that.targetWeight,_that.targetRpe,_that.targetRpeMax,_that.isWarmup,_that.weightIncrement,_that.targetDurationSecs);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  int setNumber,  int? targetReps,  int? targetRepsMax,  double? targetWeight,  double? targetRpe,  double? targetRpeMax,  bool isWarmup,  double? weightIncrement,  int? targetDurationSecs)  $default,) {final _that = this;
switch (_that) {
case _PlanEditorSet():
return $default(_that.id,_that.setNumber,_that.targetReps,_that.targetRepsMax,_that.targetWeight,_that.targetRpe,_that.targetRpeMax,_that.isWarmup,_that.weightIncrement,_that.targetDurationSecs);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  int setNumber,  int? targetReps,  int? targetRepsMax,  double? targetWeight,  double? targetRpe,  double? targetRpeMax,  bool isWarmup,  double? weightIncrement,  int? targetDurationSecs)?  $default,) {final _that = this;
switch (_that) {
case _PlanEditorSet() when $default != null:
return $default(_that.id,_that.setNumber,_that.targetReps,_that.targetRepsMax,_that.targetWeight,_that.targetRpe,_that.targetRpeMax,_that.isWarmup,_that.weightIncrement,_that.targetDurationSecs);case _:
  return null;

}
}

}

/// @nodoc


class _PlanEditorSet implements PlanEditorSet {
  const _PlanEditorSet({required this.id, required this.setNumber, this.targetReps, this.targetRepsMax, this.targetWeight, this.targetRpe, this.targetRpeMax, this.isWarmup = false, this.weightIncrement, this.targetDurationSecs});
  

@override final  String id;
@override final  int setNumber;
@override final  int? targetReps;
@override final  int? targetRepsMax;
@override final  double? targetWeight;
// % 1RM value
@override final  double? targetRpe;
@override final  double? targetRpeMax;
@override@JsonKey() final  bool isWarmup;
@override final  double? weightIncrement;
@override final  int? targetDurationSecs;

/// Create a copy of PlanEditorSet
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlanEditorSetCopyWith<_PlanEditorSet> get copyWith => __$PlanEditorSetCopyWithImpl<_PlanEditorSet>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlanEditorSet&&(identical(other.id, id) || other.id == id)&&(identical(other.setNumber, setNumber) || other.setNumber == setNumber)&&(identical(other.targetReps, targetReps) || other.targetReps == targetReps)&&(identical(other.targetRepsMax, targetRepsMax) || other.targetRepsMax == targetRepsMax)&&(identical(other.targetWeight, targetWeight) || other.targetWeight == targetWeight)&&(identical(other.targetRpe, targetRpe) || other.targetRpe == targetRpe)&&(identical(other.targetRpeMax, targetRpeMax) || other.targetRpeMax == targetRpeMax)&&(identical(other.isWarmup, isWarmup) || other.isWarmup == isWarmup)&&(identical(other.weightIncrement, weightIncrement) || other.weightIncrement == weightIncrement)&&(identical(other.targetDurationSecs, targetDurationSecs) || other.targetDurationSecs == targetDurationSecs));
}


@override
int get hashCode => Object.hash(runtimeType,id,setNumber,targetReps,targetRepsMax,targetWeight,targetRpe,targetRpeMax,isWarmup,weightIncrement,targetDurationSecs);

@override
String toString() {
  return 'PlanEditorSet(id: $id, setNumber: $setNumber, targetReps: $targetReps, targetRepsMax: $targetRepsMax, targetWeight: $targetWeight, targetRpe: $targetRpe, targetRpeMax: $targetRpeMax, isWarmup: $isWarmup, weightIncrement: $weightIncrement, targetDurationSecs: $targetDurationSecs)';
}


}

/// @nodoc
abstract mixin class _$PlanEditorSetCopyWith<$Res> implements $PlanEditorSetCopyWith<$Res> {
  factory _$PlanEditorSetCopyWith(_PlanEditorSet value, $Res Function(_PlanEditorSet) _then) = __$PlanEditorSetCopyWithImpl;
@override @useResult
$Res call({
 String id, int setNumber, int? targetReps, int? targetRepsMax, double? targetWeight, double? targetRpe, double? targetRpeMax, bool isWarmup, double? weightIncrement, int? targetDurationSecs
});




}
/// @nodoc
class __$PlanEditorSetCopyWithImpl<$Res>
    implements _$PlanEditorSetCopyWith<$Res> {
  __$PlanEditorSetCopyWithImpl(this._self, this._then);

  final _PlanEditorSet _self;
  final $Res Function(_PlanEditorSet) _then;

/// Create a copy of PlanEditorSet
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? setNumber = null,Object? targetReps = freezed,Object? targetRepsMax = freezed,Object? targetWeight = freezed,Object? targetRpe = freezed,Object? targetRpeMax = freezed,Object? isWarmup = null,Object? weightIncrement = freezed,Object? targetDurationSecs = freezed,}) {
  return _then(_PlanEditorSet(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,setNumber: null == setNumber ? _self.setNumber : setNumber // ignore: cast_nullable_to_non_nullable
as int,targetReps: freezed == targetReps ? _self.targetReps : targetReps // ignore: cast_nullable_to_non_nullable
as int?,targetRepsMax: freezed == targetRepsMax ? _self.targetRepsMax : targetRepsMax // ignore: cast_nullable_to_non_nullable
as int?,targetWeight: freezed == targetWeight ? _self.targetWeight : targetWeight // ignore: cast_nullable_to_non_nullable
as double?,targetRpe: freezed == targetRpe ? _self.targetRpe : targetRpe // ignore: cast_nullable_to_non_nullable
as double?,targetRpeMax: freezed == targetRpeMax ? _self.targetRpeMax : targetRpeMax // ignore: cast_nullable_to_non_nullable
as double?,isWarmup: null == isWarmup ? _self.isWarmup : isWarmup // ignore: cast_nullable_to_non_nullable
as bool,weightIncrement: freezed == weightIncrement ? _self.weightIncrement : weightIncrement // ignore: cast_nullable_to_non_nullable
as double?,targetDurationSecs: freezed == targetDurationSecs ? _self.targetDurationSecs : targetDurationSecs // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc
mixin _$PlanEditorExercise {

 String get id; Exercise get exercise; String get goalType;// 'reps' | 'reps_range' | 'amrap' | 'time'
 String get weightType;// 'percent_1rm' | 'rpe' | 'rpe_range'
 List<PlanEditorSet> get sets; int get weekNumber; int get sessionNumber; String? get supersetGroupId;
/// Create a copy of PlanEditorExercise
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlanEditorExerciseCopyWith<PlanEditorExercise> get copyWith => _$PlanEditorExerciseCopyWithImpl<PlanEditorExercise>(this as PlanEditorExercise, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlanEditorExercise&&(identical(other.id, id) || other.id == id)&&(identical(other.exercise, exercise) || other.exercise == exercise)&&(identical(other.goalType, goalType) || other.goalType == goalType)&&(identical(other.weightType, weightType) || other.weightType == weightType)&&const DeepCollectionEquality().equals(other.sets, sets)&&(identical(other.weekNumber, weekNumber) || other.weekNumber == weekNumber)&&(identical(other.sessionNumber, sessionNumber) || other.sessionNumber == sessionNumber)&&(identical(other.supersetGroupId, supersetGroupId) || other.supersetGroupId == supersetGroupId));
}


@override
int get hashCode => Object.hash(runtimeType,id,exercise,goalType,weightType,const DeepCollectionEquality().hash(sets),weekNumber,sessionNumber,supersetGroupId);

@override
String toString() {
  return 'PlanEditorExercise(id: $id, exercise: $exercise, goalType: $goalType, weightType: $weightType, sets: $sets, weekNumber: $weekNumber, sessionNumber: $sessionNumber, supersetGroupId: $supersetGroupId)';
}


}

/// @nodoc
abstract mixin class $PlanEditorExerciseCopyWith<$Res>  {
  factory $PlanEditorExerciseCopyWith(PlanEditorExercise value, $Res Function(PlanEditorExercise) _then) = _$PlanEditorExerciseCopyWithImpl;
@useResult
$Res call({
 String id, Exercise exercise, String goalType, String weightType, List<PlanEditorSet> sets, int weekNumber, int sessionNumber, String? supersetGroupId
});


$ExerciseCopyWith<$Res> get exercise;

}
/// @nodoc
class _$PlanEditorExerciseCopyWithImpl<$Res>
    implements $PlanEditorExerciseCopyWith<$Res> {
  _$PlanEditorExerciseCopyWithImpl(this._self, this._then);

  final PlanEditorExercise _self;
  final $Res Function(PlanEditorExercise) _then;

/// Create a copy of PlanEditorExercise
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? exercise = null,Object? goalType = null,Object? weightType = null,Object? sets = null,Object? weekNumber = null,Object? sessionNumber = null,Object? supersetGroupId = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,exercise: null == exercise ? _self.exercise : exercise // ignore: cast_nullable_to_non_nullable
as Exercise,goalType: null == goalType ? _self.goalType : goalType // ignore: cast_nullable_to_non_nullable
as String,weightType: null == weightType ? _self.weightType : weightType // ignore: cast_nullable_to_non_nullable
as String,sets: null == sets ? _self.sets : sets // ignore: cast_nullable_to_non_nullable
as List<PlanEditorSet>,weekNumber: null == weekNumber ? _self.weekNumber : weekNumber // ignore: cast_nullable_to_non_nullable
as int,sessionNumber: null == sessionNumber ? _self.sessionNumber : sessionNumber // ignore: cast_nullable_to_non_nullable
as int,supersetGroupId: freezed == supersetGroupId ? _self.supersetGroupId : supersetGroupId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of PlanEditorExercise
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ExerciseCopyWith<$Res> get exercise {
  
  return $ExerciseCopyWith<$Res>(_self.exercise, (value) {
    return _then(_self.copyWith(exercise: value));
  });
}
}


/// Adds pattern-matching-related methods to [PlanEditorExercise].
extension PlanEditorExercisePatterns on PlanEditorExercise {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlanEditorExercise value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlanEditorExercise() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlanEditorExercise value)  $default,){
final _that = this;
switch (_that) {
case _PlanEditorExercise():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlanEditorExercise value)?  $default,){
final _that = this;
switch (_that) {
case _PlanEditorExercise() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  Exercise exercise,  String goalType,  String weightType,  List<PlanEditorSet> sets,  int weekNumber,  int sessionNumber,  String? supersetGroupId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlanEditorExercise() when $default != null:
return $default(_that.id,_that.exercise,_that.goalType,_that.weightType,_that.sets,_that.weekNumber,_that.sessionNumber,_that.supersetGroupId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  Exercise exercise,  String goalType,  String weightType,  List<PlanEditorSet> sets,  int weekNumber,  int sessionNumber,  String? supersetGroupId)  $default,) {final _that = this;
switch (_that) {
case _PlanEditorExercise():
return $default(_that.id,_that.exercise,_that.goalType,_that.weightType,_that.sets,_that.weekNumber,_that.sessionNumber,_that.supersetGroupId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  Exercise exercise,  String goalType,  String weightType,  List<PlanEditorSet> sets,  int weekNumber,  int sessionNumber,  String? supersetGroupId)?  $default,) {final _that = this;
switch (_that) {
case _PlanEditorExercise() when $default != null:
return $default(_that.id,_that.exercise,_that.goalType,_that.weightType,_that.sets,_that.weekNumber,_that.sessionNumber,_that.supersetGroupId);case _:
  return null;

}
}

}

/// @nodoc


class _PlanEditorExercise implements PlanEditorExercise {
  const _PlanEditorExercise({required this.id, required this.exercise, this.goalType = 'reps', this.weightType = 'percent_1rm', final  List<PlanEditorSet> sets = const [], this.weekNumber = 1, this.sessionNumber = 1, this.supersetGroupId}): _sets = sets;
  

@override final  String id;
@override final  Exercise exercise;
@override@JsonKey() final  String goalType;
// 'reps' | 'reps_range' | 'amrap' | 'time'
@override@JsonKey() final  String weightType;
// 'percent_1rm' | 'rpe' | 'rpe_range'
 final  List<PlanEditorSet> _sets;
// 'percent_1rm' | 'rpe' | 'rpe_range'
@override@JsonKey() List<PlanEditorSet> get sets {
  if (_sets is EqualUnmodifiableListView) return _sets;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sets);
}

@override@JsonKey() final  int weekNumber;
@override@JsonKey() final  int sessionNumber;
@override final  String? supersetGroupId;

/// Create a copy of PlanEditorExercise
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlanEditorExerciseCopyWith<_PlanEditorExercise> get copyWith => __$PlanEditorExerciseCopyWithImpl<_PlanEditorExercise>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlanEditorExercise&&(identical(other.id, id) || other.id == id)&&(identical(other.exercise, exercise) || other.exercise == exercise)&&(identical(other.goalType, goalType) || other.goalType == goalType)&&(identical(other.weightType, weightType) || other.weightType == weightType)&&const DeepCollectionEquality().equals(other._sets, _sets)&&(identical(other.weekNumber, weekNumber) || other.weekNumber == weekNumber)&&(identical(other.sessionNumber, sessionNumber) || other.sessionNumber == sessionNumber)&&(identical(other.supersetGroupId, supersetGroupId) || other.supersetGroupId == supersetGroupId));
}


@override
int get hashCode => Object.hash(runtimeType,id,exercise,goalType,weightType,const DeepCollectionEquality().hash(_sets),weekNumber,sessionNumber,supersetGroupId);

@override
String toString() {
  return 'PlanEditorExercise(id: $id, exercise: $exercise, goalType: $goalType, weightType: $weightType, sets: $sets, weekNumber: $weekNumber, sessionNumber: $sessionNumber, supersetGroupId: $supersetGroupId)';
}


}

/// @nodoc
abstract mixin class _$PlanEditorExerciseCopyWith<$Res> implements $PlanEditorExerciseCopyWith<$Res> {
  factory _$PlanEditorExerciseCopyWith(_PlanEditorExercise value, $Res Function(_PlanEditorExercise) _then) = __$PlanEditorExerciseCopyWithImpl;
@override @useResult
$Res call({
 String id, Exercise exercise, String goalType, String weightType, List<PlanEditorSet> sets, int weekNumber, int sessionNumber, String? supersetGroupId
});


@override $ExerciseCopyWith<$Res> get exercise;

}
/// @nodoc
class __$PlanEditorExerciseCopyWithImpl<$Res>
    implements _$PlanEditorExerciseCopyWith<$Res> {
  __$PlanEditorExerciseCopyWithImpl(this._self, this._then);

  final _PlanEditorExercise _self;
  final $Res Function(_PlanEditorExercise) _then;

/// Create a copy of PlanEditorExercise
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? exercise = null,Object? goalType = null,Object? weightType = null,Object? sets = null,Object? weekNumber = null,Object? sessionNumber = null,Object? supersetGroupId = freezed,}) {
  return _then(_PlanEditorExercise(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,exercise: null == exercise ? _self.exercise : exercise // ignore: cast_nullable_to_non_nullable
as Exercise,goalType: null == goalType ? _self.goalType : goalType // ignore: cast_nullable_to_non_nullable
as String,weightType: null == weightType ? _self.weightType : weightType // ignore: cast_nullable_to_non_nullable
as String,sets: null == sets ? _self._sets : sets // ignore: cast_nullable_to_non_nullable
as List<PlanEditorSet>,weekNumber: null == weekNumber ? _self.weekNumber : weekNumber // ignore: cast_nullable_to_non_nullable
as int,sessionNumber: null == sessionNumber ? _self.sessionNumber : sessionNumber // ignore: cast_nullable_to_non_nullable
as int,supersetGroupId: freezed == supersetGroupId ? _self.supersetGroupId : supersetGroupId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of PlanEditorExercise
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
mixin _$PlanEditorState {

 String? get planId; String get title; String get description; bool get isPublic; int get weeks; int get sessionsPerWeek; int get avgDurationMins; String get difficulty; String get equipment; List<PlanEditorExercise> get exercises;
/// Create a copy of PlanEditorState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlanEditorStateCopyWith<PlanEditorState> get copyWith => _$PlanEditorStateCopyWithImpl<PlanEditorState>(this as PlanEditorState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlanEditorState&&(identical(other.planId, planId) || other.planId == planId)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.isPublic, isPublic) || other.isPublic == isPublic)&&(identical(other.weeks, weeks) || other.weeks == weeks)&&(identical(other.sessionsPerWeek, sessionsPerWeek) || other.sessionsPerWeek == sessionsPerWeek)&&(identical(other.avgDurationMins, avgDurationMins) || other.avgDurationMins == avgDurationMins)&&(identical(other.difficulty, difficulty) || other.difficulty == difficulty)&&(identical(other.equipment, equipment) || other.equipment == equipment)&&const DeepCollectionEquality().equals(other.exercises, exercises));
}


@override
int get hashCode => Object.hash(runtimeType,planId,title,description,isPublic,weeks,sessionsPerWeek,avgDurationMins,difficulty,equipment,const DeepCollectionEquality().hash(exercises));

@override
String toString() {
  return 'PlanEditorState(planId: $planId, title: $title, description: $description, isPublic: $isPublic, weeks: $weeks, sessionsPerWeek: $sessionsPerWeek, avgDurationMins: $avgDurationMins, difficulty: $difficulty, equipment: $equipment, exercises: $exercises)';
}


}

/// @nodoc
abstract mixin class $PlanEditorStateCopyWith<$Res>  {
  factory $PlanEditorStateCopyWith(PlanEditorState value, $Res Function(PlanEditorState) _then) = _$PlanEditorStateCopyWithImpl;
@useResult
$Res call({
 String? planId, String title, String description, bool isPublic, int weeks, int sessionsPerWeek, int avgDurationMins, String difficulty, String equipment, List<PlanEditorExercise> exercises
});




}
/// @nodoc
class _$PlanEditorStateCopyWithImpl<$Res>
    implements $PlanEditorStateCopyWith<$Res> {
  _$PlanEditorStateCopyWithImpl(this._self, this._then);

  final PlanEditorState _self;
  final $Res Function(PlanEditorState) _then;

/// Create a copy of PlanEditorState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? planId = freezed,Object? title = null,Object? description = null,Object? isPublic = null,Object? weeks = null,Object? sessionsPerWeek = null,Object? avgDurationMins = null,Object? difficulty = null,Object? equipment = null,Object? exercises = null,}) {
  return _then(_self.copyWith(
planId: freezed == planId ? _self.planId : planId // ignore: cast_nullable_to_non_nullable
as String?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,isPublic: null == isPublic ? _self.isPublic : isPublic // ignore: cast_nullable_to_non_nullable
as bool,weeks: null == weeks ? _self.weeks : weeks // ignore: cast_nullable_to_non_nullable
as int,sessionsPerWeek: null == sessionsPerWeek ? _self.sessionsPerWeek : sessionsPerWeek // ignore: cast_nullable_to_non_nullable
as int,avgDurationMins: null == avgDurationMins ? _self.avgDurationMins : avgDurationMins // ignore: cast_nullable_to_non_nullable
as int,difficulty: null == difficulty ? _self.difficulty : difficulty // ignore: cast_nullable_to_non_nullable
as String,equipment: null == equipment ? _self.equipment : equipment // ignore: cast_nullable_to_non_nullable
as String,exercises: null == exercises ? _self.exercises : exercises // ignore: cast_nullable_to_non_nullable
as List<PlanEditorExercise>,
  ));
}

}


/// Adds pattern-matching-related methods to [PlanEditorState].
extension PlanEditorStatePatterns on PlanEditorState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlanEditorState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlanEditorState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlanEditorState value)  $default,){
final _that = this;
switch (_that) {
case _PlanEditorState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlanEditorState value)?  $default,){
final _that = this;
switch (_that) {
case _PlanEditorState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? planId,  String title,  String description,  bool isPublic,  int weeks,  int sessionsPerWeek,  int avgDurationMins,  String difficulty,  String equipment,  List<PlanEditorExercise> exercises)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlanEditorState() when $default != null:
return $default(_that.planId,_that.title,_that.description,_that.isPublic,_that.weeks,_that.sessionsPerWeek,_that.avgDurationMins,_that.difficulty,_that.equipment,_that.exercises);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? planId,  String title,  String description,  bool isPublic,  int weeks,  int sessionsPerWeek,  int avgDurationMins,  String difficulty,  String equipment,  List<PlanEditorExercise> exercises)  $default,) {final _that = this;
switch (_that) {
case _PlanEditorState():
return $default(_that.planId,_that.title,_that.description,_that.isPublic,_that.weeks,_that.sessionsPerWeek,_that.avgDurationMins,_that.difficulty,_that.equipment,_that.exercises);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? planId,  String title,  String description,  bool isPublic,  int weeks,  int sessionsPerWeek,  int avgDurationMins,  String difficulty,  String equipment,  List<PlanEditorExercise> exercises)?  $default,) {final _that = this;
switch (_that) {
case _PlanEditorState() when $default != null:
return $default(_that.planId,_that.title,_that.description,_that.isPublic,_that.weeks,_that.sessionsPerWeek,_that.avgDurationMins,_that.difficulty,_that.equipment,_that.exercises);case _:
  return null;

}
}

}

/// @nodoc


class _PlanEditorState implements PlanEditorState {
  const _PlanEditorState({this.planId, this.title = '', this.description = '', this.isPublic = false, this.weeks = 4, this.sessionsPerWeek = 3, this.avgDurationMins = 60, this.difficulty = 'intermediate', this.equipment = 'commercial_gym', final  List<PlanEditorExercise> exercises = const []}): _exercises = exercises;
  

@override final  String? planId;
@override@JsonKey() final  String title;
@override@JsonKey() final  String description;
@override@JsonKey() final  bool isPublic;
@override@JsonKey() final  int weeks;
@override@JsonKey() final  int sessionsPerWeek;
@override@JsonKey() final  int avgDurationMins;
@override@JsonKey() final  String difficulty;
@override@JsonKey() final  String equipment;
 final  List<PlanEditorExercise> _exercises;
@override@JsonKey() List<PlanEditorExercise> get exercises {
  if (_exercises is EqualUnmodifiableListView) return _exercises;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_exercises);
}


/// Create a copy of PlanEditorState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlanEditorStateCopyWith<_PlanEditorState> get copyWith => __$PlanEditorStateCopyWithImpl<_PlanEditorState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlanEditorState&&(identical(other.planId, planId) || other.planId == planId)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.isPublic, isPublic) || other.isPublic == isPublic)&&(identical(other.weeks, weeks) || other.weeks == weeks)&&(identical(other.sessionsPerWeek, sessionsPerWeek) || other.sessionsPerWeek == sessionsPerWeek)&&(identical(other.avgDurationMins, avgDurationMins) || other.avgDurationMins == avgDurationMins)&&(identical(other.difficulty, difficulty) || other.difficulty == difficulty)&&(identical(other.equipment, equipment) || other.equipment == equipment)&&const DeepCollectionEquality().equals(other._exercises, _exercises));
}


@override
int get hashCode => Object.hash(runtimeType,planId,title,description,isPublic,weeks,sessionsPerWeek,avgDurationMins,difficulty,equipment,const DeepCollectionEquality().hash(_exercises));

@override
String toString() {
  return 'PlanEditorState(planId: $planId, title: $title, description: $description, isPublic: $isPublic, weeks: $weeks, sessionsPerWeek: $sessionsPerWeek, avgDurationMins: $avgDurationMins, difficulty: $difficulty, equipment: $equipment, exercises: $exercises)';
}


}

/// @nodoc
abstract mixin class _$PlanEditorStateCopyWith<$Res> implements $PlanEditorStateCopyWith<$Res> {
  factory _$PlanEditorStateCopyWith(_PlanEditorState value, $Res Function(_PlanEditorState) _then) = __$PlanEditorStateCopyWithImpl;
@override @useResult
$Res call({
 String? planId, String title, String description, bool isPublic, int weeks, int sessionsPerWeek, int avgDurationMins, String difficulty, String equipment, List<PlanEditorExercise> exercises
});




}
/// @nodoc
class __$PlanEditorStateCopyWithImpl<$Res>
    implements _$PlanEditorStateCopyWith<$Res> {
  __$PlanEditorStateCopyWithImpl(this._self, this._then);

  final _PlanEditorState _self;
  final $Res Function(_PlanEditorState) _then;

/// Create a copy of PlanEditorState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? planId = freezed,Object? title = null,Object? description = null,Object? isPublic = null,Object? weeks = null,Object? sessionsPerWeek = null,Object? avgDurationMins = null,Object? difficulty = null,Object? equipment = null,Object? exercises = null,}) {
  return _then(_PlanEditorState(
planId: freezed == planId ? _self.planId : planId // ignore: cast_nullable_to_non_nullable
as String?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,isPublic: null == isPublic ? _self.isPublic : isPublic // ignore: cast_nullable_to_non_nullable
as bool,weeks: null == weeks ? _self.weeks : weeks // ignore: cast_nullable_to_non_nullable
as int,sessionsPerWeek: null == sessionsPerWeek ? _self.sessionsPerWeek : sessionsPerWeek // ignore: cast_nullable_to_non_nullable
as int,avgDurationMins: null == avgDurationMins ? _self.avgDurationMins : avgDurationMins // ignore: cast_nullable_to_non_nullable
as int,difficulty: null == difficulty ? _self.difficulty : difficulty // ignore: cast_nullable_to_non_nullable
as String,equipment: null == equipment ? _self.equipment : equipment // ignore: cast_nullable_to_non_nullable
as String,exercises: null == exercises ? _self._exercises : exercises // ignore: cast_nullable_to_non_nullable
as List<PlanEditorExercise>,
  ));
}


}

// dart format on
