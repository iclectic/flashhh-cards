// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ai_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DocumentImport {

 String get id; String get fileName; int get byteSize; String? get contentHash; int? get pageCount; int? get textCharacterCount; DocumentImportStatus get status; String? get errorMessage; DateTime get createdAt; DateTime get updatedAt; DateTime? get discardedAt;
/// Create a copy of DocumentImport
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DocumentImportCopyWith<DocumentImport> get copyWith => _$DocumentImportCopyWithImpl<DocumentImport>(this as DocumentImport, _$identity);

  /// Serializes this DocumentImport to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as DocumentImport;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DocumentImport&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.fileName, _this.fileName) || other.fileName == _this.fileName)&&(identical(other.byteSize, _this.byteSize) || other.byteSize == _this.byteSize)&&(identical(other.contentHash, _this.contentHash) || other.contentHash == _this.contentHash)&&(identical(other.pageCount, _this.pageCount) || other.pageCount == _this.pageCount)&&(identical(other.textCharacterCount, _this.textCharacterCount) || other.textCharacterCount == _this.textCharacterCount)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.errorMessage, _this.errorMessage) || other.errorMessage == _this.errorMessage)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt)&&(identical(other.discardedAt, _this.discardedAt) || other.discardedAt == _this.discardedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as DocumentImport;
  return Object.hash(runtimeType,_this.id,_this.fileName,_this.byteSize,_this.contentHash,_this.pageCount,_this.textCharacterCount,_this.status,_this.errorMessage,_this.createdAt,_this.updatedAt,_this.discardedAt);
}

@override
String toString() {
  final _this = this as DocumentImport;
  return 'DocumentImport(id: ${_this.id}, fileName: ${_this.fileName}, byteSize: ${_this.byteSize}, contentHash: ${_this.contentHash}, pageCount: ${_this.pageCount}, textCharacterCount: ${_this.textCharacterCount}, status: ${_this.status}, errorMessage: ${_this.errorMessage}, createdAt: ${_this.createdAt}, updatedAt: ${_this.updatedAt}, discardedAt: ${_this.discardedAt})';
}


}

