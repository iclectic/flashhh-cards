// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'insight_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StudyNextAction {

 StudyNextKind get kind; String get title; String get subtitle; String? get tag; String? get deckId; int get count;
/// Create a copy of StudyNextAction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StudyNextActionCopyWith<StudyNextAction> get copyWith => _$StudyNextActionCopyWithImpl<StudyNextAction>(this as StudyNextAction, _$identity);

  /// Serializes this StudyNextAction to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as StudyNextAction;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StudyNextAction&&(identical(other.kind, _this.kind) || other.kind == _this.kind)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.subtitle, _this.subtitle) || other.subtitle == _this.subtitle)&&(identical(other.tag, _this.tag) || other.tag == _this.tag)&&(identical(other.deckId, _this.deckId) || other.deckId == _this.deckId)&&(identical(other.count, _this.count) || other.count == _this.count));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as StudyNextAction;
  return Object.hash(runtimeType,_this.kind,_this.title,_this.subtitle,_this.tag,_this.deckId,_this.count);
}

@override
String toString() {
  final _this = this as StudyNextAction;
  return 'StudyNextAction(kind: ${_this.kind}, title: ${_this.title}, subtitle: ${_this.subtitle}, tag: ${_this.tag}, deckId: ${_this.deckId}, count: ${_this.count})';
}


}

