// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'study_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StudySession {

 String get id; String? get deckId; DateTime get startedAt; DateTime? get completedAt; int get cardsReviewed; int get againCount; int get hardCount; int get goodCount; int get easyCount;
/// Create a copy of StudySession
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StudySessionCopyWith<StudySession> get copyWith => _$StudySessionCopyWithImpl<StudySession>(this as StudySession, _$identity);

  /// Serializes this StudySession to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as StudySession;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StudySession&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.deckId, _this.deckId) || other.deckId == _this.deckId)&&(identical(other.startedAt, _this.startedAt) || other.startedAt == _this.startedAt)&&(identical(other.completedAt, _this.completedAt) || other.completedAt == _this.completedAt)&&(identical(other.cardsReviewed, _this.cardsReviewed) || other.cardsReviewed == _this.cardsReviewed)&&(identical(other.againCount, _this.againCount) || other.againCount == _this.againCount)&&(identical(other.hardCount, _this.hardCount) || other.hardCount == _this.hardCount)&&(identical(other.goodCount, _this.goodCount) || other.goodCount == _this.goodCount)&&(identical(other.easyCount, _this.easyCount) || other.easyCount == _this.easyCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as StudySession;
  return Object.hash(runtimeType,_this.id,_this.deckId,_this.startedAt,_this.completedAt,_this.cardsReviewed,_this.againCount,_this.hardCount,_this.goodCount,_this.easyCount);
}

@override
String toString() {
  final _this = this as StudySession;
  return 'StudySession(id: ${_this.id}, deckId: ${_this.deckId}, startedAt: ${_this.startedAt}, completedAt: ${_this.completedAt}, cardsReviewed: ${_this.cardsReviewed}, againCount: ${_this.againCount}, hardCount: ${_this.hardCount}, goodCount: ${_this.goodCount}, easyCount: ${_this.easyCount})';
}


}

