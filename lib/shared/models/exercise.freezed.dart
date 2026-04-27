// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'exercise.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Exercise {

 String get id; String get name; String get category;@JsonKey(name: 'muscle_group') String get muscleGroup; List<String> get muscles;@JsonKey(name: 'is_custom') bool get isCustom;@JsonKey(name: 'created_by') String? get createdBy;@JsonKey(name: 'tracking_type') String get trackingType;
/// Create a copy of Exercise
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExerciseCopyWith<Exercise> get copyWith => _$ExerciseCopyWithImpl<Exercise>(this as Exercise, _$identity);

  /// Serializes this Exercise to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Exercise&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.category, category) || other.category == category)&&(identical(other.muscleGroup, muscleGroup) || other.muscleGroup == muscleGroup)&&const DeepCollectionEquality().equals(other.muscles, muscles)&&(identical(other.isCustom, isCustom) || other.isCustom == isCustom)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.trackingType, trackingType) || other.trackingType == trackingType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,category,muscleGroup,const DeepCollectionEquality().hash(muscles),isCustom,createdBy,trackingType);

@override
String toString() {
  return 'Exercise(id: $id, name: $name, category: $category, muscleGroup: $muscleGroup, muscles: $muscles, isCustom: $isCustom, createdBy: $createdBy, trackingType: $trackingType)';
}


}

/// @nodoc
abstract mixin class $ExerciseCopyWith<$Res>  {
  factory $ExerciseCopyWith(Exercise value, $Res Function(Exercise) _then) = _$ExerciseCopyWithImpl;
@useResult
$Res call({
 String id, String name, String category,@JsonKey(name: 'muscle_group') String muscleGroup, List<String> muscles,@JsonKey(name: 'is_custom') bool isCustom,@JsonKey(name: 'created_by') String? createdBy,@JsonKey(name: 'tracking_type') String trackingType
});




}
/// @nodoc
class _$ExerciseCopyWithImpl<$Res>
    implements $ExerciseCopyWith<$Res> {
  _$ExerciseCopyWithImpl(this._self, this._then);

  final Exercise _self;
  final $Res Function(Exercise) _then;

/// Create a copy of Exercise
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? category = null,Object? muscleGroup = null,Object? muscles = null,Object? isCustom = null,Object? createdBy = freezed,Object? trackingType = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,muscleGroup: null == muscleGroup ? _self.muscleGroup : muscleGroup // ignore: cast_nullable_to_non_nullable
as String,muscles: null == muscles ? _self.muscles : muscles // ignore: cast_nullable_to_non_nullable
as List<String>,isCustom: null == isCustom ? _self.isCustom : isCustom // ignore: cast_nullable_to_non_nullable
as bool,createdBy: freezed == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String?,trackingType: null == trackingType ? _self.trackingType : trackingType // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Exercise].
extension ExercisePatterns on Exercise {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Exercise value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Exercise() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Exercise value)  $default,){
final _that = this;
switch (_that) {
case _Exercise():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Exercise value)?  $default,){
final _that = this;
switch (_that) {
case _Exercise() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String category, @JsonKey(name: 'muscle_group')  String muscleGroup,  List<String> muscles, @JsonKey(name: 'is_custom')  bool isCustom, @JsonKey(name: 'created_by')  String? createdBy, @JsonKey(name: 'tracking_type')  String trackingType)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Exercise() when $default != null:
return $default(_that.id,_that.name,_that.category,_that.muscleGroup,_that.muscles,_that.isCustom,_that.createdBy,_that.trackingType);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String category, @JsonKey(name: 'muscle_group')  String muscleGroup,  List<String> muscles, @JsonKey(name: 'is_custom')  bool isCustom, @JsonKey(name: 'created_by')  String? createdBy, @JsonKey(name: 'tracking_type')  String trackingType)  $default,) {final _that = this;
switch (_that) {
case _Exercise():
return $default(_that.id,_that.name,_that.category,_that.muscleGroup,_that.muscles,_that.isCustom,_that.createdBy,_that.trackingType);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String category, @JsonKey(name: 'muscle_group')  String muscleGroup,  List<String> muscles, @JsonKey(name: 'is_custom')  bool isCustom, @JsonKey(name: 'created_by')  String? createdBy, @JsonKey(name: 'tracking_type')  String trackingType)?  $default,) {final _that = this;
switch (_that) {
case _Exercise() when $default != null:
return $default(_that.id,_that.name,_that.category,_that.muscleGroup,_that.muscles,_that.isCustom,_that.createdBy,_that.trackingType);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Exercise implements Exercise {
  const _Exercise({required this.id, required this.name, required this.category, @JsonKey(name: 'muscle_group') required this.muscleGroup, final  List<String> muscles = const [], @JsonKey(name: 'is_custom') required this.isCustom, @JsonKey(name: 'created_by') this.createdBy, @JsonKey(name: 'tracking_type') this.trackingType = 'weight_reps'}): _muscles = muscles;
  factory _Exercise.fromJson(Map<String, dynamic> json) => _$ExerciseFromJson(json);

@override final  String id;
@override final  String name;
@override final  String category;
@override@JsonKey(name: 'muscle_group') final  String muscleGroup;
 final  List<String> _muscles;
@override@JsonKey() List<String> get muscles {
  if (_muscles is EqualUnmodifiableListView) return _muscles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_muscles);
}

@override@JsonKey(name: 'is_custom') final  bool isCustom;
@override@JsonKey(name: 'created_by') final  String? createdBy;
@override@JsonKey(name: 'tracking_type') final  String trackingType;

/// Create a copy of Exercise
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExerciseCopyWith<_Exercise> get copyWith => __$ExerciseCopyWithImpl<_Exercise>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ExerciseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Exercise&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.category, category) || other.category == category)&&(identical(other.muscleGroup, muscleGroup) || other.muscleGroup == muscleGroup)&&const DeepCollectionEquality().equals(other._muscles, _muscles)&&(identical(other.isCustom, isCustom) || other.isCustom == isCustom)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.trackingType, trackingType) || other.trackingType == trackingType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,category,muscleGroup,const DeepCollectionEquality().hash(_muscles),isCustom,createdBy,trackingType);