/// @nodoc
abstract mixin class $StudyNextActionCopyWith<$Res>  {
  factory $StudyNextActionCopyWith(StudyNextAction value, $Res Function(StudyNextAction) _then) = _$StudyNextActionCopyWithImpl;
@useResult
$Res call({
 StudyNextKind kind, String title, String subtitle, String? tag, String? deckId, int count
});




}
/// @nodoc
class _$StudyNextActionCopyWithImpl<$Res>
    implements $StudyNextActionCopyWith<$Res> {
  _$StudyNextActionCopyWithImpl(this._self, this._then);

  final StudyNextAction _self;
  final $Res Function(StudyNextAction) _then;

/// Create a copy of StudyNextAction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? kind = null,Object? title = null,Object? subtitle = null,Object? tag = freezed,Object? deckId = freezed,Object? count = null,}) {
  return _then(StudyNextAction(
kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as StudyNextKind,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,subtitle: null == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String,tag: freezed == tag ? _self.tag : tag // ignore: cast_nullable_to_non_nullable
as String?,deckId: freezed == deckId ? _self.deckId : deckId // ignore: cast_nullable_to_non_nullable
as String?,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [StudyNextAction].
extension StudyNextActionPatterns on StudyNextAction {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StudyNextAction value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StudyNextAction() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StudyNextAction value)  $default,){
final _that = this;
switch (_that) {
case _StudyNextAction():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StudyNextAction value)?  $default,){
final _that = this;
switch (_that) {
case _StudyNextAction() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( StudyNextKind kind,  String title,  String subtitle,  String? tag,  String? deckId,  int count)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StudyNextAction() when $default != null:
return $default(_that.kind,_that.title,_that.subtitle,_that.tag,_that.deckId,_that.count);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( StudyNextKind kind,  String title,  String subtitle,  String? tag,  String? deckId,  int count)  $default,) {final _that = this;
switch (_that) {
case _StudyNextAction():
return $default(_that.kind,_that.title,_that.subtitle,_that.tag,_that.deckId,_that.count);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( StudyNextKind kind,  String title,  String subtitle,  String? tag,  String? deckId,  int count)?  $default,) {final _that = this;
switch (_that) {
case _StudyNextAction() when $default != null:
return $default(_that.kind,_that.title,_that.subtitle,_that.tag,_that.deckId,_that.count);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StudyNextAction implements StudyNextAction {
  const _StudyNextAction({required this.kind, required this.title, required this.subtitle, this.tag, this.deckId, this.count = 0});
  factory _StudyNextAction.fromJson(Map<String, dynamic> json) => _$StudyNextActionFromJson(json);

@override final  StudyNextKind kind;
@override final  String title;
@override final  String subtitle;
@override final  String? tag;
@override final  String? deckId;
@override@JsonKey() final  int count;

/// Create a copy of StudyNextAction
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StudyNextActionCopyWith<_StudyNextAction> get copyWith => __$StudyNextActionCopyWithImpl<_StudyNextAction>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StudyNextActionToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _StudyNextAction&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.title, title) || other.title == title)&&(identical(other.subtitle, subtitle) || other.subtitle == subtitle)&&(identical(other.tag, tag) || other.tag == tag)&&(identical(other.deckId, deckId) || other.deckId == deckId)&&(identical(other.count, count) || other.count == count));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,kind,title,subtitle,tag,deckId,count);
}

@override
String toString() {
    return 'StudyNextAction(kind: $kind, title: $title, subtitle: $subtitle, tag: $tag, deckId: $deckId, count: $count)';
}


}

/// @nodoc
abstract mixin class _$StudyNextActionCopyWith<$Res> implements $StudyNextActionCopyWith<$Res> {
  factory _$StudyNextActionCopyWith(_StudyNextAction value, $Res Function(_StudyNextAction) _then) = __$StudyNextActionCopyWithImpl;
@override @useResult
$Res call({
 StudyNextKind kind, String title, String subtitle, String? tag, String? deckId, int count
});




}
/// @nodoc
class __$StudyNextActionCopyWithImpl<$Res>
    implements _$StudyNextActionCopyWith<$Res> {
  __$StudyNextActionCopyWithImpl(this._self, this._then);

  final _StudyNextAction _self;
  final $Res Function(_StudyNextAction) _then;

/// Create a copy of StudyNextAction
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? kind = null,Object? title = null,Object? subtitle = null,Object? tag = freezed,Object? deckId = freezed,Object? count = null,}) {
  return _then(_StudyNextAction(
kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as StudyNextKind,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,subtitle: null == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String,tag: freezed == tag ? _self.tag : tag // ignore: cast_nullable_to_non_nullable
as String?,deckId: freezed == deckId ? _self.deckId : deckId // ignore: cast_nullable_to_non_nullable
as String?,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$WeakTagInsight {

 String get tag; int get attempts; int get misses; double get accuracy;
/// Create a copy of WeakTagInsight
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WeakTagInsightCopyWith<WeakTagInsight> get copyWith => _$WeakTagInsightCopyWithImpl<WeakTagInsight>(this as WeakTagInsight, _$identity);

  /// Serializes this WeakTagInsight to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as WeakTagInsight;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WeakTagInsight&&(identical(other.tag, _this.tag) || other.tag == _this.tag)&&(identical(other.attempts, _this.attempts) || other.attempts == _this.attempts)&&(identical(other.misses, _this.misses) || other.misses == _this.misses)&&(identical(other.accuracy, _this.accuracy) || other.accuracy == _this.accuracy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as WeakTagInsight;
  return Object.hash(runtimeType,_this.tag,_this.attempts,_this.misses,_this.accuracy);
}

@override
String toString() {
  final _this = this as WeakTagInsight;
  return 'WeakTagInsight(tag: ${_this.tag}, attempts: ${_this.attempts}, misses: ${_this.misses}, accuracy: ${_this.accuracy})';
}


}

/// @nodoc
abstract mixin class $WeakTagInsightCopyWith<$Res>  {
  factory $WeakTagInsightCopyWith(WeakTagInsight value, $Res Function(WeakTagInsight) _then) = _$WeakTagInsightCopyWithImpl;
@useResult
$Res call({
 String tag, int attempts, int misses, double accuracy
});




}
/// @nodoc
class _$WeakTagInsightCopyWithImpl<$Res>
    implements $WeakTagInsightCopyWith<$Res> {
  _$WeakTagInsightCopyWithImpl(this._self, this._then);

  final WeakTagInsight _self;
  final $Res Function(WeakTagInsight) _then;

/// Create a copy of WeakTagInsight
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tag = null,Object? attempts = null,Object? misses = null,Object? accuracy = null,}) {
  return _then(WeakTagInsight(
tag: null == tag ? _self.tag : tag // ignore: cast_nullable_to_non_nullable
as String,attempts: null == attempts ? _self.attempts : attempts // ignore: cast_nullable_to_non_nullable
as int,misses: null == misses ? _self.misses : misses // ignore: cast_nullable_to_non_nullable
as int,accuracy: null == accuracy ? _self.accuracy : accuracy // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [WeakTagInsight].
extension WeakTagInsightPatterns on WeakTagInsight {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WeakTagInsight value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WeakTagInsight() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WeakTagInsight value)  $default,){
final _that = this;
switch (_that) {
case _WeakTagInsight():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WeakTagInsight value)?  $default,){
final _that = this;
switch (_that) {
case _WeakTagInsight() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String tag,  int attempts,  int misses,  double accuracy)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WeakTagInsight() when $default != null:
return $default(_that.tag,_that.attempts,_that.misses,_that.accuracy);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String tag,  int attempts,  int misses,  double accuracy)  $default,) {final _that = this;
switch (_that) {
case _WeakTagInsight():
return $default(_that.tag,_that.attempts,_that.misses,_that.accuracy);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String tag,  int attempts,  int misses,  double accuracy)?  $default,) {final _that = this;
switch (_that) {
case _WeakTagInsight() when $default != null:
return $default(_that.tag,_that.attempts,_that.misses,_that.accuracy);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WeakTagInsight implements WeakTagInsight {
  const _WeakTagInsight({required this.tag, required this.attempts, required this.misses, required this.accuracy});
  factory _WeakTagInsight.fromJson(Map<String, dynamic> json) => _$WeakTagInsightFromJson(json);

@override final  String tag;
@override final  int attempts;
@override final  int misses;
@override final  double accuracy;

/// Create a copy of WeakTagInsight
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WeakTagInsightCopyWith<_WeakTagInsight> get copyWith => __$WeakTagInsightCopyWithImpl<_WeakTagInsight>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WeakTagInsightToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _WeakTagInsight&&(identical(other.tag, tag) || other.tag == tag)&&(identical(other.attempts, attempts) || other.attempts == attempts)&&(identical(other.misses, misses) || other.misses == misses)&&(identical(other.accuracy, accuracy) || other.accuracy == accuracy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,tag,attempts,misses,accuracy);
}

@override
String toString() {
    return 'WeakTagInsight(tag: $tag, attempts: $attempts, misses: $misses, accuracy: $accuracy)';
}


}

/// @nodoc
abstract mixin class _$WeakTagInsightCopyWith<$Res> implements $WeakTagInsightCopyWith<$Res> {
  factory _$WeakTagInsightCopyWith(_WeakTagInsight value, $Res Function(_WeakTagInsight) _then) = __$WeakTagInsightCopyWithImpl;
@override @useResult
$Res call({
 String tag, int attempts, int misses, double accuracy
});




}
/// @nodoc
class __$WeakTagInsightCopyWithImpl<$Res>
    implements _$WeakTagInsightCopyWith<$Res> {
  __$WeakTagInsightCopyWithImpl(this._self, this._then);

  final _WeakTagInsight _self;
  final $Res Function(_WeakTagInsight) _then;

/// Create a copy of WeakTagInsight
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tag = null,Object? attempts = null,Object? misses = null,Object? accuracy = null,}) {
  return _then(_WeakTagInsight(
tag: null == tag ? _self.tag : tag // ignore: cast_nullable_to_non_nullable
as String,attempts: null == attempts ? _self.attempts : attempts // ignore: cast_nullable_to_non_nullable
as int,misses: null == misses ? _self.misses : misses // ignore: cast_nullable_to_non_nullable
as int,accuracy: null == accuracy ? _self.accuracy : accuracy // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$WeakCardInsight {

 String get cardId; String get deckId; String get deckName; String get prompt; int get misses; int get attempts;
/// Create a copy of WeakCardInsight
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WeakCardInsightCopyWith<WeakCardInsight> get copyWith => _$WeakCardInsightCopyWithImpl<WeakCardInsight>(this as WeakCardInsight, _$identity);

  /// Serializes this WeakCardInsight to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as WeakCardInsight;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WeakCardInsight&&(identical(other.cardId, _this.cardId) || other.cardId == _this.cardId)&&(identical(other.deckId, _this.deckId) || other.deckId == _this.deckId)&&(identical(other.deckName, _this.deckName) || other.deckName == _this.deckName)&&(identical(other.prompt, _this.prompt) || other.prompt == _this.prompt)&&(identical(other.misses, _this.misses) || other.misses == _this.misses)&&(identical(other.attempts, _this.attempts) || other.attempts == _this.attempts));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as WeakCardInsight;
  return Object.hash(runtimeType,_this.cardId,_this.deckId,_this.deckName,_this.prompt,_this.misses,_this.attempts);
}

@override
String toString() {
  final _this = this as WeakCardInsight;
  return 'WeakCardInsight(cardId: ${_this.cardId}, deckId: ${_this.deckId}, deckName: ${_this.deckName}, prompt: ${_this.prompt}, misses: ${_this.misses}, attempts: ${_this.attempts})';
}


}

/// @nodoc
abstract mixin class $WeakCardInsightCopyWith<$Res>  {
  factory $WeakCardInsightCopyWith(WeakCardInsight value, $Res Function(WeakCardInsight) _then) = _$WeakCardInsightCopyWithImpl;
@useResult
$Res call({
 String cardId, String deckId, String deckName, String prompt, int misses, int attempts
});




}
/// @nodoc
class _$WeakCardInsightCopyWithImpl<$Res>
    implements $WeakCardInsightCopyWith<$Res> {
  _$WeakCardInsightCopyWithImpl(this._self, this._then);

  final WeakCardInsight _self;
  final $Res Function(WeakCardInsight) _then;

/// Create a copy of WeakCardInsight
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? cardId = null,Object? deckId = null,Object? deckName = null,Object? prompt = null,Object? misses = null,Object? attempts = null,}) {
  return _then(WeakCardInsight(
cardId: null == cardId ? _self.cardId : cardId // ignore: cast_nullable_to_non_nullable
as String,deckId: null == deckId ? _self.deckId : deckId // ignore: cast_nullable_to_non_nullable
as String,deckName: null == deckName ? _self.deckName : deckName // ignore: cast_nullable_to_non_nullable
as String,prompt: null == prompt ? _self.prompt : prompt // ignore: cast_nullable_to_non_nullable
as String,misses: null == misses ? _self.misses : misses // ignore: cast_nullable_to_non_nullable
as int,attempts: null == attempts ? _self.attempts : attempts // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [WeakCardInsight].
extension WeakCardInsightPatterns on WeakCardInsight {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WeakCardInsight value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WeakCardInsight() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WeakCardInsight value)  $default,){
final _that = this;
switch (_that) {
case _WeakCardInsight():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WeakCardInsight value)?  $default,){
final _that = this;
switch (_that) {
case _WeakCardInsight() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String cardId,  String deckId,  String deckName,  String prompt,  int misses,  int attempts)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WeakCardInsight() when $default != null:
return $default(_that.cardId,_that.deckId,_that.deckName,_that.prompt,_that.misses,_that.attempts);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String cardId,  String deckId,  String deckName,  String prompt,  int misses,  int attempts)  $default,) {final _that = this;
switch (_that) {
case _WeakCardInsight():
return $default(_that.cardId,_that.deckId,_that.deckName,_that.prompt,_that.misses,_that.attempts);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String cardId,  String deckId,  String deckName,  String prompt,  int misses,  int attempts)?  $default,) {final _that = this;
switch (_that) {
case _WeakCardInsight() when $default != null:
return $default(_that.cardId,_that.deckId,_that.deckName,_that.prompt,_that.misses,_that.attempts);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WeakCardInsight implements WeakCardInsight {
  const _WeakCardInsight({required this.cardId, required this.deckId, required this.deckName, required this.prompt, required this.misses, required this.attempts});
  factory _WeakCardInsight.fromJson(Map<String, dynamic> json) => _$WeakCardInsightFromJson(json);

@override final  String cardId;
@override final  String deckId;
@override final  String deckName;
@override final  String prompt;
@override final  int misses;
@override final  int attempts;

/// Create a copy of WeakCardInsight
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WeakCardInsightCopyWith<_WeakCardInsight> get copyWith => __$WeakCardInsightCopyWithImpl<_WeakCardInsight>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WeakCardInsightToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _WeakCardInsight&&(identical(other.cardId, cardId) || other.cardId == cardId)&&(identical(other.deckId, deckId) || other.deckId == deckId)&&(identical(other.deckName, deckName) || other.deckName == deckName)&&(identical(other.prompt, prompt) || other.prompt == prompt)&&(identical(other.misses, misses) || other.misses == misses)&&(identical(other.attempts, attempts) || other.attempts == attempts));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,cardId,deckId,deckName,prompt,misses,attempts);
}

@override
String toString() {
    return 'WeakCardInsight(cardId: $cardId, deckId: $deckId, deckName: $deckName, prompt: $prompt, misses: $misses, attempts: $attempts)';
}


}

/// @nodoc
abstract mixin class _$WeakCardInsightCopyWith<$Res> implements $WeakCardInsightCopyWith<$Res> {
  factory _$WeakCardInsightCopyWith(_WeakCardInsight value, $Res Function(_WeakCardInsight) _then) = __$WeakCardInsightCopyWithImpl;
@override @useResult
$Res call({
 String cardId, String deckId, String deckName, String prompt, int misses, int attempts
});




}
/// @nodoc
class __$WeakCardInsightCopyWithImpl<$Res>
    implements _$WeakCardInsightCopyWith<$Res> {
  __$WeakCardInsightCopyWithImpl(this._self, this._then);

  final _WeakCardInsight _self;
  final $Res Function(_WeakCardInsight) _then;

/// Create a copy of WeakCardInsight
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? cardId = null,Object? deckId = null,Object? deckName = null,Object? prompt = null,Object? misses = null,Object? attempts = null,}) {
  return _then(_WeakCardInsight(
cardId: null == cardId ? _self.cardId : cardId // ignore: cast_nullable_to_non_nullable
as String,deckId: null == deckId ? _self.deckId : deckId // ignore: cast_nullable_to_non_nullable
as String,deckName: null == deckName ? _self.deckName : deckName // ignore: cast_nullable_to_non_nullable
as String,prompt: null == prompt ? _self.prompt : prompt // ignore: cast_nullable_to_non_nullable
as String,misses: null == misses ? _self.misses : misses // ignore: cast_nullable_to_non_nullable
as int,attempts: null == attempts ? _self.attempts : attempts // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$StudyDayActivity {

/// Local calendar day at midnight.
 DateTime get day; int get reviewCount; int get quizAnswerCount;
/// Create a copy of StudyDayActivity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StudyDayActivityCopyWith<StudyDayActivity> get copyWith => _$StudyDayActivityCopyWithImpl<StudyDayActivity>(this as StudyDayActivity, _$identity);

  /// Serializes this StudyDayActivity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as StudyDayActivity;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StudyDayActivity&&(identical(other.day, _this.day) || other.day == _this.day)&&(identical(other.reviewCount, _this.reviewCount) || other.reviewCount == _this.reviewCount)&&(identical(other.quizAnswerCount, _this.quizAnswerCount) || other.quizAnswerCount == _this.quizAnswerCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as StudyDayActivity;
  return Object.hash(runtimeType,_this.day,_this.reviewCount,_this.quizAnswerCount);
}

@override
String toString() {
  final _this = this as StudyDayActivity;
  return 'StudyDayActivity(day: ${_this.day}, reviewCount: ${_this.reviewCount}, quizAnswerCount: ${_this.quizAnswerCount})';
}


}

/// @nodoc
abstract mixin class $StudyDayActivityCopyWith<$Res>  {
  factory $StudyDayActivityCopyWith(StudyDayActivity value, $Res Function(StudyDayActivity) _then) = _$StudyDayActivityCopyWithImpl;
@useResult
$Res call({
 DateTime day, int reviewCount, int quizAnswerCount
});




}
/// @nodoc
class _$StudyDayActivityCopyWithImpl<$Res>
    implements $StudyDayActivityCopyWith<$Res> {
  _$StudyDayActivityCopyWithImpl(this._self, this._then);

  final StudyDayActivity _self;
  final $Res Function(StudyDayActivity) _then;

/// Create a copy of StudyDayActivity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? day = null,Object? reviewCount = null,Object? quizAnswerCount = null,}) {
  return _then(StudyDayActivity(
day: null == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as DateTime,reviewCount: null == reviewCount ? _self.reviewCount : reviewCount // ignore: cast_nullable_to_non_nullable
as int,quizAnswerCount: null == quizAnswerCount ? _self.quizAnswerCount : quizAnswerCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [StudyDayActivity].
extension StudyDayActivityPatterns on StudyDayActivity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StudyDayActivity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StudyDayActivity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StudyDayActivity value)  $default,){
final _that = this;
switch (_that) {
case _StudyDayActivity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StudyDayActivity value)?  $default,){
final _that = this;
switch (_that) {
case _StudyDayActivity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime day,  int reviewCount,  int quizAnswerCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StudyDayActivity() when $default != null:
return $default(_that.day,_that.reviewCount,_that.quizAnswerCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime day,  int reviewCount,  int quizAnswerCount)  $default,) {final _that = this;
switch (_that) {
case _StudyDayActivity():
return $default(_that.day,_that.reviewCount,_that.quizAnswerCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime day,  int reviewCount,  int quizAnswerCount)?  $default,) {final _that = this;
switch (_that) {
case _StudyDayActivity() when $default != null:
return $default(_that.day,_that.reviewCount,_that.quizAnswerCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StudyDayActivity implements StudyDayActivity {
  const _StudyDayActivity({required this.day, required this.reviewCount, required this.quizAnswerCount});
  factory _StudyDayActivity.fromJson(Map<String, dynamic> json) => _$StudyDayActivityFromJson(json);

/// Local calendar day at midnight.
@override final  DateTime day;
@override final  int reviewCount;
@override final  int quizAnswerCount;

/// Create a copy of StudyDayActivity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StudyDayActivityCopyWith<_StudyDayActivity> get copyWith => __$StudyDayActivityCopyWithImpl<_StudyDayActivity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StudyDayActivityToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _StudyDayActivity&&(identical(other.day, day) || other.day == day)&&(identical(other.reviewCount, reviewCount) || other.reviewCount == reviewCount)&&(identical(other.quizAnswerCount, quizAnswerCount) || other.quizAnswerCount == quizAnswerCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,day,reviewCount,quizAnswerCount);
}

@override
String toString() {
    return 'StudyDayActivity(day: $day, reviewCount: $reviewCount, quizAnswerCount: $quizAnswerCount)';
}


}

/// @nodoc
abstract mixin class _$StudyDayActivityCopyWith<$Res> implements $StudyDayActivityCopyWith<$Res> {
  factory _$StudyDayActivityCopyWith(_StudyDayActivity value, $Res Function(_StudyDayActivity) _then) = __$StudyDayActivityCopyWithImpl;
@override @useResult
$Res call({
 DateTime day, int reviewCount, int quizAnswerCount
});




}
/// @nodoc
class __$StudyDayActivityCopyWithImpl<$Res>
    implements _$StudyDayActivityCopyWith<$Res> {
  __$StudyDayActivityCopyWithImpl(this._self, this._then);

  final _StudyDayActivity _self;
  final $Res Function(_StudyDayActivity) _then;

/// Create a copy of StudyDayActivity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? day = null,Object? reviewCount = null,Object? quizAnswerCount = null,}) {
  return _then(_StudyDayActivity(
day: null == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as DateTime,reviewCount: null == reviewCount ? _self.reviewCount : reviewCount // ignore: cast_nullable_to_non_nullable
as int,quizAnswerCount: null == quizAnswerCount ? _self.quizAnswerCount : quizAnswerCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$RetentionPoint {

 DateTime get day; int get attempts; int get successes; double get accuracy;
/// Create a copy of RetentionPoint
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RetentionPointCopyWith<RetentionPoint> get copyWith => _$RetentionPointCopyWithImpl<RetentionPoint>(this as RetentionPoint, _$identity);

  /// Serializes this RetentionPoint to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as RetentionPoint;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RetentionPoint&&(identical(other.day, _this.day) || other.day == _this.day)&&(identical(other.attempts, _this.attempts) || other.attempts == _this.attempts)&&(identical(other.successes, _this.successes) || other.successes == _this.successes)&&(identical(other.accuracy, _this.accuracy) || other.accuracy == _this.accuracy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as RetentionPoint;
  return Object.hash(runtimeType,_this.day,_this.attempts,_this.successes,_this.accuracy);
}

@override
String toString() {
  final _this = this as RetentionPoint;
  return 'RetentionPoint(day: ${_this.day}, attempts: ${_this.attempts}, successes: ${_this.successes}, accuracy: ${_this.accuracy})';
}


}

/// @nodoc
abstract mixin class $RetentionPointCopyWith<$Res>  {
  factory $RetentionPointCopyWith(RetentionPoint value, $Res Function(RetentionPoint) _then) = _$RetentionPointCopyWithImpl;
@useResult
$Res call({
 DateTime day, int attempts, int successes, double accuracy
});




}
/// @nodoc
class _$RetentionPointCopyWithImpl<$Res>
    implements $RetentionPointCopyWith<$Res> {
  _$RetentionPointCopyWithImpl(this._self, this._then);

  final RetentionPoint _self;
  final $Res Function(RetentionPoint) _then;

/// Create a copy of RetentionPoint
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? day = null,Object? attempts = null,Object? successes = null,Object? accuracy = null,}) {
  return _then(RetentionPoint(
day: null == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as DateTime,attempts: null == attempts ? _self.attempts : attempts // ignore: cast_nullable_to_non_nullable
as int,successes: null == successes ? _self.successes : successes // ignore: cast_nullable_to_non_nullable
as int,accuracy: null == accuracy ? _self.accuracy : accuracy // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [RetentionPoint].
extension RetentionPointPatterns on RetentionPoint {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RetentionPoint value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RetentionPoint() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RetentionPoint value)  $default,){
final _that = this;
switch (_that) {
case _RetentionPoint():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RetentionPoint value)?  $default,){
final _that = this;
switch (_that) {
case _RetentionPoint() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime day,  int attempts,  int successes,  double accuracy)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RetentionPoint() when $default != null:
return $default(_that.day,_that.attempts,_that.successes,_that.accuracy);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime day,  int attempts,  int successes,  double accuracy)  $default,) {final _that = this;
switch (_that) {
case _RetentionPoint():
return $default(_that.day,_that.attempts,_that.successes,_that.accuracy);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime day,  int attempts,  int successes,  double accuracy)?  $default,) {final _that = this;
switch (_that) {
case _RetentionPoint() when $default != null:
return $default(_that.day,_that.attempts,_that.successes,_that.accuracy);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RetentionPoint implements RetentionPoint {
  const _RetentionPoint({required this.day, required this.attempts, required this.successes, required this.accuracy});
  factory _RetentionPoint.fromJson(Map<String, dynamic> json) => _$RetentionPointFromJson(json);

@override final  DateTime day;
@override final  int attempts;
@override final  int successes;
@override final  double accuracy;

/// Create a copy of RetentionPoint
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RetentionPointCopyWith<_RetentionPoint> get copyWith => __$RetentionPointCopyWithImpl<_RetentionPoint>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RetentionPointToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RetentionPoint&&(identical(other.day, day) || other.day == day)&&(identical(other.attempts, attempts) || other.attempts == attempts)&&(identical(other.successes, successes) || other.successes == successes)&&(identical(other.accuracy, accuracy) || other.accuracy == accuracy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,day,attempts,successes,accuracy);
}

@override
String toString() {
    return 'RetentionPoint(day: $day, attempts: $attempts, successes: $successes, accuracy: $accuracy)';
}


}

/// @nodoc
abstract mixin class _$RetentionPointCopyWith<$Res> implements $RetentionPointCopyWith<$Res> {
  factory _$RetentionPointCopyWith(_RetentionPoint value, $Res Function(_RetentionPoint) _then) = __$RetentionPointCopyWithImpl;
@override @useResult
$Res call({
 DateTime day, int attempts, int successes, double accuracy
});




}
/// @nodoc
class __$RetentionPointCopyWithImpl<$Res>
    implements _$RetentionPointCopyWith<$Res> {
  __$RetentionPointCopyWithImpl(this._self, this._then);

  final _RetentionPoint _self;
  final $Res Function(_RetentionPoint) _then;

/// Create a copy of RetentionPoint
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? day = null,Object? attempts = null,Object? successes = null,Object? accuracy = null,}) {
  return _then(_RetentionPoint(
day: null == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as DateTime,attempts: null == attempts ? _self.attempts : attempts // ignore: cast_nullable_to_non_nullable
as int,successes: null == successes ? _self.successes : successes // ignore: cast_nullable_to_non_nullable
as int,accuracy: null == accuracy ? _self.accuracy : accuracy // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$InsightsSnapshot {

 List<StudyNextAction> get nextActions; List<WeakTagInsight> get weakTags; List<WeakCardInsight> get weakCards; List<StudyDayActivity> get calendar; List<RetentionPoint> get retention; int get cardsDue; int get streak;
/// Create a copy of InsightsSnapshot
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InsightsSnapshotCopyWith<InsightsSnapshot> get copyWith => _$InsightsSnapshotCopyWithImpl<InsightsSnapshot>(this as InsightsSnapshot, _$identity);

  /// Serializes this InsightsSnapshot to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as InsightsSnapshot;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InsightsSnapshot&&const DeepCollectionEquality().equals(other.nextActions, _this.nextActions)&&const DeepCollectionEquality().equals(other.weakTags, _this.weakTags)&&const DeepCollectionEquality().equals(other.weakCards, _this.weakCards)&&const DeepCollectionEquality().equals(other.calendar, _this.calendar)&&const DeepCollectionEquality().equals(other.retention, _this.retention)&&(identical(other.cardsDue, _this.cardsDue) || other.cardsDue == _this.cardsDue)&&(identical(other.streak, _this.streak) || other.streak == _this.streak));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as InsightsSnapshot;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.nextActions),const DeepCollectionEquality().hash(_this.weakTags),const DeepCollectionEquality().hash(_this.weakCards),const DeepCollectionEquality().hash(_this.calendar),const DeepCollectionEquality().hash(_this.retention),_this.cardsDue,_this.streak);
}

@override
String toString() {
  final _this = this as InsightsSnapshot;
  return 'InsightsSnapshot(nextActions: ${_this.nextActions}, weakTags: ${_this.weakTags}, weakCards: ${_this.weakCards}, calendar: ${_this.calendar}, retention: ${_this.retention}, cardsDue: ${_this.cardsDue}, streak: ${_this.streak})';
}


}

/// @nodoc
abstract mixin class $InsightsSnapshotCopyWith<$Res>  {
  factory $InsightsSnapshotCopyWith(InsightsSnapshot value, $Res Function(InsightsSnapshot) _then) = _$InsightsSnapshotCopyWithImpl;
@useResult
$Res call({
 List<StudyNextAction> nextActions, List<WeakTagInsight> weakTags, List<WeakCardInsight> weakCards, List<StudyDayActivity> calendar, List<RetentionPoint> retention, int cardsDue, int streak
});




}
/// @nodoc
class _$InsightsSnapshotCopyWithImpl<$Res>
    implements $InsightsSnapshotCopyWith<$Res> {
  _$InsightsSnapshotCopyWithImpl(this._self, this._then);

  final InsightsSnapshot _self;
  final $Res Function(InsightsSnapshot) _then;

/// Create a copy of InsightsSnapshot
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? nextActions = null,Object? weakTags = null,Object? weakCards = null,Object? calendar = null,Object? retention = null,Object? cardsDue = null,Object? streak = null,}) {
  return _then(InsightsSnapshot(
nextActions: null == nextActions ? _self.nextActions : nextActions // ignore: cast_nullable_to_non_nullable
as List<StudyNextAction>,weakTags: null == weakTags ? _self.weakTags : weakTags // ignore: cast_nullable_to_non_nullable
as List<WeakTagInsight>,weakCards: null == weakCards ? _self.weakCards : weakCards // ignore: cast_nullable_to_non_nullable
as List<WeakCardInsight>,calendar: null == calendar ? _self.calendar : calendar // ignore: cast_nullable_to_non_nullable
as List<StudyDayActivity>,retention: null == retention ? _self.retention : retention // ignore: cast_nullable_to_non_nullable
as List<RetentionPoint>,cardsDue: null == cardsDue ? _self.cardsDue : cardsDue // ignore: cast_nullable_to_non_nullable
as int,streak: null == streak ? _self.streak : streak // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [InsightsSnapshot].
extension InsightsSnapshotPatterns on InsightsSnapshot {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InsightsSnapshot value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InsightsSnapshot() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InsightsSnapshot value)  $default,){
final _that = this;
switch (_that) {
case _InsightsSnapshot():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InsightsSnapshot value)?  $default,){
final _that = this;
switch (_that) {
case _InsightsSnapshot() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<StudyNextAction> nextActions,  List<WeakTagInsight> weakTags,  List<WeakCardInsight> weakCards,  List<StudyDayActivity> calendar,  List<RetentionPoint> retention,  int cardsDue,  int streak)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InsightsSnapshot() when $default != null:
return $default(_that.nextActions,_that.weakTags,_that.weakCards,_that.calendar,_that.retention,_that.cardsDue,_that.streak);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<StudyNextAction> nextActions,  List<WeakTagInsight> weakTags,  List<WeakCardInsight> weakCards,  List<StudyDayActivity> calendar,  List<RetentionPoint> retention,  int cardsDue,  int streak)  $default,) {final _that = this;
switch (_that) {
case _InsightsSnapshot():
return $default(_that.nextActions,_that.weakTags,_that.weakCards,_that.calendar,_that.retention,_that.cardsDue,_that.streak);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<StudyNextAction> nextActions,  List<WeakTagInsight> weakTags,  List<WeakCardInsight> weakCards,  List<StudyDayActivity> calendar,  List<RetentionPoint> retention,  int cardsDue,  int streak)?  $default,) {final _that = this;
switch (_that) {
case _InsightsSnapshot() when $default != null:
return $default(_that.nextActions,_that.weakTags,_that.weakCards,_that.calendar,_that.retention,_that.cardsDue,_that.streak);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _InsightsSnapshot implements InsightsSnapshot {
  const _InsightsSnapshot({required  List<StudyNextAction> nextActions, required  List<WeakTagInsight> weakTags, required  List<WeakCardInsight> weakCards, required  List<StudyDayActivity> calendar, required  List<RetentionPoint> retention, required this.cardsDue, required this.streak}): _nextActions = nextActions,_weakTags = weakTags,_weakCards = weakCards,_calendar = calendar,_retention = retention;
  factory _InsightsSnapshot.fromJson(Map<String, dynamic> json) => _$InsightsSnapshotFromJson(json);

 final  List<StudyNextAction> _nextActions;
@override List<StudyNextAction> get nextActions {
  if (_nextActions is EqualUnmodifiableListView) return _nextActions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_nextActions);
}

 final  List<WeakTagInsight> _weakTags;
@override List<WeakTagInsight> get weakTags {
  if (_weakTags is EqualUnmodifiableListView) return _weakTags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_weakTags);
}

 final  List<WeakCardInsight> _weakCards;
@override List<WeakCardInsight> get weakCards {
  if (_weakCards is EqualUnmodifiableListView) return _weakCards;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_weakCards);
}

 final  List<StudyDayActivity> _calendar;
@override List<StudyDayActivity> get calendar {
  if (_calendar is EqualUnmodifiableListView) return _calendar;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_calendar);
}

 final  List<RetentionPoint> _retention;
@override List<RetentionPoint> get retention {
  if (_retention is EqualUnmodifiableListView) return _retention;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_retention);
}

@override final  int cardsDue;
@override final  int streak;

/// Create a copy of InsightsSnapshot
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InsightsSnapshotCopyWith<_InsightsSnapshot> get copyWith => __$InsightsSnapshotCopyWithImpl<_InsightsSnapshot>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InsightsSnapshotToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _InsightsSnapshot&&const DeepCollectionEquality().equals(other.nextActions, _nextActions)&&const DeepCollectionEquality().equals(other.weakTags, _weakTags)&&const DeepCollectionEquality().equals(other.weakCards, _weakCards)&&const DeepCollectionEquality().equals(other.calendar, _calendar)&&const DeepCollectionEquality().equals(other.retention, _retention)&&(identical(other.cardsDue, cardsDue) || other.cardsDue == cardsDue)&&(identical(other.streak, streak) || other.streak == streak));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_nextActions),const DeepCollectionEquality().hash(_weakTags),const DeepCollectionEquality().hash(_weakCards),const DeepCollectionEquality().hash(_calendar),const DeepCollectionEquality().hash(_retention),cardsDue,streak);
}

@override
String toString() {
    return 'InsightsSnapshot(nextActions: $nextActions, weakTags: $weakTags, weakCards: $weakCards, calendar: $calendar, retention: $retention, cardsDue: $cardsDue, streak: $streak)';
}


}

/// @nodoc
abstract mixin class _$InsightsSnapshotCopyWith<$Res> implements $InsightsSnapshotCopyWith<$Res> {
  factory _$InsightsSnapshotCopyWith(_InsightsSnapshot value, $Res Function(_InsightsSnapshot) _then) = __$InsightsSnapshotCopyWithImpl;
@override @useResult
$Res call({
 List<StudyNextAction> nextActions, List<WeakTagInsight> weakTags, List<WeakCardInsight> weakCards, List<StudyDayActivity> calendar, List<RetentionPoint> retention, int cardsDue, int streak
});




}
/// @nodoc
class __$InsightsSnapshotCopyWithImpl<$Res>
    implements _$InsightsSnapshotCopyWith<$Res> {
  __$InsightsSnapshotCopyWithImpl(this._self, this._then);

  final _InsightsSnapshot _self;
  final $Res Function(_InsightsSnapshot) _then;

/// Create a copy of InsightsSnapshot
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? nextActions = null,Object? weakTags = null,Object? weakCards = null,Object? calendar = null,Object? retention = null,Object? cardsDue = null,Object? streak = null,}) {
  return _then(_InsightsSnapshot(
nextActions: null == nextActions ? _self._nextActions : nextActions // ignore: cast_nullable_to_non_nullable
as List<StudyNextAction>,weakTags: null == weakTags ? _self._weakTags : weakTags // ignore: cast_nullable_to_non_nullable
as List<WeakTagInsight>,weakCards: null == weakCards ? _self._weakCards : weakCards // ignore: cast_nullable_to_non_nullable
as List<WeakCardInsight>,calendar: null == calendar ? _self._calendar : calendar // ignore: cast_nullable_to_non_nullable
as List<StudyDayActivity>,retention: null == retention ? _self._retention : retention // ignore: cast_nullable_to_non_nullable
as List<RetentionPoint>,cardsDue: null == cardsDue ? _self.cardsDue : cardsDue // ignore: cast_nullable_to_non_nullable
as int,streak: null == streak ? _self.streak : streak // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
