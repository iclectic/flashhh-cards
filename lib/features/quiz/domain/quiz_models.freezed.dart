// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quiz_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$QuizAttempt {

 String get id; String? get deckId; QuizQuestionStyle get questionStyle; int? get timedSeconds; int get questionCount; int get correctCount; DateTime get startedAt; DateTime? get completedAt;
/// Create a copy of QuizAttempt
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuizAttemptCopyWith<QuizAttempt> get copyWith => _$QuizAttemptCopyWithImpl<QuizAttempt>(this as QuizAttempt, _$identity);

  /// Serializes this QuizAttempt to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as QuizAttempt;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuizAttempt&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.deckId, _this.deckId) || other.deckId == _this.deckId)&&(identical(other.questionStyle, _this.questionStyle) || other.questionStyle == _this.questionStyle)&&(identical(other.timedSeconds, _this.timedSeconds) || other.timedSeconds == _this.timedSeconds)&&(identical(other.questionCount, _this.questionCount) || other.questionCount == _this.questionCount)&&(identical(other.correctCount, _this.correctCount) || other.correctCount == _this.correctCount)&&(identical(other.startedAt, _this.startedAt) || other.startedAt == _this.startedAt)&&(identical(other.completedAt, _this.completedAt) || other.completedAt == _this.completedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as QuizAttempt;
  return Object.hash(runtimeType,_this.id,_this.deckId,_this.questionStyle,_this.timedSeconds,_this.questionCount,_this.correctCount,_this.startedAt,_this.completedAt);
}

@override
String toString() {
  final _this = this as QuizAttempt;
  return 'QuizAttempt(id: ${_this.id}, deckId: ${_this.deckId}, questionStyle: ${_this.questionStyle}, timedSeconds: ${_this.timedSeconds}, questionCount: ${_this.questionCount}, correctCount: ${_this.correctCount}, startedAt: ${_this.startedAt}, completedAt: ${_this.completedAt})';
}


}