@override
String toString() {
  return 'Exercise(id: $id, name: $name, category: $category, muscleGroup: $muscleGroup, muscles: $muscles, isCustom: $isCustom, createdBy: $createdBy, trackingType: $trackingType)';
}


}

/// @nodoc
abstract mixin class _$ExerciseCopyWith<$Res> implements $ExerciseCopyWith<$Res> {
  factory _$ExerciseCopyWith(_Exercise value, $Res Function(_Exercise) _then) = __$ExerciseCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String category,@JsonKey(name: 'muscle_group') String muscleGroup, List<String> muscles,@JsonKey(name: 'is_custom') bool isCustom,@JsonKey(name: 'created_by') String? createdBy,@JsonKey(name: 'tracking_type') String trackingType
});




}
/// @nodoc
class __$ExerciseCopyWithImpl<$Res>
    implements _$ExerciseCopyWith<$Res> {
  __$ExerciseCopyWithImpl(this._self, this._then);

  final _Exercise _self;
  final $Res Function(_Exercise) _then;

/// Create a copy of Exercise
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? category = null,Object? muscleGroup = null,Object? muscles = null,Object? isCustom = null,Object? createdBy = freezed,Object? trackingType = null,}) {
  return _then(_Exercise(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,muscleGroup: null == muscleGroup ? _self.muscleGroup : muscleGroup // ignore: cast_nullable_to_non_nullable
as String,muscles: null == muscles ? _self._muscles : muscles // ignore: cast_nullable_to_non_nullable
as List<String>,isCustom: null == isCustom ? _self.isCustom : isCustom // ignore: cast_nullable_to_non_nullable
as bool,createdBy: freezed == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String?,trackingType: null == trackingType ? _self.trackingType : trackingType // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
