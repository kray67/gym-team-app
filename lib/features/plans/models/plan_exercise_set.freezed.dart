// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'plan_exercise_set.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PlanExerciseSet {

 String get id;@JsonKey(name: 'plan_exercise_id') String get planExerciseId;@JsonKey(name: 'set_number') int get setNumber;@JsonKey(name: 'target_reps') int? get targetReps;@JsonKey(name: 'target_reps_max') int? get targetRepsMax;@JsonKey(name: 'target_weight') double? get targetWeight;// stores % 1RM value
@JsonKey(name: 'target_rpe') double? get targetRpe;@JsonKey(name: 'target_rpe_max') double? get targetRpeMax;@JsonKey(name: 'is_warmup') bool get isWarmup;@JsonKey(name: 'weight_increment') double? get weightIncrement;
/// Create a copy of PlanExerciseSet
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlanExerciseSetCopyWith<PlanExerciseSet> get copyWith => _$PlanExerciseSetCopyWithImpl<PlanExerciseSet>(this as PlanExerciseSet, _$identity);

  /// Serializes this PlanExerciseSet to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlanExerciseSet&&(identical(other.id, id) || other.id == id)&&(identical(other.planExerciseId, planExerciseId) || other.planExerciseId == planExerciseId)&&(identical(other.setNumber, setNumber) || other.setNumber == setNumber)&&(identical(other.targetReps, targetReps) || other.targetReps == targetReps)&&(identical(other.targetRepsMax, targetRepsMax) || other.targetRepsMax == targetRepsMax)&&(identical(other.targetWeight, targetWeight) || other.targetWeight == targetWeight)&&(identical(other.targetRpe, targetRpe) || other.targetRpe == targetRpe)&&(identical(other.targetRpeMax, targetRpeMax) || other.targetRpeMax == targetRpeMax)&&(identical(other.isWarmup, isWarmup) || other.isWarmup == isWarmup)&&(identical(other.weightIncrement, weightIncrement) || other.weightIncrement == weightIncrement));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,planExerciseId,setNumber,targetReps,targetRepsMax,targetWeight,targetRpe,targetRpeMax,isWarmup,weightIncrement);

@override
String toString() {
  return 'PlanExerciseSet(id: $id, planExerciseId: $planExerciseId, setNumber: $setNumber, targetReps: $targetReps, targetRepsMax: $targetRepsMax, targetWeight: $targetWeight, targetRpe: $targetRpe, targetRpeMax: $targetRpeMax, isWarmup: $isWarmup, weightIncrement: $weightIncrement)';
}


}