/// @nodoc
abstract mixin class $QuizAttemptCopyWith<$Res>  {
  factory $QuizAttemptCopyWith(QuizAttempt value, $Res Function(QuizAttempt) _then) = _$QuizAttemptCopyWithImpl;
@useResult
$Res call({
 String id, String? deckId, QuizQuestionStyle questionStyle, int? timedSeconds, int questionCount, int correctCount, DateTime startedAt, DateTime? completedAt
});




}
/// @nodoc
class _$QuizAttemptCopyWithImpl<$Res>
    implements $QuizAttemptCopyWith<$Res> {
  _$QuizAttemptCopyWithImpl(this._self, this._then);

  final QuizAttempt _self;
  final $Res Function(QuizAttempt) _then;

/// Create a copy of QuizAttempt
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? deckId = freezed,Object? questionStyle = null,Object? timedSeconds = freezed,Object? questionCount = null,Object? correctCount = null,Object? startedAt = null,Object? completedAt = freezed,}) {
  return _then(QuizAttempt(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,deckId: freezed == deckId ? _self.deckId : deckId // ignore: cast_nullable_to_non_nullable
as String?,questionStyle: null == questionStyle ? _self.questionStyle : questionStyle // ignore: cast_nullable_to_non_nullable
as QuizQuestionStyle,timedSeconds: freezed == timedSeconds ? _self.timedSeconds : timedSeconds // ignore: cast_nullable_to_non_nullable
as int?,questionCount: null == questionCount ? _self.questionCount : questionCount // ignore: cast_nullable_to_non_nullable
as int,correctCount: null == correctCount ? _self.correctCount : correctCount // ignore: cast_nullable_to_non_nullable
as int,startedAt: null == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [QuizAttempt].
extension QuizAttemptPatterns on QuizAttempt {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QuizAttempt value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuizAttempt() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QuizAttempt value)  $default,){
final _that = this;
switch (_that) {
case _QuizAttempt():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QuizAttempt value)?  $default,){
final _that = this;
switch (_that) {
case _QuizAttempt() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String? deckId,  QuizQuestionStyle questionStyle,  int? timedSeconds,  int questionCount,  int correctCount,  DateTime startedAt,  DateTime? completedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuizAttempt() when $default != null:
return $default(_that.id,_that.deckId,_that.questionStyle,_that.timedSeconds,_that.questionCount,_that.correctCount,_that.startedAt,_that.completedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String? deckId,  QuizQuestionStyle questionStyle,  int? timedSeconds,  int questionCount,  int correctCount,  DateTime startedAt,  DateTime? completedAt)  $default,) {final _that = this;
switch (_that) {
case _QuizAttempt():
return $default(_that.id,_that.deckId,_that.questionStyle,_that.timedSeconds,_that.questionCount,_that.correctCount,_that.startedAt,_that.completedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String? deckId,  QuizQuestionStyle questionStyle,  int? timedSeconds,  int questionCount,  int correctCount,  DateTime startedAt,  DateTime? completedAt)?  $default,) {final _that = this;
switch (_that) {
case _QuizAttempt() when $default != null:
return $default(_that.id,_that.deckId,_that.questionStyle,_that.timedSeconds,_that.questionCount,_that.correctCount,_that.startedAt,_that.completedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _QuizAttempt implements QuizAttempt {
  const _QuizAttempt({required this.id, this.deckId, required this.questionStyle, this.timedSeconds, this.questionCount = 0, this.correctCount = 0, required this.startedAt, this.completedAt});
  factory _QuizAttempt.fromJson(Map<String, dynamic> json) => _$QuizAttemptFromJson(json);

@override final  String id;
@override final  String? deckId;
@override final  QuizQuestionStyle questionStyle;
@override final  int? timedSeconds;
@override@JsonKey() final  int questionCount;
@override@JsonKey() final  int correctCount;
@override final  DateTime startedAt;
@override final  DateTime? completedAt;

/// Create a copy of QuizAttempt
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuizAttemptCopyWith<_QuizAttempt> get copyWith => __$QuizAttemptCopyWithImpl<_QuizAttempt>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QuizAttemptToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuizAttempt&&(identical(other.id, id) || other.id == id)&&(identical(other.deckId, deckId) || other.deckId == deckId)&&(identical(other.questionStyle, questionStyle) || other.questionStyle == questionStyle)&&(identical(other.timedSeconds, timedSeconds) || other.timedSeconds == timedSeconds)&&(identical(other.questionCount, questionCount) || other.questionCount == questionCount)&&(identical(other.correctCount, correctCount) || other.correctCount == correctCount)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,deckId,questionStyle,timedSeconds,questionCount,correctCount,startedAt,completedAt);
}

@override
String toString() {
    return 'QuizAttempt(id: $id, deckId: $deckId, questionStyle: $questionStyle, timedSeconds: $timedSeconds, questionCount: $questionCount, correctCount: $correctCount, startedAt: $startedAt, completedAt: $completedAt)';
}


}

/// @nodoc
abstract mixin class _$QuizAttemptCopyWith<$Res> implements $QuizAttemptCopyWith<$Res> {
  factory _$QuizAttemptCopyWith(_QuizAttempt value, $Res Function(_QuizAttempt) _then) = __$QuizAttemptCopyWithImpl;
@override @useResult
$Res call({
 String id, String? deckId, QuizQuestionStyle questionStyle, int? timedSeconds, int questionCount, int correctCount, DateTime startedAt, DateTime? completedAt
});




}
/// @nodoc
class __$QuizAttemptCopyWithImpl<$Res>
    implements _$QuizAttemptCopyWith<$Res> {
  __$QuizAttemptCopyWithImpl(this._self, this._then);

  final _QuizAttempt _self;
  final $Res Function(_QuizAttempt) _then;

/// Create a copy of QuizAttempt
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? deckId = freezed,Object? questionStyle = null,Object? timedSeconds = freezed,Object? questionCount = null,Object? correctCount = null,Object? startedAt = null,Object? completedAt = freezed,}) {
  return _then(_QuizAttempt(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,deckId: freezed == deckId ? _self.deckId : deckId // ignore: cast_nullable_to_non_nullable
as String?,questionStyle: null == questionStyle ? _self.questionStyle : questionStyle // ignore: cast_nullable_to_non_nullable
as QuizQuestionStyle,timedSeconds: freezed == timedSeconds ? _self.timedSeconds : timedSeconds // ignore: cast_nullable_to_non_nullable
as int?,questionCount: null == questionCount ? _self.questionCount : questionCount // ignore: cast_nullable_to_non_nullable
as int,correctCount: null == correctCount ? _self.correctCount : correctCount // ignore: cast_nullable_to_non_nullable
as int,startedAt: null == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$QuizAnswer {

 String get id; String get attemptId; String get cardId; QuizQuestionType get questionType; String get prompt; String get correctAnswer; String? get givenAnswer; List<String> get choices; bool get isCorrect; DateTime get answeredAt; int? get elapsedMilliseconds;
/// Create a copy of QuizAnswer
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuizAnswerCopyWith<QuizAnswer> get copyWith => _$QuizAnswerCopyWithImpl<QuizAnswer>(this as QuizAnswer, _$identity);

  /// Serializes this QuizAnswer to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as QuizAnswer;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuizAnswer&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.attemptId, _this.attemptId) || other.attemptId == _this.attemptId)&&(identical(other.cardId, _this.cardId) || other.cardId == _this.cardId)&&(identical(other.questionType, _this.questionType) || other.questionType == _this.questionType)&&(identical(other.prompt, _this.prompt) || other.prompt == _this.prompt)&&(identical(other.correctAnswer, _this.correctAnswer) || other.correctAnswer == _this.correctAnswer)&&(identical(other.givenAnswer, _this.givenAnswer) || other.givenAnswer == _this.givenAnswer)&&const DeepCollectionEquality().equals(other.choices, _this.choices)&&(identical(other.isCorrect, _this.isCorrect) || other.isCorrect == _this.isCorrect)&&(identical(other.answeredAt, _this.answeredAt) || other.answeredAt == _this.answeredAt)&&(identical(other.elapsedMilliseconds, _this.elapsedMilliseconds) || other.elapsedMilliseconds == _this.elapsedMilliseconds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as QuizAnswer;
  return Object.hash(runtimeType,_this.id,_this.attemptId,_this.cardId,_this.questionType,_this.prompt,_this.correctAnswer,_this.givenAnswer,const DeepCollectionEquality().hash(_this.choices),_this.isCorrect,_this.answeredAt,_this.elapsedMilliseconds);
}

@override
String toString() {
  final _this = this as QuizAnswer;
  return 'QuizAnswer(id: ${_this.id}, attemptId: ${_this.attemptId}, cardId: ${_this.cardId}, questionType: ${_this.questionType}, prompt: ${_this.prompt}, correctAnswer: ${_this.correctAnswer}, givenAnswer: ${_this.givenAnswer}, choices: ${_this.choices}, isCorrect: ${_this.isCorrect}, answeredAt: ${_this.answeredAt}, elapsedMilliseconds: ${_this.elapsedMilliseconds})';
}


}

/// @nodoc
abstract mixin class $QuizAnswerCopyWith<$Res>  {
  factory $QuizAnswerCopyWith(QuizAnswer value, $Res Function(QuizAnswer) _then) = _$QuizAnswerCopyWithImpl;
@useResult
$Res call({
 String id, String attemptId, String cardId, QuizQuestionType questionType, String prompt, String correctAnswer, String? givenAnswer, List<String> choices, bool isCorrect, DateTime answeredAt, int? elapsedMilliseconds
});




}
/// @nodoc
class _$QuizAnswerCopyWithImpl<$Res>
    implements $QuizAnswerCopyWith<$Res> {
  _$QuizAnswerCopyWithImpl(this._self, this._then);

  final QuizAnswer _self;
  final $Res Function(QuizAnswer) _then;

/// Create a copy of QuizAnswer
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? attemptId = null,Object? cardId = null,Object? questionType = null,Object? prompt = null,Object? correctAnswer = null,Object? givenAnswer = freezed,Object? choices = null,Object? isCorrect = null,Object? answeredAt = null,Object? elapsedMilliseconds = freezed,}) {
  return _then(QuizAnswer(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,attemptId: null == attemptId ? _self.attemptId : attemptId // ignore: cast_nullable_to_non_nullable
as String,cardId: null == cardId ? _self.cardId : cardId // ignore: cast_nullable_to_non_nullable
as String,questionType: null == questionType ? _self.questionType : questionType // ignore: cast_nullable_to_non_nullable
as QuizQuestionType,prompt: null == prompt ? _self.prompt : prompt // ignore: cast_nullable_to_non_nullable
as String,correctAnswer: null == correctAnswer ? _self.correctAnswer : correctAnswer // ignore: cast_nullable_to_non_nullable
as String,givenAnswer: freezed == givenAnswer ? _self.givenAnswer : givenAnswer // ignore: cast_nullable_to_non_nullable
as String?,choices: null == choices ? _self.choices : choices // ignore: cast_nullable_to_non_nullable
as List<String>,isCorrect: null == isCorrect ? _self.isCorrect : isCorrect // ignore: cast_nullable_to_non_nullable
as bool,answeredAt: null == answeredAt ? _self.answeredAt : answeredAt // ignore: cast_nullable_to_non_nullable
as DateTime,elapsedMilliseconds: freezed == elapsedMilliseconds ? _self.elapsedMilliseconds : elapsedMilliseconds // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [QuizAnswer].
extension QuizAnswerPatterns on QuizAnswer {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QuizAnswer value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuizAnswer() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QuizAnswer value)  $default,){
final _that = this;
switch (_that) {
case _QuizAnswer():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QuizAnswer value)?  $default,){
final _that = this;
switch (_that) {
case _QuizAnswer() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String attemptId,  String cardId,  QuizQuestionType questionType,  String prompt,  String correctAnswer,  String? givenAnswer,  List<String> choices,  bool isCorrect,  DateTime answeredAt,  int? elapsedMilliseconds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuizAnswer() when $default != null:
return $default(_that.id,_that.attemptId,_that.cardId,_that.questionType,_that.prompt,_that.correctAnswer,_that.givenAnswer,_that.choices,_that.isCorrect,_that.answeredAt,_that.elapsedMilliseconds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String attemptId,  String cardId,  QuizQuestionType questionType,  String prompt,  String correctAnswer,  String? givenAnswer,  List<String> choices,  bool isCorrect,  DateTime answeredAt,  int? elapsedMilliseconds)  $default,) {final _that = this;
switch (_that) {
case _QuizAnswer():
return $default(_that.id,_that.attemptId,_that.cardId,_that.questionType,_that.prompt,_that.correctAnswer,_that.givenAnswer,_that.choices,_that.isCorrect,_that.answeredAt,_that.elapsedMilliseconds);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String attemptId,  String cardId,  QuizQuestionType questionType,  String prompt,  String correctAnswer,  String? givenAnswer,  List<String> choices,  bool isCorrect,  DateTime answeredAt,  int? elapsedMilliseconds)?  $default,) {final _that = this;
switch (_that) {
case _QuizAnswer() when $default != null:
return $default(_that.id,_that.attemptId,_that.cardId,_that.questionType,_that.prompt,_that.correctAnswer,_that.givenAnswer,_that.choices,_that.isCorrect,_that.answeredAt,_that.elapsedMilliseconds);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _QuizAnswer implements QuizAnswer {
  const _QuizAnswer({required this.id, required this.attemptId, required this.cardId, required this.questionType, required this.prompt, required this.correctAnswer, this.givenAnswer,  List<String> choices = const <String>[], required this.isCorrect, required this.answeredAt, this.elapsedMilliseconds}): _choices = choices;
  factory _QuizAnswer.fromJson(Map<String, dynamic> json) => _$QuizAnswerFromJson(json);

@override final  String id;
@override final  String attemptId;
@override final  String cardId;
@override final  QuizQuestionType questionType;
@override final  String prompt;
@override final  String correctAnswer;
@override final  String? givenAnswer;
 final  List<String> _choices;
@override@JsonKey() List<String> get choices {
  if (_choices is EqualUnmodifiableListView) return _choices;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_choices);
}

@override final  bool isCorrect;
@override final  DateTime answeredAt;
@override final  int? elapsedMilliseconds;

/// Create a copy of QuizAnswer
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuizAnswerCopyWith<_QuizAnswer> get copyWith => __$QuizAnswerCopyWithImpl<_QuizAnswer>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QuizAnswerToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuizAnswer&&(identical(other.id, id) || other.id == id)&&(identical(other.attemptId, attemptId) || other.attemptId == attemptId)&&(identical(other.cardId, cardId) || other.cardId == cardId)&&(identical(other.questionType, questionType) || other.questionType == questionType)&&(identical(other.prompt, prompt) || other.prompt == prompt)&&(identical(other.correctAnswer, correctAnswer) || other.correctAnswer == correctAnswer)&&(identical(other.givenAnswer, givenAnswer) || other.givenAnswer == givenAnswer)&&const DeepCollectionEquality().equals(other.choices, _choices)&&(identical(other.isCorrect, isCorrect) || other.isCorrect == isCorrect)&&(identical(other.answeredAt, answeredAt) || other.answeredAt == answeredAt)&&(identical(other.elapsedMilliseconds, elapsedMilliseconds) || other.elapsedMilliseconds == elapsedMilliseconds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,attemptId,cardId,questionType,prompt,correctAnswer,givenAnswer,const DeepCollectionEquality().hash(_choices),isCorrect,answeredAt,elapsedMilliseconds);
}

@override
String toString() {
    return 'QuizAnswer(id: $id, attemptId: $attemptId, cardId: $cardId, questionType: $questionType, prompt: $prompt, correctAnswer: $correctAnswer, givenAnswer: $givenAnswer, choices: $choices, isCorrect: $isCorrect, answeredAt: $answeredAt, elapsedMilliseconds: $elapsedMilliseconds)';
}


}

/// @nodoc
abstract mixin class _$QuizAnswerCopyWith<$Res> implements $QuizAnswerCopyWith<$Res> {
  factory _$QuizAnswerCopyWith(_QuizAnswer value, $Res Function(_QuizAnswer) _then) = __$QuizAnswerCopyWithImpl;
@override @useResult
$Res call({
 String id, String attemptId, String cardId, QuizQuestionType questionType, String prompt, String correctAnswer, String? givenAnswer, List<String> choices, bool isCorrect, DateTime answeredAt, int? elapsedMilliseconds
});




}
/// @nodoc
class __$QuizAnswerCopyWithImpl<$Res>
    implements _$QuizAnswerCopyWith<$Res> {
  __$QuizAnswerCopyWithImpl(this._self, this._then);

  final _QuizAnswer _self;
  final $Res Function(_QuizAnswer) _then;

/// Create a copy of QuizAnswer
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? attemptId = null,Object? cardId = null,Object? questionType = null,Object? prompt = null,Object? correctAnswer = null,Object? givenAnswer = freezed,Object? choices = null,Object? isCorrect = null,Object? answeredAt = null,Object? elapsedMilliseconds = freezed,}) {
  return _then(_QuizAnswer(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,attemptId: null == attemptId ? _self.attemptId : attemptId // ignore: cast_nullable_to_non_nullable
as String,cardId: null == cardId ? _self.cardId : cardId // ignore: cast_nullable_to_non_nullable
as String,questionType: null == questionType ? _self.questionType : questionType // ignore: cast_nullable_to_non_nullable
as QuizQuestionType,prompt: null == prompt ? _self.prompt : prompt // ignore: cast_nullable_to_non_nullable
as String,correctAnswer: null == correctAnswer ? _self.correctAnswer : correctAnswer // ignore: cast_nullable_to_non_nullable
as String,givenAnswer: freezed == givenAnswer ? _self.givenAnswer : givenAnswer // ignore: cast_nullable_to_non_nullable
as String?,choices: null == choices ? _self._choices : choices // ignore: cast_nullable_to_non_nullable
as List<String>,isCorrect: null == isCorrect ? _self.isCorrect : isCorrect // ignore: cast_nullable_to_non_nullable
as bool,answeredAt: null == answeredAt ? _self.answeredAt : answeredAt // ignore: cast_nullable_to_non_nullable
as DateTime,elapsedMilliseconds: freezed == elapsedMilliseconds ? _self.elapsedMilliseconds : elapsedMilliseconds // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$QuizAttemptSummary {

 QuizAttempt get attempt; List<QuizAnswer> get answers; String? get deckName;
/// Create a copy of QuizAttemptSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuizAttemptSummaryCopyWith<QuizAttemptSummary> get copyWith => _$QuizAttemptSummaryCopyWithImpl<QuizAttemptSummary>(this as QuizAttemptSummary, _$identity);

  /// Serializes this QuizAttemptSummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as QuizAttemptSummary;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuizAttemptSummary&&(identical(other.attempt, _this.attempt) || other.attempt == _this.attempt)&&const DeepCollectionEquality().equals(other.answers, _this.answers)&&(identical(other.deckName, _this.deckName) || other.deckName == _this.deckName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as QuizAttemptSummary;
  return Object.hash(runtimeType,_this.attempt,const DeepCollectionEquality().hash(_this.answers),_this.deckName);
}

@override
String toString() {
  final _this = this as QuizAttemptSummary;
  return 'QuizAttemptSummary(attempt: ${_this.attempt}, answers: ${_this.answers}, deckName: ${_this.deckName})';
}


}

/// @nodoc
abstract mixin class $QuizAttemptSummaryCopyWith<$Res>  {
  factory $QuizAttemptSummaryCopyWith(QuizAttemptSummary value, $Res Function(QuizAttemptSummary) _then) = _$QuizAttemptSummaryCopyWithImpl;
@useResult
$Res call({
 QuizAttempt attempt, List<QuizAnswer> answers, String? deckName
});


$QuizAttemptCopyWith<$Res> get attempt;

}
/// @nodoc
class _$QuizAttemptSummaryCopyWithImpl<$Res>
    implements $QuizAttemptSummaryCopyWith<$Res> {
  _$QuizAttemptSummaryCopyWithImpl(this._self, this._then);

  final QuizAttemptSummary _self;
  final $Res Function(QuizAttemptSummary) _then;

/// Create a copy of QuizAttemptSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? attempt = null,Object? answers = null,Object? deckName = freezed,}) {
  return _then(QuizAttemptSummary(
attempt: null == attempt ? _self.attempt : attempt // ignore: cast_nullable_to_non_nullable
as QuizAttempt,answers: null == answers ? _self.answers : answers // ignore: cast_nullable_to_non_nullable
as List<QuizAnswer>,deckName: freezed == deckName ? _self.deckName : deckName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of QuizAttemptSummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$QuizAttemptCopyWith<$Res> get attempt {
  
  return $QuizAttemptCopyWith<$Res>(_self.attempt, (value) {
    return _then(_self.copyWith(attempt: value));
  });
}
}


/// Adds pattern-matching-related methods to [QuizAttemptSummary].
extension QuizAttemptSummaryPatterns on QuizAttemptSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QuizAttemptSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuizAttemptSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QuizAttemptSummary value)  $default,){
final _that = this;
switch (_that) {
case _QuizAttemptSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QuizAttemptSummary value)?  $default,){
final _that = this;
switch (_that) {
case _QuizAttemptSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( QuizAttempt attempt,  List<QuizAnswer> answers,  String? deckName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuizAttemptSummary() when $default != null:
return $default(_that.attempt,_that.answers,_that.deckName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( QuizAttempt attempt,  List<QuizAnswer> answers,  String? deckName)  $default,) {final _that = this;
switch (_that) {
case _QuizAttemptSummary():
return $default(_that.attempt,_that.answers,_that.deckName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( QuizAttempt attempt,  List<QuizAnswer> answers,  String? deckName)?  $default,) {final _that = this;
switch (_that) {
case _QuizAttemptSummary() when $default != null:
return $default(_that.attempt,_that.answers,_that.deckName);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _QuizAttemptSummary implements QuizAttemptSummary {
  const _QuizAttemptSummary({required this.attempt, required  List<QuizAnswer> answers, this.deckName}): _answers = answers;
  factory _QuizAttemptSummary.fromJson(Map<String, dynamic> json) => _$QuizAttemptSummaryFromJson(json);

@override final  QuizAttempt attempt;
 final  List<QuizAnswer> _answers;
@override List<QuizAnswer> get answers {
  if (_answers is EqualUnmodifiableListView) return _answers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_answers);
}

@override final  String? deckName;

/// Create a copy of QuizAttemptSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuizAttemptSummaryCopyWith<_QuizAttemptSummary> get copyWith => __$QuizAttemptSummaryCopyWithImpl<_QuizAttemptSummary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QuizAttemptSummaryToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuizAttemptSummary&&(identical(other.attempt, attempt) || other.attempt == attempt)&&const DeepCollectionEquality().equals(other.answers, _answers)&&(identical(other.deckName, deckName) || other.deckName == deckName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,attempt,const DeepCollectionEquality().hash(_answers),deckName);
}

@override
String toString() {
    return 'QuizAttemptSummary(attempt: $attempt, answers: $answers, deckName: $deckName)';
}


}

/// @nodoc
abstract mixin class _$QuizAttemptSummaryCopyWith<$Res> implements $QuizAttemptSummaryCopyWith<$Res> {
  factory _$QuizAttemptSummaryCopyWith(_QuizAttemptSummary value, $Res Function(_QuizAttemptSummary) _then) = __$QuizAttemptSummaryCopyWithImpl;
@override @useResult
$Res call({
 QuizAttempt attempt, List<QuizAnswer> answers, String? deckName
});


@override $QuizAttemptCopyWith<$Res> get attempt;

}
/// @nodoc
class __$QuizAttemptSummaryCopyWithImpl<$Res>
    implements _$QuizAttemptSummaryCopyWith<$Res> {
  __$QuizAttemptSummaryCopyWithImpl(this._self, this._then);

  final _QuizAttemptSummary _self;
  final $Res Function(_QuizAttemptSummary) _then;

/// Create a copy of QuizAttemptSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? attempt = null,Object? answers = null,Object? deckName = freezed,}) {
  return _then(_QuizAttemptSummary(
attempt: null == attempt ? _self.attempt : attempt // ignore: cast_nullable_to_non_nullable
as QuizAttempt,answers: null == answers ? _self._answers : answers // ignore: cast_nullable_to_non_nullable
as List<QuizAnswer>,deckName: freezed == deckName ? _self.deckName : deckName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of QuizAttemptSummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$QuizAttemptCopyWith<$Res> get attempt {
  
  return $QuizAttemptCopyWith<$Res>(_self.attempt, (value) {
    return _then(_self.copyWith(attempt: value));
  });
}
}

// dart format on