/// @nodoc
abstract mixin class $DocumentImportCopyWith<$Res>  {
  factory $DocumentImportCopyWith(DocumentImport value, $Res Function(DocumentImport) _then) = _$DocumentImportCopyWithImpl;
@useResult
$Res call({
 String id, String fileName, int byteSize, String? contentHash, int? pageCount, int? textCharacterCount, DocumentImportStatus status, String? errorMessage, DateTime createdAt, DateTime updatedAt, DateTime? discardedAt
});




}
/// @nodoc
class _$DocumentImportCopyWithImpl<$Res>
    implements $DocumentImportCopyWith<$Res> {
  _$DocumentImportCopyWithImpl(this._self, this._then);

  final DocumentImport _self;
  final $Res Function(DocumentImport) _then;

/// Create a copy of DocumentImport
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? fileName = null,Object? byteSize = null,Object? contentHash = freezed,Object? pageCount = freezed,Object? textCharacterCount = freezed,Object? status = null,Object? errorMessage = freezed,Object? createdAt = null,Object? updatedAt = null,Object? discardedAt = freezed,}) {
  return _then(DocumentImport(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,fileName: null == fileName ? _self.fileName : fileName // ignore: cast_nullable_to_non_nullable
as String,byteSize: null == byteSize ? _self.byteSize : byteSize // ignore: cast_nullable_to_non_nullable
as int,contentHash: freezed == contentHash ? _self.contentHash : contentHash // ignore: cast_nullable_to_non_nullable
as String?,pageCount: freezed == pageCount ? _self.pageCount : pageCount // ignore: cast_nullable_to_non_nullable
as int?,textCharacterCount: freezed == textCharacterCount ? _self.textCharacterCount : textCharacterCount // ignore: cast_nullable_to_non_nullable
as int?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as DocumentImportStatus,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,discardedAt: freezed == discardedAt ? _self.discardedAt : discardedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [DocumentImport].
extension DocumentImportPatterns on DocumentImport {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DocumentImport value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DocumentImport() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DocumentImport value)  $default,){
final _that = this;
switch (_that) {
case _DocumentImport():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DocumentImport value)?  $default,){
final _that = this;
switch (_that) {
case _DocumentImport() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String fileName,  int byteSize,  String? contentHash,  int? pageCount,  int? textCharacterCount,  DocumentImportStatus status,  String? errorMessage,  DateTime createdAt,  DateTime updatedAt,  DateTime? discardedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DocumentImport() when $default != null:
return $default(_that.id,_that.fileName,_that.byteSize,_that.contentHash,_that.pageCount,_that.textCharacterCount,_that.status,_that.errorMessage,_that.createdAt,_that.updatedAt,_that.discardedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String fileName,  int byteSize,  String? contentHash,  int? pageCount,  int? textCharacterCount,  DocumentImportStatus status,  String? errorMessage,  DateTime createdAt,  DateTime updatedAt,  DateTime? discardedAt)  $default,) {final _that = this;
switch (_that) {
case _DocumentImport():
return $default(_that.id,_that.fileName,_that.byteSize,_that.contentHash,_that.pageCount,_that.textCharacterCount,_that.status,_that.errorMessage,_that.createdAt,_that.updatedAt,_that.discardedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String fileName,  int byteSize,  String? contentHash,  int? pageCount,  int? textCharacterCount,  DocumentImportStatus status,  String? errorMessage,  DateTime createdAt,  DateTime updatedAt,  DateTime? discardedAt)?  $default,) {final _that = this;
switch (_that) {
case _DocumentImport() when $default != null:
return $default(_that.id,_that.fileName,_that.byteSize,_that.contentHash,_that.pageCount,_that.textCharacterCount,_that.status,_that.errorMessage,_that.createdAt,_that.updatedAt,_that.discardedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DocumentImport implements DocumentImport {
  const _DocumentImport({required this.id, required this.fileName, required this.byteSize, this.contentHash, this.pageCount, this.textCharacterCount, required this.status, this.errorMessage, required this.createdAt, required this.updatedAt, this.discardedAt});
  factory _DocumentImport.fromJson(Map<String, dynamic> json) => _$DocumentImportFromJson(json);

@override final  String id;
@override final  String fileName;
@override final  int byteSize;
@override final  String? contentHash;
@override final  int? pageCount;
@override final  int? textCharacterCount;
@override final  DocumentImportStatus status;
@override final  String? errorMessage;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
@override final  DateTime? discardedAt;

/// Create a copy of DocumentImport
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DocumentImportCopyWith<_DocumentImport> get copyWith => __$DocumentImportCopyWithImpl<_DocumentImport>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DocumentImportToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DocumentImport&&(identical(other.id, id) || other.id == id)&&(identical(other.fileName, fileName) || other.fileName == fileName)&&(identical(other.byteSize, byteSize) || other.byteSize == byteSize)&&(identical(other.contentHash, contentHash) || other.contentHash == contentHash)&&(identical(other.pageCount, pageCount) || other.pageCount == pageCount)&&(identical(other.textCharacterCount, textCharacterCount) || other.textCharacterCount == textCharacterCount)&&(identical(other.status, status) || other.status == status)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.discardedAt, discardedAt) || other.discardedAt == discardedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,fileName,byteSize,contentHash,pageCount,textCharacterCount,status,errorMessage,createdAt,updatedAt,discardedAt);
}

@override
String toString() {
    return 'DocumentImport(id: $id, fileName: $fileName, byteSize: $byteSize, contentHash: $contentHash, pageCount: $pageCount, textCharacterCount: $textCharacterCount, status: $status, errorMessage: $errorMessage, createdAt: $createdAt, updatedAt: $updatedAt, discardedAt: $discardedAt)';
}


}

/// @nodoc
abstract mixin class _$DocumentImportCopyWith<$Res> implements $DocumentImportCopyWith<$Res> {
  factory _$DocumentImportCopyWith(_DocumentImport value, $Res Function(_DocumentImport) _then) = __$DocumentImportCopyWithImpl;
@override @useResult
$Res call({
 String id, String fileName, int byteSize, String? contentHash, int? pageCount, int? textCharacterCount, DocumentImportStatus status, String? errorMessage, DateTime createdAt, DateTime updatedAt, DateTime? discardedAt
});




}
/// @nodoc
class __$DocumentImportCopyWithImpl<$Res>
    implements _$DocumentImportCopyWith<$Res> {
  __$DocumentImportCopyWithImpl(this._self, this._then);

  final _DocumentImport _self;
  final $Res Function(_DocumentImport) _then;

/// Create a copy of DocumentImport
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? fileName = null,Object? byteSize = null,Object? contentHash = freezed,Object? pageCount = freezed,Object? textCharacterCount = freezed,Object? status = null,Object? errorMessage = freezed,Object? createdAt = null,Object? updatedAt = null,Object? discardedAt = freezed,}) {
  return _then(_DocumentImport(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,fileName: null == fileName ? _self.fileName : fileName // ignore: cast_nullable_to_non_nullable
as String,byteSize: null == byteSize ? _self.byteSize : byteSize // ignore: cast_nullable_to_non_nullable
as int,contentHash: freezed == contentHash ? _self.contentHash : contentHash // ignore: cast_nullable_to_non_nullable
as String?,pageCount: freezed == pageCount ? _self.pageCount : pageCount // ignore: cast_nullable_to_non_nullable
as int?,textCharacterCount: freezed == textCharacterCount ? _self.textCharacterCount : textCharacterCount // ignore: cast_nullable_to_non_nullable
as int?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as DocumentImportStatus,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,discardedAt: freezed == discardedAt ? _self.discardedAt : discardedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$GenerationUsageRecord {

 String get id; String? get documentImportId; DateTime get createdAt; GenerationStatus get status; int? get documentBytes; int? get promptTokens; int? get completionTokens; int? get cardCount; double? get estimatedCostUsd; String? get failureCode;
/// Create a copy of GenerationUsageRecord
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GenerationUsageRecordCopyWith<GenerationUsageRecord> get copyWith => _$GenerationUsageRecordCopyWithImpl<GenerationUsageRecord>(this as GenerationUsageRecord, _$identity);

  /// Serializes this GenerationUsageRecord to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as GenerationUsageRecord;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GenerationUsageRecord&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.documentImportId, _this.documentImportId) || other.documentImportId == _this.documentImportId)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.documentBytes, _this.documentBytes) || other.documentBytes == _this.documentBytes)&&(identical(other.promptTokens, _this.promptTokens) || other.promptTokens == _this.promptTokens)&&(identical(other.completionTokens, _this.completionTokens) || other.completionTokens == _this.completionTokens)&&(identical(other.cardCount, _this.cardCount) || other.cardCount == _this.cardCount)&&(identical(other.estimatedCostUsd, _this.estimatedCostUsd) || other.estimatedCostUsd == _this.estimatedCostUsd)&&(identical(other.failureCode, _this.failureCode) || other.failureCode == _this.failureCode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as GenerationUsageRecord;
  return Object.hash(runtimeType,_this.id,_this.documentImportId,_this.createdAt,_this.status,_this.documentBytes,_this.promptTokens,_this.completionTokens,_this.cardCount,_this.estimatedCostUsd,_this.failureCode);
}

@override
String toString() {
  final _this = this as GenerationUsageRecord;
  return 'GenerationUsageRecord(id: ${_this.id}, documentImportId: ${_this.documentImportId}, createdAt: ${_this.createdAt}, status: ${_this.status}, documentBytes: ${_this.documentBytes}, promptTokens: ${_this.promptTokens}, completionTokens: ${_this.completionTokens}, cardCount: ${_this.cardCount}, estimatedCostUsd: ${_this.estimatedCostUsd}, failureCode: ${_this.failureCode})';
}


}

/// @nodoc
abstract mixin class $GenerationUsageRecordCopyWith<$Res>  {
  factory $GenerationUsageRecordCopyWith(GenerationUsageRecord value, $Res Function(GenerationUsageRecord) _then) = _$GenerationUsageRecordCopyWithImpl;
@useResult
$Res call({
 String id, String? documentImportId, DateTime createdAt, GenerationStatus status, int? documentBytes, int? promptTokens, int? completionTokens, int? cardCount, double? estimatedCostUsd, String? failureCode
});




}
/// @nodoc
class _$GenerationUsageRecordCopyWithImpl<$Res>
    implements $GenerationUsageRecordCopyWith<$Res> {
  _$GenerationUsageRecordCopyWithImpl(this._self, this._then);

  final GenerationUsageRecord _self;
  final $Res Function(GenerationUsageRecord) _then;

/// Create a copy of GenerationUsageRecord
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? documentImportId = freezed,Object? createdAt = null,Object? status = null,Object? documentBytes = freezed,Object? promptTokens = freezed,Object? completionTokens = freezed,Object? cardCount = freezed,Object? estimatedCostUsd = freezed,Object? failureCode = freezed,}) {
  return _then(GenerationUsageRecord(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,documentImportId: freezed == documentImportId ? _self.documentImportId : documentImportId // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as GenerationStatus,documentBytes: freezed == documentBytes ? _self.documentBytes : documentBytes // ignore: cast_nullable_to_non_nullable
as int?,promptTokens: freezed == promptTokens ? _self.promptTokens : promptTokens // ignore: cast_nullable_to_non_nullable
as int?,completionTokens: freezed == completionTokens ? _self.completionTokens : completionTokens // ignore: cast_nullable_to_non_nullable
as int?,cardCount: freezed == cardCount ? _self.cardCount : cardCount // ignore: cast_nullable_to_non_nullable
as int?,estimatedCostUsd: freezed == estimatedCostUsd ? _self.estimatedCostUsd : estimatedCostUsd // ignore: cast_nullable_to_non_nullable
as double?,failureCode: freezed == failureCode ? _self.failureCode : failureCode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [GenerationUsageRecord].
extension GenerationUsageRecordPatterns on GenerationUsageRecord {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GenerationUsageRecord value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GenerationUsageRecord() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GenerationUsageRecord value)  $default,){
final _that = this;
switch (_that) {
case _GenerationUsageRecord():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GenerationUsageRecord value)?  $default,){
final _that = this;
switch (_that) {
case _GenerationUsageRecord() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String? documentImportId,  DateTime createdAt,  GenerationStatus status,  int? documentBytes,  int? promptTokens,  int? completionTokens,  int? cardCount,  double? estimatedCostUsd,  String? failureCode)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GenerationUsageRecord() when $default != null:
return $default(_that.id,_that.documentImportId,_that.createdAt,_that.status,_that.documentBytes,_that.promptTokens,_that.completionTokens,_that.cardCount,_that.estimatedCostUsd,_that.failureCode);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String? documentImportId,  DateTime createdAt,  GenerationStatus status,  int? documentBytes,  int? promptTokens,  int? completionTokens,  int? cardCount,  double? estimatedCostUsd,  String? failureCode)  $default,) {final _that = this;
switch (_that) {
case _GenerationUsageRecord():
return $default(_that.id,_that.documentImportId,_that.createdAt,_that.status,_that.documentBytes,_that.promptTokens,_that.completionTokens,_that.cardCount,_that.estimatedCostUsd,_that.failureCode);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String? documentImportId,  DateTime createdAt,  GenerationStatus status,  int? documentBytes,  int? promptTokens,  int? completionTokens,  int? cardCount,  double? estimatedCostUsd,  String? failureCode)?  $default,) {final _that = this;
switch (_that) {
case _GenerationUsageRecord() when $default != null:
return $default(_that.id,_that.documentImportId,_that.createdAt,_that.status,_that.documentBytes,_that.promptTokens,_that.completionTokens,_that.cardCount,_that.estimatedCostUsd,_that.failureCode);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GenerationUsageRecord implements GenerationUsageRecord {
  const _GenerationUsageRecord({required this.id, this.documentImportId, required this.createdAt, required this.status, this.documentBytes, this.promptTokens, this.completionTokens, this.cardCount, this.estimatedCostUsd, this.failureCode});
  factory _GenerationUsageRecord.fromJson(Map<String, dynamic> json) => _$GenerationUsageRecordFromJson(json);

@override final  String id;
@override final  String? documentImportId;
@override final  DateTime createdAt;
@override final  GenerationStatus status;
@override final  int? documentBytes;
@override final  int? promptTokens;
@override final  int? completionTokens;
@override final  int? cardCount;
@override final  double? estimatedCostUsd;
@override final  String? failureCode;

/// Create a copy of GenerationUsageRecord
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GenerationUsageRecordCopyWith<_GenerationUsageRecord> get copyWith => __$GenerationUsageRecordCopyWithImpl<_GenerationUsageRecord>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GenerationUsageRecordToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _GenerationUsageRecord&&(identical(other.id, id) || other.id == id)&&(identical(other.documentImportId, documentImportId) || other.documentImportId == documentImportId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.status, status) || other.status == status)&&(identical(other.documentBytes, documentBytes) || other.documentBytes == documentBytes)&&(identical(other.promptTokens, promptTokens) || other.promptTokens == promptTokens)&&(identical(other.completionTokens, completionTokens) || other.completionTokens == completionTokens)&&(identical(other.cardCount, cardCount) || other.cardCount == cardCount)&&(identical(other.estimatedCostUsd, estimatedCostUsd) || other.estimatedCostUsd == estimatedCostUsd)&&(identical(other.failureCode, failureCode) || other.failureCode == failureCode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,documentImportId,createdAt,status,documentBytes,promptTokens,completionTokens,cardCount,estimatedCostUsd,failureCode);
}

@override
String toString() {
    return 'GenerationUsageRecord(id: $id, documentImportId: $documentImportId, createdAt: $createdAt, status: $status, documentBytes: $documentBytes, promptTokens: $promptTokens, completionTokens: $completionTokens, cardCount: $cardCount, estimatedCostUsd: $estimatedCostUsd, failureCode: $failureCode)';
}


}

/// @nodoc
abstract mixin class _$GenerationUsageRecordCopyWith<$Res> implements $GenerationUsageRecordCopyWith<$Res> {
  factory _$GenerationUsageRecordCopyWith(_GenerationUsageRecord value, $Res Function(_GenerationUsageRecord) _then) = __$GenerationUsageRecordCopyWithImpl;
@override @useResult
$Res call({
 String id, String? documentImportId, DateTime createdAt, GenerationStatus status, int? documentBytes, int? promptTokens, int? completionTokens, int? cardCount, double? estimatedCostUsd, String? failureCode
});




}
/// @nodoc
class __$GenerationUsageRecordCopyWithImpl<$Res>
    implements _$GenerationUsageRecordCopyWith<$Res> {
  __$GenerationUsageRecordCopyWithImpl(this._self, this._then);

  final _GenerationUsageRecord _self;
  final $Res Function(_GenerationUsageRecord) _then;

/// Create a copy of GenerationUsageRecord
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? documentImportId = freezed,Object? createdAt = null,Object? status = null,Object? documentBytes = freezed,Object? promptTokens = freezed,Object? completionTokens = freezed,Object? cardCount = freezed,Object? estimatedCostUsd = freezed,Object? failureCode = freezed,}) {
  return _then(_GenerationUsageRecord(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,documentImportId: freezed == documentImportId ? _self.documentImportId : documentImportId // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as GenerationStatus,documentBytes: freezed == documentBytes ? _self.documentBytes : documentBytes // ignore: cast_nullable_to_non_nullable
as int?,promptTokens: freezed == promptTokens ? _self.promptTokens : promptTokens // ignore: cast_nullable_to_non_nullable
as int?,completionTokens: freezed == completionTokens ? _self.completionTokens : completionTokens // ignore: cast_nullable_to_non_nullable
as int?,cardCount: freezed == cardCount ? _self.cardCount : cardCount // ignore: cast_nullable_to_non_nullable
as int?,estimatedCostUsd: freezed == estimatedCostUsd ? _self.estimatedCostUsd : estimatedCostUsd // ignore: cast_nullable_to_non_nullable
as double?,failureCode: freezed == failureCode ? _self.failureCode : failureCode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