/// @nodoc
abstract mixin class $PlanExerciseSetCopyWith<$Res>  {
  factory $PlanExerciseSetCopyWith(PlanExerciseSet value, $Res Function(PlanExerciseSet) _then) = _$PlanExerciseSetCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'plan_exercise_id') String planExerciseId,@JsonKey(name: 'set_number') int setNumber,@JsonKey(name: 'target_reps') int? targetReps,@JsonKey(name: 'target_reps_max') int? targetRepsMax,@JsonKey(name: 'target_weight') double? targetWeight,@JsonKey(name: 'target_rpe') double? targetRpe,@JsonKey(name: 'target_rpe_max') double? targetRpeMax,@JsonKey(name: 'is_warmup') bool isWarmup,@JsonKey(name: 'weight_increment') double? weightIncrement
});




}
/// @nodoc
class _$PlanExerciseSetCopyWithImpl<$Res>
    implements $PlanExerciseSetCopyWith<$Res> {
  _$PlanExerciseSetCopyWithImpl(this._self, this._then);

  final PlanExerciseSet _self;
  final $Res Function(PlanExerciseSet) _then;

/// Create a copy of PlanExerciseSet
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? planExerciseId = null,Object? setNumber = null,Object? targetReps = freezed,Object? targetRepsMax = freezed,Object? targetWeight = freezed,Object? targetRpe = freezed,Object? targetRpeMax = freezed,Object? isWarmup = null,Object? weightIncrement = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,planExerciseId: null == planExerciseId ? _self.planExerciseId : planExerciseId // ignore: cast_nullable_to_non_nullable
as String,setNumber: null == setNumber ? _self.setNumber : setNumber // ignore: cast_nullable_to_non_nullable
as int,targetReps: freezed == targetReps ? _self.targetReps : targetReps // ignore: cast_nullable_to_non_nullable
as int?,targetRepsMax: freezed == targetRepsMax ? _self.targetRepsMax : targetRepsMax // ignore: cast_nullable_to_non_nullable
as int?,targetWeight: freezed == targetWeight ? _self.targetWeight : targetWeight // ignore: cast_nullable_to_non_nullable
as double?,targetRpe: freezed == targetRpe ? _self.targetRpe : targetRpe // ignore: cast_nullable_to_non_nullable
as double?,targetRpeMax: freezed == targetRpeMax ? _self.targetRpeMax : targetRpeMax // ignore: cast_nullable_to_non_nullable
as double?,isWarmup: null == isWarmup ? _self.isWarmup : isWarmup // ignore: cast_nullable_to_non_nullable
as bool,weightIncrement: freezed == weightIncrement ? _self.weightIncrement : weightIncrement // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [PlanExerciseSet].
extension PlanExerciseSetPatterns on PlanExerciseSet {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlanExerciseSet value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlanExerciseSet() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlanExerciseSet value)  $default,){
final _that = this;
switch (_that) {
case _PlanExerciseSet():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlanExerciseSet value)?  $default,){
final _that = this;
switch (_that) {
case _PlanExerciseSet() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'plan_exercise_id')  String planExerciseId, @JsonKey(name: 'set_number')  int setNumber, @JsonKey(name: 'target_reps')  int? targetReps, @JsonKey(name: 'target_reps_max')  int? targetRepsMax, @JsonKey(name: 'target_weight')  double? targetWeight, @JsonKey(name: 'target_rpe')  double? targetRpe, @JsonKey(name: 'target_rpe_max')  double? targetRpeMax, @JsonKey(name: 'is_warmup')  bool isWarmup, @JsonKey(name: 'weight_increment')  double? weightIncrement)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlanExerciseSet() when $default != null:
return $default(_that.id,_that.planExerciseId,_that.setNumber,_that.targetReps,_that.targetRepsMax,_that.targetWeight,_that.targetRpe,_that.targetRpeMax,_that.isWarmup,_that.weightIncrement);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'plan_exercise_id')  String planExerciseId, @JsonKey(name: 'set_number')  int setNumber, @JsonKey(name: 'target_reps')  int? targetReps, @JsonKey(name: 'target_reps_max')  int? targetRepsMax, @JsonKey(name: 'target_weight')  double? targetWeight, @JsonKey(name: 'target_rpe')  double? targetRpe, @JsonKey(name: 'target_rpe_max')  double? targetRpeMax, @JsonKey(name: 'is_warmup')  bool isWarmup, @JsonKey(name: 'weight_increment')  double? weightIncrement)  $default,) {final _that = this;
switch (_that) {
case _PlanExerciseSet():
return $default(_that.id,_that.planExerciseId,_that.setNumber,_that.targetReps,_that.targetRepsMax,_that.targetWeight,_that.targetRpe,_that.targetRpeMax,_that.isWarmup,_that.weightIncrement);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'plan_exercise_id')  String planExerciseId, @JsonKey(name: 'set_number')  int setNumber, @JsonKey(name: 'target_reps')  int? targetReps, @JsonKey(name: 'target_reps_max')  int? targetRepsMax, @JsonKey(name: 'target_weight')  double? targetWeight, @JsonKey(name: 'target_rpe')  double? targetRpe, @JsonKey(name: 'target_rpe_max')  double? targetRpeMax, @JsonKey(name: 'is_warmup')  bool isWarmup, @JsonKey(name: 'weight_increment')  double? weightIncrement)?  $default,) {final _that = this;
switch (_that) {
case _PlanExerciseSet() when $default != null:
return $default(_that.id,_that.planExerciseId,_that.setNumber,_that.targetReps,_that.targetRepsMax,_that.targetWeight,_that.targetRpe,_that.targetRpeMax,_that.isWarmup,_that.weightIncrement);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlanExerciseSet implements PlanExerciseSet {
  const _PlanExerciseSet({required this.id, @JsonKey(name: 'plan_exercise_id') required this.planExerciseId, @JsonKey(name: 'set_number') required this.setNumber, @JsonKey(name: 'target_reps') this.targetReps, @JsonKey(name: 'target_reps_max') this.targetRepsMax, @JsonKey(name: 'target_weight') this.targetWeight, @JsonKey(name: 'target_rpe') this.targetRpe, @JsonKey(name: 'target_rpe_max') this.targetRpeMax, @JsonKey(name: 'is_warmup') this.isWarmup = false, @JsonKey(name: 'weight_increment') this.weightIncrement});
  factory _PlanExerciseSet.fromJson(Map<String, dynamic> json) => _$PlanExerciseSetFromJson(json);

@override final  String id;
@override@JsonKey(name: 'plan_exercise_id') final  String planExerciseId;
@override@JsonKey(name: 'set_number') final  int setNumber;
@override@JsonKey(name: 'target_reps') final  int? targetReps;
@override@JsonKey(name: 'target_reps_max') final  int? targetRepsMax;
@override@JsonKey(name: 'target_weight') final  double? targetWeight;
// stores % 1RM value
@override@JsonKey(name: 'target_rpe') final  double? targetRpe;
@override@JsonKey(name: 'target_rpe_max') final  double? targetRpeMax;
@override@JsonKey(name: 'is_warmup') final  bool isWarmup;
@override@JsonKey(name: 'weight_increment') final  double? weightIncrement;

/// Create a copy of PlanExerciseSet
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlanExerciseSetCopyWith<_PlanExerciseSet> get copyWith => __$PlanExerciseSetCopyWithImpl<_PlanExerciseSet>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlanExerciseSetToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlanExerciseSet&&(identical(other.id, id) || other.id == id)&&(identical(other.planExerciseId, planExerciseId) || other.planExerciseId == planExerciseId)&&(identical(other.setNumber, setNumber) || other.setNumber == setNumber)&&(identical(other.targetReps, targetReps) || other.targetReps == targetReps)&&(identical(other.targetRepsMax, targetRepsMax) || other.targetRepsMax == targetRepsMax)&&(identical(other.targetWeight, targetWeight) || other.targetWeight == targetWeight)&&(identical(other.targetRpe, targetRpe) || other.targetRpe == targetRpe)&&(identical(other.targetRpeMax, targetRpeMax) || other.targetRpeMax == targetRpeMax)&&(identical(other.isWarmup, isWarmup) || other.isWarmup == isWarmup)&&(identical(other.weightIncrement, weightIncrement) || other.weightIncrement == weightIncrement));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,planExerciseId,setNumber,targetReps,targetRepsMax,targetWeight,targetRpe,targetRpeMax,isWarmup,weightIncrement);

@override
String toString() {
  return 'PlanExerciseSet(id: $id, planExerciseId: $planExerciseId, setNumber: $setNumber, targetReps: $targetReps, targetRepsMax: $targetRepsMax, targetWeight: $targetWeight, targetRpe: $targetRpe, targetRpeMax: $targetRpeMax, isWarmup: $isWarmup, weightIncrement: $weightIncrement)';
}


}

