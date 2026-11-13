// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'flashcard.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Flashcard {

 String get id; String get deckId; String get question; String get answer; DateTime get createdAt; DateTime get updatedAt; FlashcardSource get source; Difficulty? get difficulty; List<String> get tags; DateTime? get lastReviewedAt; DateTime? get nextReviewAt; int get reviewCount; int get successCount; int get failureCount; double get easeFactor; int get intervalDays; int get repetitions; int get lapses; DateTime? get deletedAt;
/// Create a copy of Flashcard
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FlashcardCopyWith<Flashcard> get copyWith => _$FlashcardCopyWithImpl<Flashcard>(this as Flashcard, _$identity);

  /// Serializes this Flashcard to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Flashcard;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Flashcard&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.deckId, _this.deckId) || other.deckId == _this.deckId)&&(identical(other.question, _this.question) || other.question == _this.question)&&(identical(other.answer, _this.answer) || other.answer == _this.answer)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt)&&(identical(other.source, _this.source) || other.source == _this.source)&&(identical(other.difficulty, _this.difficulty) || other.difficulty == _this.difficulty)&&const DeepCollectionEquality().equals(other.tags, _this.tags)&&(identical(other.lastReviewedAt, _this.lastReviewedAt) || other.lastReviewedAt == _this.lastReviewedAt)&&(identical(other.nextReviewAt, _this.nextReviewAt) || other.nextReviewAt == _this.nextReviewAt)&&(identical(other.reviewCount, _this.reviewCount) || other.reviewCount == _this.reviewCount)&&(identical(other.successCount, _this.successCount) || other.successCount == _this.successCount)&&(identical(other.failureCount, _this.failureCount) || other.failureCount == _this.failureCount)&&(identical(other.easeFactor, _this.easeFactor) || other.easeFactor == _this.easeFactor)&&(identical(other.intervalDays, _this.intervalDays) || other.intervalDays == _this.intervalDays)&&(identical(other.repetitions, _this.repetitions) || other.repetitions == _this.repetitions)&&(identical(other.lapses, _this.lapses) || other.lapses == _this.lapses)&&(identical(other.deletedAt, _this.deletedAt) || other.deletedAt == _this.deletedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Flashcard;
  return Object.hashAll([runtimeType,_this.id,_this.deckId,_this.question,_this.answer,_this.createdAt,_this.updatedAt,_this.source,_this.difficulty,const DeepCollectionEquality().hash(_this.tags),_this.lastReviewedAt,_this.nextReviewAt,_this.reviewCount,_this.successCount,_this.failureCount,_this.easeFactor,_this.intervalDays,_this.repetitions,_this.lapses,_this.deletedAt]);
}

@override
String toString() {
  final _this = this as Flashcard;
  return 'Flashcard(id: ${_this.id}, deckId: ${_this.deckId}, question: ${_this.question}, answer: ${_this.answer}, createdAt: ${_this.createdAt}, updatedAt: ${_this.updatedAt}, source: ${_this.source}, difficulty: ${_this.difficulty}, tags: ${_this.tags}, lastReviewedAt: ${_this.lastReviewedAt}, nextReviewAt: ${_this.nextReviewAt}, reviewCount: ${_this.reviewCount}, successCount: ${_this.successCount}, failureCount: ${_this.failureCount}, easeFactor: ${_this.easeFactor}, intervalDays: ${_this.intervalDays}, repetitions: ${_this.repetitions}, lapses: ${_this.lapses}, deletedAt: ${_this.deletedAt})';
}


}