/// @nodoc
abstract mixin class $StudySessionCopyWith<$Res>  {
  factory $StudySessionCopyWith(StudySession value, $Res Function(StudySession) _then) = _$StudySessionCopyWithImpl;
@useResult
$Res call({
 String id, String? deckId, DateTime startedAt, DateTime? completedAt, int cardsReviewed, int againCount, int hardCount, int goodCount, int easyCount
});




}
/// @nodoc
class _$StudySessionCopyWithImpl<$Res>
    implements $StudySessionCopyWith<$Res> {
  _$StudySessionCopyWithImpl(this._self, this._then);

  final StudySession _self;
  final $Res Function(StudySession) _then;

/// Create a copy of StudySession
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? deckId = freezed,Object? startedAt = null,Object? completedAt = freezed,Object? cardsReviewed = null,Object? againCount = null,Object? hardCount = null,Object? goodCount = null,Object? easyCount = null,}) {
  return _then(StudySession(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,deckId: freezed == deckId ? _self.deckId : deckId // ignore: cast_nullable_to_non_nullable
as String?,startedAt: null == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,cardsReviewed: null == cardsReviewed ? _self.cardsReviewed : cardsReviewed // ignore: cast_nullable_to_non_nullable
as int,againCount: null == againCount ? _self.againCount : againCount // ignore: cast_nullable_to_non_nullable
as int,hardCount: null == hardCount ? _self.hardCount : hardCount // ignore: cast_nullable_to_non_nullable
as int,goodCount: null == goodCount ? _self.goodCount : goodCount // ignore: cast_nullable_to_non_nullable
as int,easyCount: null == easyCount ? _self.easyCount : easyCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [StudySession].
extension StudySessionPatterns on StudySession {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StudySession value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StudySession() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StudySession value)  $default,){
final _that = this;
switch (_that) {
case _StudySession():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StudySession value)?  $default,){
final _that = this;
switch (_that) {
case _StudySession() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String? deckId,  DateTime startedAt,  DateTime? completedAt,  int cardsReviewed,  int againCount,  int hardCount,  int goodCount,  int easyCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StudySession() when $default != null:
return $default(_that.id,_that.deckId,_that.startedAt,_that.completedAt,_that.cardsReviewed,_that.againCount,_that.hardCount,_that.goodCount,_that.easyCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String? deckId,  DateTime startedAt,  DateTime? completedAt,  int cardsReviewed,  int againCount,  int hardCount,  int goodCount,  int easyCount)  $default,) {final _that = this;
switch (_that) {
case _StudySession():
return $default(_that.id,_that.deckId,_that.startedAt,_that.completedAt,_that.cardsReviewed,_that.againCount,_that.hardCount,_that.goodCount,_that.easyCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String? deckId,  DateTime startedAt,  DateTime? completedAt,  int cardsReviewed,  int againCount,  int hardCount,  int goodCount,  int easyCount)?  $default,) {final _that = this;
switch (_that) {
case _StudySession() when $default != null:
return $default(_that.id,_that.deckId,_that.startedAt,_that.completedAt,_that.cardsReviewed,_that.againCount,_that.hardCount,_that.goodCount,_that.easyCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StudySession implements StudySession {
  const _StudySession({required this.id, this.deckId, required this.startedAt, this.completedAt, this.cardsReviewed = 0, this.againCount = 0, this.hardCount = 0, this.goodCount = 0, this.easyCount = 0});
  factory _StudySession.fromJson(Map<String, dynamic> json) => _$StudySessionFromJson(json);

@override final  String id;
@override final  String? deckId;
@override final  DateTime startedAt;
@override final  DateTime? completedAt;
@override@JsonKey() final  int cardsReviewed;
@override@JsonKey() final  int againCount;
@override@JsonKey() final  int hardCount;
@override@JsonKey() final  int goodCount;
@override@JsonKey() final  int easyCount;

/// Create a copy of StudySession
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StudySessionCopyWith<_StudySession> get copyWith => __$StudySessionCopyWithImpl<_StudySession>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StudySessionToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _StudySession&&(identical(other.id, id) || other.id == id)&&(identical(other.deckId, deckId) || other.deckId == deckId)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.cardsReviewed, cardsReviewed) || other.cardsReviewed == cardsReviewed)&&(identical(other.againCount, againCount) || other.againCount == againCount)&&(identical(other.hardCount, hardCount) || other.hardCount == hardCount)&&(identical(other.goodCount, goodCount) || other.goodCount == goodCount)&&(identical(other.easyCount, easyCount) || other.easyCount == easyCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,deckId,startedAt,completedAt,cardsReviewed,againCount,hardCount,goodCount,easyCount);
}

@override
String toString() {
    return 'StudySession(id: $id, deckId: $deckId, startedAt: $startedAt, completedAt: $completedAt, cardsReviewed: $cardsReviewed, againCount: $againCount, hardCount: $hardCount, goodCount: $goodCount, easyCount: $easyCount)';
}


}

/// @nodoc
abstract mixin class _$StudySessionCopyWith<$Res> implements $StudySessionCopyWith<$Res> {
  factory _$StudySessionCopyWith(_StudySession value, $Res Function(_StudySession) _then) = __$StudySessionCopyWithImpl;
@override @useResult
$Res call({
 String id, String? deckId, DateTime startedAt, DateTime? completedAt, int cardsReviewed, int againCount, int hardCount, int goodCount, int easyCount
});




}
/// @nodoc
class __$StudySessionCopyWithImpl<$Res>
    implements _$StudySessionCopyWith<$Res> {
  __$StudySessionCopyWithImpl(this._self, this._then);

  final _StudySession _self;
  final $Res Function(_StudySession) _then;

/// Create a copy of StudySession
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? deckId = freezed,Object? startedAt = null,Object? completedAt = freezed,Object? cardsReviewed = null,Object? againCount = null,Object? hardCount = null,Object? goodCount = null,Object? easyCount = null,}) {
  return _then(_StudySession(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,deckId: freezed == deckId ? _self.deckId : deckId // ignore: cast_nullable_to_non_nullable
as String?,startedAt: null == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,cardsReviewed: null == cardsReviewed ? _self.cardsReviewed : cardsReviewed // ignore: cast_nullable_to_non_nullable
as int,againCount: null == againCount ? _self.againCount : againCount // ignore: cast_nullable_to_non_nullable
as int,hardCount: null == hardCount ? _self.hardCount : hardCount // ignore: cast_nullable_to_non_nullable
as int,goodCount: null == goodCount ? _self.goodCount : goodCount // ignore: cast_nullable_to_non_nullable
as int,easyCount: null == easyCount ? _self.easyCount : easyCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$ReviewResult {

 String get id; String get sessionId; String get cardId; RecallGrade get grade; DateTime get reviewedAt; int? get previousIntervalDays; int? get newIntervalDays; int? get elapsedMilliseconds;
/// Create a copy of ReviewResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReviewResultCopyWith<ReviewResult> get copyWith => _$ReviewResultCopyWithImpl<ReviewResult>(this as ReviewResult, _$identity);

  /// Serializes this ReviewResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ReviewResult;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReviewResult&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.sessionId, _this.sessionId) || other.sessionId == _this.sessionId)&&(identical(other.cardId, _this.cardId) || other.cardId == _this.cardId)&&(identical(other.grade, _this.grade) || other.grade == _this.grade)&&(identical(other.reviewedAt, _this.reviewedAt) || other.reviewedAt == _this.reviewedAt)&&(identical(other.previousIntervalDays, _this.previousIntervalDays) || other.previousIntervalDays == _this.previousIntervalDays)&&(identical(other.newIntervalDays, _this.newIntervalDays) || other.newIntervalDays == _this.newIntervalDays)&&(identical(other.elapsedMilliseconds, _this.elapsedMilliseconds) || other.elapsedMilliseconds == _this.elapsedMilliseconds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ReviewResult;
  return Object.hash(runtimeType,_this.id,_this.sessionId,_this.cardId,_this.grade,_this.reviewedAt,_this.previousIntervalDays,_this.newIntervalDays,_this.elapsedMilliseconds);
}

@override
String toString() {
  final _this = this as ReviewResult;
  return 'ReviewResult(id: ${_this.id}, sessionId: ${_this.sessionId}, cardId: ${_this.cardId}, grade: ${_this.grade}, reviewedAt: ${_this.reviewedAt}, previousIntervalDays: ${_this.previousIntervalDays}, newIntervalDays: ${_this.newIntervalDays}, elapsedMilliseconds: ${_this.elapsedMilliseconds})';
}


}

/// @nodoc
abstract mixin class $ReviewResultCopyWith<$Res>  {
  factory $ReviewResultCopyWith(ReviewResult value, $Res Function(ReviewResult) _then) = _$ReviewResultCopyWithImpl;
@useResult
$Res call({
 String id, String sessionId, String cardId, RecallGrade grade, DateTime reviewedAt, int? previousIntervalDays, int? newIntervalDays, int? elapsedMilliseconds
});




}
/// @nodoc
class _$ReviewResultCopyWithImpl<$Res>
    implements $ReviewResultCopyWith<$Res> {
  _$ReviewResultCopyWithImpl(this._self, this._then);

  final ReviewResult _self;
  final $Res Function(ReviewResult) _then;

/// Create a copy of ReviewResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? sessionId = null,Object? cardId = null,Object? grade = null,Object? reviewedAt = null,Object? previousIntervalDays = freezed,Object? newIntervalDays = freezed,Object? elapsedMilliseconds = freezed,}) {
  return _then(ReviewResult(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String,cardId: null == cardId ? _self.cardId : cardId // ignore: cast_nullable_to_non_nullable
as String,grade: null == grade ? _self.grade : grade // ignore: cast_nullable_to_non_nullable
as RecallGrade,reviewedAt: null == reviewedAt ? _self.reviewedAt : reviewedAt // ignore: cast_nullable_to_non_nullable
as DateTime,previousIntervalDays: freezed == previousIntervalDays ? _self.previousIntervalDays : previousIntervalDays // ignore: cast_nullable_to_non_nullable
as int?,newIntervalDays: freezed == newIntervalDays ? _self.newIntervalDays : newIntervalDays // ignore: cast_nullable_to_non_nullable
as int?,elapsedMilliseconds: freezed == elapsedMilliseconds ? _self.elapsedMilliseconds : elapsedMilliseconds // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [ReviewResult].
extension ReviewResultPatterns on ReviewResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReviewResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReviewResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReviewResult value)  $default,){
final _that = this;
switch (_that) {
case _ReviewResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReviewResult value)?  $default,){
final _that = this;
switch (_that) {
case _ReviewResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String sessionId,  String cardId,  RecallGrade grade,  DateTime reviewedAt,  int? previousIntervalDays,  int? newIntervalDays,  int? elapsedMilliseconds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReviewResult() when $default != null:
return $default(_that.id,_that.sessionId,_that.cardId,_that.grade,_that.reviewedAt,_that.previousIntervalDays,_that.newIntervalDays,_that.elapsedMilliseconds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String sessionId,  String cardId,  RecallGrade grade,  DateTime reviewedAt,  int? previousIntervalDays,  int? newIntervalDays,  int? elapsedMilliseconds)  $default,) {final _that = this;
switch (_that) {
case _ReviewResult():
return $default(_that.id,_that.sessionId,_that.cardId,_that.grade,_that.reviewedAt,_that.previousIntervalDays,_that.newIntervalDays,_that.elapsedMilliseconds);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String sessionId,  String cardId,  RecallGrade grade,  DateTime reviewedAt,  int? previousIntervalDays,  int? newIntervalDays,  int? elapsedMilliseconds)?  $default,) {final _that = this;
switch (_that) {
case _ReviewResult() when $default != null:
return $default(_that.id,_that.sessionId,_that.cardId,_that.grade,_that.reviewedAt,_that.previousIntervalDays,_that.newIntervalDays,_that.elapsedMilliseconds);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReviewResult implements ReviewResult {
  const _ReviewResult({required this.id, required this.sessionId, required this.cardId, required this.grade, required this.reviewedAt, this.previousIntervalDays, this.newIntervalDays, this.elapsedMilliseconds});
  factory _ReviewResult.fromJson(Map<String, dynamic> json) => _$ReviewResultFromJson(json);

@override final  String id;
@override final  String sessionId;
@override final  String cardId;
@override final  RecallGrade grade;
@override final  DateTime reviewedAt;
@override final  int? previousIntervalDays;
@override final  int? newIntervalDays;
@override final  int? elapsedMilliseconds;

/// Create a copy of ReviewResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReviewResultCopyWith<_ReviewResult> get copyWith => __$ReviewResultCopyWithImpl<_ReviewResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReviewResultToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReviewResult&&(identical(other.id, id) || other.id == id)&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.cardId, cardId) || other.cardId == cardId)&&(identical(other.grade, grade) || other.grade == grade)&&(identical(other.reviewedAt, reviewedAt) || other.reviewedAt == reviewedAt)&&(identical(other.previousIntervalDays, previousIntervalDays) || other.previousIntervalDays == previousIntervalDays)&&(identical(other.newIntervalDays, newIntervalDays) || other.newIntervalDays == newIntervalDays)&&(identical(other.elapsedMilliseconds, elapsedMilliseconds) || other.elapsedMilliseconds == elapsedMilliseconds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,sessionId,cardId,grade,reviewedAt,previousIntervalDays,newIntervalDays,elapsedMilliseconds);
}

@override
String toString() {
    return 'ReviewResult(id: $id, sessionId: $sessionId, cardId: $cardId, grade: $grade, reviewedAt: $reviewedAt, previousIntervalDays: $previousIntervalDays, newIntervalDays: $newIntervalDays, elapsedMilliseconds: $elapsedMilliseconds)';
}


}

/// @nodoc
abstract mixin class _$ReviewResultCopyWith<$Res> implements $ReviewResultCopyWith<$Res> {
  factory _$ReviewResultCopyWith(_ReviewResult value, $Res Function(_ReviewResult) _then) = __$ReviewResultCopyWithImpl;
@override @useResult
$Res call({
 String id, String sessionId, String cardId, RecallGrade grade, DateTime reviewedAt, int? previousIntervalDays, int? newIntervalDays, int? elapsedMilliseconds
});




}
/// @nodoc
class __$ReviewResultCopyWithImpl<$Res>
    implements _$ReviewResultCopyWith<$Res> {
  __$ReviewResultCopyWithImpl(this._self, this._then);

  final _ReviewResult _self;
  final $Res Function(_ReviewResult) _then;

/// Create a copy of ReviewResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? sessionId = null,Object? cardId = null,Object? grade = null,Object? reviewedAt = null,Object? previousIntervalDays = freezed,Object? newIntervalDays = freezed,Object? elapsedMilliseconds = freezed,}) {
  return _then(_ReviewResult(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String,cardId: null == cardId ? _self.cardId : cardId // ignore: cast_nullable_to_non_nullable
as String,grade: null == grade ? _self.grade : grade // ignore: cast_nullable_to_non_nullable
as RecallGrade,reviewedAt: null == reviewedAt ? _self.reviewedAt : reviewedAt // ignore: cast_nullable_to_non_nullable
as DateTime,previousIntervalDays: freezed == previousIntervalDays ? _self.previousIntervalDays : previousIntervalDays // ignore: cast_nullable_to_non_nullable
as int?,newIntervalDays: freezed == newIntervalDays ? _self.newIntervalDays : newIntervalDays // ignore: cast_nullable_to_non_nullable
as int?,elapsedMilliseconds: freezed == elapsedMilliseconds ? _self.elapsedMilliseconds : elapsedMilliseconds // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$DeckProgress {

 String get deckId; String get deckName; int get totalCards; int get reviewedCards;
/// Create a copy of DeckProgress
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeckProgressCopyWith<DeckProgress> get copyWith => _$DeckProgressCopyWithImpl<DeckProgress>(this as DeckProgress, _$identity);

  /// Serializes this DeckProgress to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as DeckProgress;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeckProgress&&(identical(other.deckId, _this.deckId) || other.deckId == _this.deckId)&&(identical(other.deckName, _this.deckName) || other.deckName == _this.deckName)&&(identical(other.totalCards, _this.totalCards) || other.totalCards == _this.totalCards)&&(identical(other.reviewedCards, _this.reviewedCards) || other.reviewedCards == _this.reviewedCards));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as DeckProgress;
  return Object.hash(runtimeType,_this.deckId,_this.deckName,_this.totalCards,_this.reviewedCards);
}

@override
String toString() {
  final _this = this as DeckProgress;
  return 'DeckProgress(deckId: ${_this.deckId}, deckName: ${_this.deckName}, totalCards: ${_this.totalCards}, reviewedCards: ${_this.reviewedCards})';
}


}

/// @nodoc
abstract mixin class $DeckProgressCopyWith<$Res>  {
  factory $DeckProgressCopyWith(DeckProgress value, $Res Function(DeckProgress) _then) = _$DeckProgressCopyWithImpl;
@useResult
$Res call({
 String deckId, String deckName, int totalCards, int reviewedCards
});




}
/// @nodoc
class _$DeckProgressCopyWithImpl<$Res>
    implements $DeckProgressCopyWith<$Res> {
  _$DeckProgressCopyWithImpl(this._self, this._then);

  final DeckProgress _self;
  final $Res Function(DeckProgress) _then;

/// Create a copy of DeckProgress
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? deckId = null,Object? deckName = null,Object? totalCards = null,Object? reviewedCards = null,}) {
  return _then(DeckProgress(
deckId: null == deckId ? _self.deckId : deckId // ignore: cast_nullable_to_non_nullable
as String,deckName: null == deckName ? _self.deckName : deckName // ignore: cast_nullable_to_non_nullable
as String,totalCards: null == totalCards ? _self.totalCards : totalCards // ignore: cast_nullable_to_non_nullable
as int,reviewedCards: null == reviewedCards ? _self.reviewedCards : reviewedCards // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [DeckProgress].
extension DeckProgressPatterns on DeckProgress {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DeckProgress value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DeckProgress() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DeckProgress value)  $default,){
final _that = this;
switch (_that) {
case _DeckProgress():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DeckProgress value)?  $default,){
final _that = this;
switch (_that) {
case _DeckProgress() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String deckId,  String deckName,  int totalCards,  int reviewedCards)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DeckProgress() when $default != null:
return $default(_that.deckId,_that.deckName,_that.totalCards,_that.reviewedCards);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String deckId,  String deckName,  int totalCards,  int reviewedCards)  $default,) {final _that = this;
switch (_that) {
case _DeckProgress():
return $default(_that.deckId,_that.deckName,_that.totalCards,_that.reviewedCards);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String deckId,  String deckName,  int totalCards,  int reviewedCards)?  $default,) {final _that = this;
switch (_that) {
case _DeckProgress() when $default != null:
return $default(_that.deckId,_that.deckName,_that.totalCards,_that.reviewedCards);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DeckProgress implements DeckProgress {
  const _DeckProgress({required this.deckId, required this.deckName, required this.totalCards, required this.reviewedCards});
  factory _DeckProgress.fromJson(Map<String, dynamic> json) => _$DeckProgressFromJson(json);

@override final  String deckId;
@override final  String deckName;
@override final  int totalCards;
@override final  int reviewedCards;

/// Create a copy of DeckProgress
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeckProgressCopyWith<_DeckProgress> get copyWith => __$DeckProgressCopyWithImpl<_DeckProgress>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DeckProgressToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeckProgress&&(identical(other.deckId, deckId) || other.deckId == deckId)&&(identical(other.deckName, deckName) || other.deckName == deckName)&&(identical(other.totalCards, totalCards) || other.totalCards == totalCards)&&(identical(other.reviewedCards, reviewedCards) || other.reviewedCards == reviewedCards));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,deckId,deckName,totalCards,reviewedCards);
}

@override
String toString() {
    return 'DeckProgress(deckId: $deckId, deckName: $deckName, totalCards: $totalCards, reviewedCards: $reviewedCards)';
}


}

/// @nodoc
abstract mixin class _$DeckProgressCopyWith<$Res> implements $DeckProgressCopyWith<$Res> {
  factory _$DeckProgressCopyWith(_DeckProgress value, $Res Function(_DeckProgress) _then) = __$DeckProgressCopyWithImpl;
@override @useResult
$Res call({
 String deckId, String deckName, int totalCards, int reviewedCards
});




}
/// @nodoc
class __$DeckProgressCopyWithImpl<$Res>
    implements _$DeckProgressCopyWith<$Res> {
  __$DeckProgressCopyWithImpl(this._self, this._then);

  final _DeckProgress _self;
  final $Res Function(_DeckProgress) _then;

/// Create a copy of DeckProgress
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? deckId = null,Object? deckName = null,Object? totalCards = null,Object? reviewedCards = null,}) {
  return _then(_DeckProgress(
deckId: null == deckId ? _self.deckId : deckId // ignore: cast_nullable_to_non_nullable
as String,deckName: null == deckName ? _self.deckName : deckName // ignore: cast_nullable_to_non_nullable
as String,totalCards: null == totalCards ? _self.totalCards : totalCards // ignore: cast_nullable_to_non_nullable
as int,reviewedCards: null == reviewedCards ? _self.reviewedCards : reviewedCards // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$DashboardSnapshot {

 int get cardsDue; int get cardsStudiedToday; int get streak; List<DeckProgress> get decks;
/// Create a copy of DashboardSnapshot
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DashboardSnapshotCopyWith<DashboardSnapshot> get copyWith => _$DashboardSnapshotCopyWithImpl<DashboardSnapshot>(this as DashboardSnapshot, _$identity);

  /// Serializes this DashboardSnapshot to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as DashboardSnapshot;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DashboardSnapshot&&(identical(other.cardsDue, _this.cardsDue) || other.cardsDue == _this.cardsDue)&&(identical(other.cardsStudiedToday, _this.cardsStudiedToday) || other.cardsStudiedToday == _this.cardsStudiedToday)&&(identical(other.streak, _this.streak) || other.streak == _this.streak)&&const DeepCollectionEquality().equals(other.decks, _this.decks));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as DashboardSnapshot;
  return Object.hash(runtimeType,_this.cardsDue,_this.cardsStudiedToday,_this.streak,const DeepCollectionEquality().hash(_this.decks));
}

@override
String toString() {
  final _this = this as DashboardSnapshot;
  return 'DashboardSnapshot(cardsDue: ${_this.cardsDue}, cardsStudiedToday: ${_this.cardsStudiedToday}, streak: ${_this.streak}, decks: ${_this.decks})';
}


}

/// @nodoc
abstract mixin class $DashboardSnapshotCopyWith<$Res>  {
  factory $DashboardSnapshotCopyWith(DashboardSnapshot value, $Res Function(DashboardSnapshot) _then) = _$DashboardSnapshotCopyWithImpl;
@useResult
$Res call({
 int cardsDue, int cardsStudiedToday, int streak, List<DeckProgress> decks
});




}
/// @nodoc
class _$DashboardSnapshotCopyWithImpl<$Res>
    implements $DashboardSnapshotCopyWith<$Res> {
  _$DashboardSnapshotCopyWithImpl(this._self, this._then);

  final DashboardSnapshot _self;
  final $Res Function(DashboardSnapshot) _then;

/// Create a copy of DashboardSnapshot
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? cardsDue = null,Object? cardsStudiedToday = null,Object? streak = null,Object? decks = null,}) {
  return _then(DashboardSnapshot(
cardsDue: null == cardsDue ? _self.cardsDue : cardsDue // ignore: cast_nullable_to_non_nullable
as int,cardsStudiedToday: null == cardsStudiedToday ? _self.cardsStudiedToday : cardsStudiedToday // ignore: cast_nullable_to_non_nullable
as int,streak: null == streak ? _self.streak : streak // ignore: cast_nullable_to_non_nullable
as int,decks: null == decks ? _self.decks : decks // ignore: cast_nullable_to_non_nullable
as List<DeckProgress>,
  ));
}

}


/// Adds pattern-matching-related methods to [DashboardSnapshot].
extension DashboardSnapshotPatterns on DashboardSnapshot {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DashboardSnapshot value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DashboardSnapshot() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DashboardSnapshot value)  $default,){
final _that = this;
switch (_that) {
case _DashboardSnapshot():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DashboardSnapshot value)?  $default,){
final _that = this;
switch (_that) {
case _DashboardSnapshot() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int cardsDue,  int cardsStudiedToday,  int streak,  List<DeckProgress> decks)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DashboardSnapshot() when $default != null:
return $default(_that.cardsDue,_that.cardsStudiedToday,_that.streak,_that.decks);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int cardsDue,  int cardsStudiedToday,  int streak,  List<DeckProgress> decks)  $default,) {final _that = this;
switch (_that) {
case _DashboardSnapshot():
return $default(_that.cardsDue,_that.cardsStudiedToday,_that.streak,_that.decks);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int cardsDue,  int cardsStudiedToday,  int streak,  List<DeckProgress> decks)?  $default,) {final _that = this;
switch (_that) {
case _DashboardSnapshot() when $default != null:
return $default(_that.cardsDue,_that.cardsStudiedToday,_that.streak,_that.decks);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DashboardSnapshot implements DashboardSnapshot {
  const _DashboardSnapshot({required this.cardsDue, required this.cardsStudiedToday, required this.streak, required  List<DeckProgress> decks}): _decks = decks;
  factory _DashboardSnapshot.fromJson(Map<String, dynamic> json) => _$DashboardSnapshotFromJson(json);

@override final  int cardsDue;
@override final  int cardsStudiedToday;
@override final  int streak;
 final  List<DeckProgress> _decks;
@override List<DeckProgress> get decks {
  if (_decks is EqualUnmodifiableListView) return _decks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_decks);
}


/// Create a copy of DashboardSnapshot
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DashboardSnapshotCopyWith<_DashboardSnapshot> get copyWith => __$DashboardSnapshotCopyWithImpl<_DashboardSnapshot>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DashboardSnapshotToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DashboardSnapshot&&(identical(other.cardsDue, cardsDue) || other.cardsDue == cardsDue)&&(identical(other.cardsStudiedToday, cardsStudiedToday) || other.cardsStudiedToday == cardsStudiedToday)&&(identical(other.streak, streak) || other.streak == streak)&&const DeepCollectionEquality().equals(other.decks, _decks));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,cardsDue,cardsStudiedToday,streak,const DeepCollectionEquality().hash(_decks));
}

@override
String toString() {
    return 'DashboardSnapshot(cardsDue: $cardsDue, cardsStudiedToday: $cardsStudiedToday, streak: $streak, decks: $decks)';
}


}

/// @nodoc
abstract mixin class _$DashboardSnapshotCopyWith<$Res> implements $DashboardSnapshotCopyWith<$Res> {
  factory _$DashboardSnapshotCopyWith(_DashboardSnapshot value, $Res Function(_DashboardSnapshot) _then) = __$DashboardSnapshotCopyWithImpl;
@override @useResult
$Res call({
 int cardsDue, int cardsStudiedToday, int streak, List<DeckProgress> decks
});




}
/// @nodoc
class __$DashboardSnapshotCopyWithImpl<$Res>
    implements _$DashboardSnapshotCopyWith<$Res> {
  __$DashboardSnapshotCopyWithImpl(this._self, this._then);

  final _DashboardSnapshot _self;
  final $Res Function(_DashboardSnapshot) _then;

/// Create a copy of DashboardSnapshot
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? cardsDue = null,Object? cardsStudiedToday = null,Object? streak = null,Object? decks = null,}) {
  return _then(_DashboardSnapshot(
cardsDue: null == cardsDue ? _self.cardsDue : cardsDue // ignore: cast_nullable_to_non_nullable
as int,cardsStudiedToday: null == cardsStudiedToday ? _self.cardsStudiedToday : cardsStudiedToday // ignore: cast_nullable_to_non_nullable
as int,streak: null == streak ? _self.streak : streak // ignore: cast_nullable_to_non_nullable
as int,decks: null == decks ? _self._decks : decks // ignore: cast_nullable_to_non_nullable
as List<DeckProgress>,
  ));
}


}

// dart format on