/// @nodoc
abstract mixin class _$PlanExerciseSetCopyWith<$Res> implements $PlanExerciseSetCopyWith<$Res> {
  factory _$PlanExerciseSetCopyWith(_PlanExerciseSet value, $Res Function(_PlanExerciseSet) _then) = __$PlanExerciseSetCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'plan_exercise_id') String planExerciseId,@JsonKey(name: 'set_number') int setNumber,@JsonKey(name: 'target_reps') int? targetReps,@JsonKey(name: 'target_reps_max') int? targetRepsMax,@JsonKey(name: 'target_weight') double? targetWeight,@JsonKey(name: 'target_rpe') double? targetRpe,@JsonKey(name: 'target_rpe_max') double? targetRpeMax,@JsonKey(name: 'is_warmup') bool isWarmup,@JsonKey(name: 'weight_increment') double? weightIncrement
});




}
/// @nodoc
class __$PlanExerciseSetCopyWithImpl<$Res>
    implements _$PlanExerciseSetCopyWith<$Res> {
  __$PlanExerciseSetCopyWithImpl(this._self, this._then);

  final _PlanExerciseSet _self;
  final $Res Function(_PlanExerciseSet) _then;

/// Create a copy of PlanExerciseSet
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? planExerciseId = null,Object? setNumber = null,Object? targetReps = freezed,Object? targetRepsMax = freezed,Object? targetWeight = freezed,Object? targetRpe = freezed,Object? targetRpeMax = freezed,Object? isWarmup = null,Object? weightIncrement = freezed,}) {
  return _then(_PlanExerciseSet(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,planExerciseId: null == planExerciseId ? _self.planExerciseId : planExerciseId // ignore: cast_nullable_to_non_nullable
as String,setNumber: null == setNumber ? _self.setNumber : setNumber // ignore: cast_nullable_to_non_nullable
as int,targetReps: freezed == targetReps ? _self.targetReps : targetReps // ignore: cast_nullable_to_non_nullable
as int?,targetRepsMax: freezed == targetRepsMax ? _self.targetRepsMax : targetRepsMax // ignore: cast_nullable_to_non_nullable
as int?,targetWeight: freezed == targetWeight ? _self.targetWeight : targetWeight // ignore: cast_nullable_to_non_nullable
as double?,targetRpe: freezed == targetRpe ? _self.targetRpe : targetRpe // ignore: cast_nullable_to_non_nullable
as double?,targetRpeMax: freezed == targetRpeMax ? _self.targetRpeMax : targetRpeMax // ignore: cast_nullable_to_non_nullable
as double?,isWarmup: null == isWarmup ? _self.isWarmup : isWarmup // ignore: cast_nullable_to_non_nullable
as bool,weightIncrement: freezed == weightIncrement ? _self.weightIncrement : weightIncrement // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

// dart format on