/// @nodoc
abstract mixin class $FlashcardCopyWith<$Res>  {
  factory $FlashcardCopyWith(Flashcard value, $Res Function(Flashcard) _then) = _$FlashcardCopyWithImpl;
@useResult
$Res call({
 String id, String deckId, String question, String answer, DateTime createdAt, DateTime updatedAt, FlashcardSource source, Difficulty? difficulty, List<String> tags, DateTime? lastReviewedAt, DateTime? nextReviewAt, int reviewCount, int successCount, int failureCount, double easeFactor, int intervalDays, int repetitions, int lapses, DateTime? deletedAt
});




}
/// @nodoc
class _$FlashcardCopyWithImpl<$Res>
    implements $FlashcardCopyWith<$Res> {
  _$FlashcardCopyWithImpl(this._self, this._then);

  final Flashcard _self;
  final $Res Function(Flashcard) _then;

/// Create a copy of Flashcard
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? deckId = null,Object? question = null,Object? answer = null,Object? createdAt = null,Object? updatedAt = null,Object? source = null,Object? difficulty = freezed,Object? tags = null,Object? lastReviewedAt = freezed,Object? nextReviewAt = freezed,Object? reviewCount = null,Object? successCount = null,Object? failureCount = null,Object? easeFactor = null,Object? intervalDays = null,Object? repetitions = null,Object? lapses = null,Object? deletedAt = freezed,}) {
  return _then(Flashcard(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,deckId: null == deckId ? _self.deckId : deckId // ignore: cast_nullable_to_non_nullable
as String,question: null == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
as String,answer: null == answer ? _self.answer : answer // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as FlashcardSource,difficulty: freezed == difficulty ? _self.difficulty : difficulty // ignore: cast_nullable_to_non_nullable
as Difficulty?,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,lastReviewedAt: freezed == lastReviewedAt ? _self.lastReviewedAt : lastReviewedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,nextReviewAt: freezed == nextReviewAt ? _self.nextReviewAt : nextReviewAt // ignore: cast_nullable_to_non_nullable
as DateTime?,reviewCount: null == reviewCount ? _self.reviewCount : reviewCount // ignore: cast_nullable_to_non_nullable
as int,successCount: null == successCount ? _self.successCount : successCount // ignore: cast_nullable_to_non_nullable
as int,failureCount: null == failureCount ? _self.failureCount : failureCount // ignore: cast_nullable_to_non_nullable
as int,easeFactor: null == easeFactor ? _self.easeFactor : easeFactor // ignore: cast_nullable_to_non_nullable
as double,intervalDays: null == intervalDays ? _self.intervalDays : intervalDays // ignore: cast_nullable_to_non_nullable
as int,repetitions: null == repetitions ? _self.repetitions : repetitions // ignore: cast_nullable_to_non_nullable
as int,lapses: null == lapses ? _self.lapses : lapses // ignore: cast_nullable_to_non_nullable
as int,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [Flashcard].
extension FlashcardPatterns on Flashcard {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Flashcard value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Flashcard() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Flashcard value)  $default,){
final _that = this;
switch (_that) {
case _Flashcard():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Flashcard value)?  $default,){
final _that = this;
switch (_that) {
case _Flashcard() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String deckId,  String question,  String answer,  DateTime createdAt,  DateTime updatedAt,  FlashcardSource source,  Difficulty? difficulty,  List<String> tags,  DateTime? lastReviewedAt,  DateTime? nextReviewAt,  int reviewCount,  int successCount,  int failureCount,  double easeFactor,  int intervalDays,  int repetitions,  int lapses,  DateTime? deletedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Flashcard() when $default != null:
return $default(_that.id,_that.deckId,_that.question,_that.answer,_that.createdAt,_that.updatedAt,_that.source,_that.difficulty,_that.tags,_that.lastReviewedAt,_that.nextReviewAt,_that.reviewCount,_that.successCount,_that.failureCount,_that.easeFactor,_that.intervalDays,_that.repetitions,_that.lapses,_that.deletedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String deckId,  String question,  String answer,  DateTime createdAt,  DateTime updatedAt,  FlashcardSource source,  Difficulty? difficulty,  List<String> tags,  DateTime? lastReviewedAt,  DateTime? nextReviewAt,  int reviewCount,  int successCount,  int failureCount,  double easeFactor,  int intervalDays,  int repetitions,  int lapses,  DateTime? deletedAt)  $default,) {final _that = this;
switch (_that) {
case _Flashcard():
return $default(_that.id,_that.deckId,_that.question,_that.answer,_that.createdAt,_that.updatedAt,_that.source,_that.difficulty,_that.tags,_that.lastReviewedAt,_that.nextReviewAt,_that.reviewCount,_that.successCount,_that.failureCount,_that.easeFactor,_that.intervalDays,_that.repetitions,_that.lapses,_that.deletedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String deckId,  String question,  String answer,  DateTime createdAt,  DateTime updatedAt,  FlashcardSource source,  Difficulty? difficulty,  List<String> tags,  DateTime? lastReviewedAt,  DateTime? nextReviewAt,  int reviewCount,  int successCount,  int failureCount,  double easeFactor,  int intervalDays,  int repetitions,  int lapses,  DateTime? deletedAt)?  $default,) {final _that = this;
switch (_that) {
case _Flashcard() when $default != null:
return $default(_that.id,_that.deckId,_that.question,_that.answer,_that.createdAt,_that.updatedAt,_that.source,_that.difficulty,_that.tags,_that.lastReviewedAt,_that.nextReviewAt,_that.reviewCount,_that.successCount,_that.failureCount,_that.easeFactor,_that.intervalDays,_that.repetitions,_that.lapses,_that.deletedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Flashcard implements Flashcard {
  const _Flashcard({required this.id, required this.deckId, required this.question, required this.answer, required this.createdAt, required this.updatedAt, required this.source, this.difficulty,  List<String> tags = const <String>[], this.lastReviewedAt, this.nextReviewAt, this.reviewCount = 0, this.successCount = 0, this.failureCount = 0, this.easeFactor = 2.5, this.intervalDays = 0, this.repetitions = 0, this.lapses = 0, this.deletedAt}): _tags = tags;
  factory _Flashcard.fromJson(Map<String, dynamic> json) => _$FlashcardFromJson(json);

@override final  String id;
@override final  String deckId;
@override final  String question;
@override final  String answer;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
@override final  FlashcardSource source;
@override final  Difficulty? difficulty;
 final  List<String> _tags;
@override@JsonKey() List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}

@override final  DateTime? lastReviewedAt;
@override final  DateTime? nextReviewAt;
@override@JsonKey() final  int reviewCount;
@override@JsonKey() final  int successCount;
@override@JsonKey() final  int failureCount;
@override@JsonKey() final  double easeFactor;
@override@JsonKey() final  int intervalDays;
@override@JsonKey() final  int repetitions;
@override@JsonKey() final  int lapses;
@override final  DateTime? deletedAt;

/// Create a copy of Flashcard
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FlashcardCopyWith<_Flashcard> get copyWith => __$FlashcardCopyWithImpl<_Flashcard>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FlashcardToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Flashcard&&(identical(other.id, id) || other.id == id)&&(identical(other.deckId, deckId) || other.deckId == deckId)&&(identical(other.question, question) || other.question == question)&&(identical(other.answer, answer) || other.answer == answer)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.source, source) || other.source == source)&&(identical(other.difficulty, difficulty) || other.difficulty == difficulty)&&const DeepCollectionEquality().equals(other.tags, _tags)&&(identical(other.lastReviewedAt, lastReviewedAt) || other.lastReviewedAt == lastReviewedAt)&&(identical(other.nextReviewAt, nextReviewAt) || other.nextReviewAt == nextReviewAt)&&(identical(other.reviewCount, reviewCount) || other.reviewCount == reviewCount)&&(identical(other.successCount, successCount) || other.successCount == successCount)&&(identical(other.failureCount, failureCount) || other.failureCount == failureCount)&&(identical(other.easeFactor, easeFactor) || other.easeFactor == easeFactor)&&(identical(other.intervalDays, intervalDays) || other.intervalDays == intervalDays)&&(identical(other.repetitions, repetitions) || other.repetitions == repetitions)&&(identical(other.lapses, lapses) || other.lapses == lapses)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hashAll([runtimeType,id,deckId,question,answer,createdAt,updatedAt,source,difficulty,const DeepCollectionEquality().hash(_tags),lastReviewedAt,nextReviewAt,reviewCount,successCount,failureCount,easeFactor,intervalDays,repetitions,lapses,deletedAt]);
}

@override
String toString() {
    return 'Flashcard(id: $id, deckId: $deckId, question: $question, answer: $answer, createdAt: $createdAt, updatedAt: $updatedAt, source: $source, difficulty: $difficulty, tags: $tags, lastReviewedAt: $lastReviewedAt, nextReviewAt: $nextReviewAt, reviewCount: $reviewCount, successCount: $successCount, failureCount: $failureCount, easeFactor: $easeFactor, intervalDays: $intervalDays, repetitions: $repetitions, lapses: $lapses, deletedAt: $deletedAt)';
}


}

/// @nodoc
abstract mixin class _$FlashcardCopyWith<$Res> implements $FlashcardCopyWith<$Res> {
  factory _$FlashcardCopyWith(_Flashcard value, $Res Function(_Flashcard) _then) = __$FlashcardCopyWithImpl;
@override @useResult
$Res call({
 String id, String deckId, String question, String answer, DateTime createdAt, DateTime updatedAt, FlashcardSource source, Difficulty? difficulty, List<String> tags, DateTime? lastReviewedAt, DateTime? nextReviewAt, int reviewCount, int successCount, int failureCount, double easeFactor, int intervalDays, int repetitions, int lapses, DateTime? deletedAt
});




}
/// @nodoc
class __$FlashcardCopyWithImpl<$Res>
    implements _$FlashcardCopyWith<$Res> {
  __$FlashcardCopyWithImpl(this._self, this._then);

  final _Flashcard _self;
  final $Res Function(_Flashcard) _then;

/// Create a copy of Flashcard
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? deckId = null,Object? question = null,Object? answer = null,Object? createdAt = null,Object? updatedAt = null,Object? source = null,Object? difficulty = freezed,Object? tags = null,Object? lastReviewedAt = freezed,Object? nextReviewAt = freezed,Object? reviewCount = null,Object? successCount = null,Object? failureCount = null,Object? easeFactor = null,Object? intervalDays = null,Object? repetitions = null,Object? lapses = null,Object? deletedAt = freezed,}) {
  return _then(_Flashcard(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,deckId: null == deckId ? _self.deckId : deckId // ignore: cast_nullable_to_non_nullable
as String,question: null == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
as String,answer: null == answer ? _self.answer : answer // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as FlashcardSource,difficulty: freezed == difficulty ? _self.difficulty : difficulty // ignore: cast_nullable_to_non_nullable
as Difficulty?,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,lastReviewedAt: freezed == lastReviewedAt ? _self.lastReviewedAt : lastReviewedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,nextReviewAt: freezed == nextReviewAt ? _self.nextReviewAt : nextReviewAt // ignore: cast_nullable_to_non_nullable
as DateTime?,reviewCount: null == reviewCount ? _self.reviewCount : reviewCount // ignore: cast_nullable_to_non_nullable
as int,successCount: null == successCount ? _self.successCount : successCount // ignore: cast_nullable_to_non_nullable
as int,failureCount: null == failureCount ? _self.failureCount : failureCount // ignore: cast_nullable_to_non_nullable
as int,easeFactor: null == easeFactor ? _self.easeFactor : easeFactor // ignore: cast_nullable_to_non_nullable
as double,intervalDays: null == intervalDays ? _self.intervalDays : intervalDays // ignore: cast_nullable_to_non_nullable
as int,repetitions: null == repetitions ? _self.repetitions : repetitions // ignore: cast_nullable_to_non_nullable
as int,lapses: null == lapses ? _self.lapses : lapses // ignore: cast_nullable_to_non_nullable
as int,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
