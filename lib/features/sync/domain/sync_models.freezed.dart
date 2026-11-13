// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sync_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SyncOutboxEntry {

 String get id; SyncEntityType get entityType; String get entityId; SyncOperation get operation; String? get payloadJson; DateTime get createdAt; int get attemptCount; String? get lastError; DateTime? get processedAt;
/// Create a copy of SyncOutboxEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SyncOutboxEntryCopyWith<SyncOutboxEntry> get copyWith => _$SyncOutboxEntryCopyWithImpl<SyncOutboxEntry>(this as SyncOutboxEntry, _$identity);

  /// Serializes this SyncOutboxEntry to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SyncOutboxEntry;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SyncOutboxEntry&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.entityType, _this.entityType) || other.entityType == _this.entityType)&&(identical(other.entityId, _this.entityId) || other.entityId == _this.entityId)&&(identical(other.operation, _this.operation) || other.operation == _this.operation)&&(identical(other.payloadJson, _this.payloadJson) || other.payloadJson == _this.payloadJson)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.attemptCount, _this.attemptCount) || other.attemptCount == _this.attemptCount)&&(identical(other.lastError, _this.lastError) || other.lastError == _this.lastError)&&(identical(other.processedAt, _this.processedAt) || other.processedAt == _this.processedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SyncOutboxEntry;
  return Object.hash(runtimeType,_this.id,_this.entityType,_this.entityId,_this.operation,_this.payloadJson,_this.createdAt,_this.attemptCount,_this.lastError,_this.processedAt);
}

@override
String toString() {
  final _this = this as SyncOutboxEntry;
  return 'SyncOutboxEntry(id: ${_this.id}, entityType: ${_this.entityType}, entityId: ${_this.entityId}, operation: ${_this.operation}, payloadJson: ${_this.payloadJson}, createdAt: ${_this.createdAt}, attemptCount: ${_this.attemptCount}, lastError: ${_this.lastError}, processedAt: ${_this.processedAt})';
}


}

/// @nodoc
abstract mixin class $SyncOutboxEntryCopyWith<$Res>  {
  factory $SyncOutboxEntryCopyWith(SyncOutboxEntry value, $Res Function(SyncOutboxEntry) _then) = _$SyncOutboxEntryCopyWithImpl;
@useResult
$Res call({
 String id, SyncEntityType entityType, String entityId, SyncOperation operation, String? payloadJson, DateTime createdAt, int attemptCount, String? lastError, DateTime? processedAt
});




}
/// @nodoc
class _$SyncOutboxEntryCopyWithImpl<$Res>
    implements $SyncOutboxEntryCopyWith<$Res> {
  _$SyncOutboxEntryCopyWithImpl(this._self, this._then);

  final SyncOutboxEntry _self;
  final $Res Function(SyncOutboxEntry) _then;

/// Create a copy of SyncOutboxEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? entityType = null,Object? entityId = null,Object? operation = null,Object? payloadJson = freezed,Object? createdAt = null,Object? attemptCount = null,Object? lastError = freezed,Object? processedAt = freezed,}) {
  return _then(SyncOutboxEntry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,entityType: null == entityType ? _self.entityType : entityType // ignore: cast_nullable_to_non_nullable
as SyncEntityType,entityId: null == entityId ? _self.entityId : entityId // ignore: cast_nullable_to_non_nullable
as String,operation: null == operation ? _self.operation : operation // ignore: cast_nullable_to_non_nullable
as SyncOperation,payloadJson: freezed == payloadJson ? _self.payloadJson : payloadJson // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,attemptCount: null == attemptCount ? _self.attemptCount : attemptCount // ignore: cast_nullable_to_non_nullable
as int,lastError: freezed == lastError ? _self.lastError : lastError // ignore: cast_nullable_to_non_nullable
as String?,processedAt: freezed == processedAt ? _self.processedAt : processedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [SyncOutboxEntry].
extension SyncOutboxEntryPatterns on SyncOutboxEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SyncOutboxEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SyncOutboxEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SyncOutboxEntry value)  $default,){
final _that = this;
switch (_that) {
case _SyncOutboxEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SyncOutboxEntry value)?  $default,){
final _that = this;
switch (_that) {
case _SyncOutboxEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  SyncEntityType entityType,  String entityId,  SyncOperation operation,  String? payloadJson,  DateTime createdAt,  int attemptCount,  String? lastError,  DateTime? processedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SyncOutboxEntry() when $default != null:
return $default(_that.id,_that.entityType,_that.entityId,_that.operation,_that.payloadJson,_that.createdAt,_that.attemptCount,_that.lastError,_that.processedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  SyncEntityType entityType,  String entityId,  SyncOperation operation,  String? payloadJson,  DateTime createdAt,  int attemptCount,  String? lastError,  DateTime? processedAt)  $default,) {final _that = this;
switch (_that) {
case _SyncOutboxEntry():
return $default(_that.id,_that.entityType,_that.entityId,_that.operation,_that.payloadJson,_that.createdAt,_that.attemptCount,_that.lastError,_that.processedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  SyncEntityType entityType,  String entityId,  SyncOperation operation,  String? payloadJson,  DateTime createdAt,  int attemptCount,  String? lastError,  DateTime? processedAt)?  $default,) {final _that = this;
switch (_that) {
case _SyncOutboxEntry() when $default != null:
return $default(_that.id,_that.entityType,_that.entityId,_that.operation,_that.payloadJson,_that.createdAt,_that.attemptCount,_that.lastError,_that.processedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SyncOutboxEntry implements SyncOutboxEntry {
  const _SyncOutboxEntry({required this.id, required this.entityType, required this.entityId, required this.operation, this.payloadJson, required this.createdAt, this.attemptCount = 0, this.lastError, this.processedAt});
  factory _SyncOutboxEntry.fromJson(Map<String, dynamic> json) => _$SyncOutboxEntryFromJson(json);

@override final  String id;
@override final  SyncEntityType entityType;
@override final  String entityId;
@override final  SyncOperation operation;
@override final  String? payloadJson;
@override final  DateTime createdAt;
@override@JsonKey() final  int attemptCount;
@override final  String? lastError;
@override final  DateTime? processedAt;

/// Create a copy of SyncOutboxEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SyncOutboxEntryCopyWith<_SyncOutboxEntry> get copyWith => __$SyncOutboxEntryCopyWithImpl<_SyncOutboxEntry>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SyncOutboxEntryToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SyncOutboxEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.entityType, entityType) || other.entityType == entityType)&&(identical(other.entityId, entityId) || other.entityId == entityId)&&(identical(other.operation, operation) || other.operation == operation)&&(identical(other.payloadJson, payloadJson) || other.payloadJson == payloadJson)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.attemptCount, attemptCount) || other.attemptCount == attemptCount)&&(identical(other.lastError, lastError) || other.lastError == lastError)&&(identical(other.processedAt, processedAt) || other.processedAt == processedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,entityType,entityId,operation,payloadJson,createdAt,attemptCount,lastError,processedAt);
}

@override
String toString() {
    return 'SyncOutboxEntry(id: $id, entityType: $entityType, entityId: $entityId, operation: $operation, payloadJson: $payloadJson, createdAt: $createdAt, attemptCount: $attemptCount, lastError: $lastError, processedAt: $processedAt)';
}


}

/// @nodoc
abstract mixin class _$SyncOutboxEntryCopyWith<$Res> implements $SyncOutboxEntryCopyWith<$Res> {
  factory _$SyncOutboxEntryCopyWith(_SyncOutboxEntry value, $Res Function(_SyncOutboxEntry) _then) = __$SyncOutboxEntryCopyWithImpl;
@override @useResult
$Res call({
 String id, SyncEntityType entityType, String entityId, SyncOperation operation, String? payloadJson, DateTime createdAt, int attemptCount, String? lastError, DateTime? processedAt
});




}
/// @nodoc
class __$SyncOutboxEntryCopyWithImpl<$Res>
    implements _$SyncOutboxEntryCopyWith<$Res> {
  __$SyncOutboxEntryCopyWithImpl(this._self, this._then);

  final _SyncOutboxEntry _self;
  final $Res Function(_SyncOutboxEntry) _then;

/// Create a copy of SyncOutboxEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? entityType = null,Object? entityId = null,Object? operation = null,Object? payloadJson = freezed,Object? createdAt = null,Object? attemptCount = null,Object? lastError = freezed,Object? processedAt = freezed,}) {
  return _then(_SyncOutboxEntry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,entityType: null == entityType ? _self.entityType : entityType // ignore: cast_nullable_to_non_nullable
as SyncEntityType,entityId: null == entityId ? _self.entityId : entityId // ignore: cast_nullable_to_non_nullable
as String,operation: null == operation ? _self.operation : operation // ignore: cast_nullable_to_non_nullable
as SyncOperation,payloadJson: freezed == payloadJson ? _self.payloadJson : payloadJson // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,attemptCount: null == attemptCount ? _self.attemptCount : attemptCount // ignore: cast_nullable_to_non_nullable
as int,lastError: freezed == lastError ? _self.lastError : lastError // ignore: cast_nullable_to_non_nullable
as String?,processedAt: freezed == processedAt ? _self.processedAt : processedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$SyncStatus {

 int get pendingCount; bool get cloudSyncAvailable;
/// Create a copy of SyncStatus
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SyncStatusCopyWith<SyncStatus> get copyWith => _$SyncStatusCopyWithImpl<SyncStatus>(this as SyncStatus, _$identity);

  /// Serializes this SyncStatus to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SyncStatus;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SyncStatus&&(identical(other.pendingCount, _this.pendingCount) || other.pendingCount == _this.pendingCount)&&(identical(other.cloudSyncAvailable, _this.cloudSyncAvailable) || other.cloudSyncAvailable == _this.cloudSyncAvailable));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SyncStatus;
  return Object.hash(runtimeType,_this.pendingCount,_this.cloudSyncAvailable);
}

@override
String toString() {
  final _this = this as SyncStatus;
  return 'SyncStatus(pendingCount: ${_this.pendingCount}, cloudSyncAvailable: ${_this.cloudSyncAvailable})';
}


}

/// @nodoc
abstract mixin class $SyncStatusCopyWith<$Res>  {
  factory $SyncStatusCopyWith(SyncStatus value, $Res Function(SyncStatus) _then) = _$SyncStatusCopyWithImpl;
@useResult
$Res call({
 int pendingCount, bool cloudSyncAvailable
});




}
/// @nodoc
class _$SyncStatusCopyWithImpl<$Res>
    implements $SyncStatusCopyWith<$Res> {
  _$SyncStatusCopyWithImpl(this._self, this._then);

  final SyncStatus _self;
  final $Res Function(SyncStatus) _then;

/// Create a copy of SyncStatus
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? pendingCount = null,Object? cloudSyncAvailable = null,}) {
  return _then(SyncStatus(
pendingCount: null == pendingCount ? _self.pendingCount : pendingCount // ignore: cast_nullable_to_non_nullable
as int,cloudSyncAvailable: null == cloudSyncAvailable ? _self.cloudSyncAvailable : cloudSyncAvailable // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [SyncStatus].
extension SyncStatusPatterns on SyncStatus {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SyncStatus value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SyncStatus() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SyncStatus value)  $default,){
final _that = this;
switch (_that) {
case _SyncStatus():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SyncStatus value)?  $default,){
final _that = this;
switch (_that) {
case _SyncStatus() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int pendingCount,  bool cloudSyncAvailable)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SyncStatus() when $default != null:
return $default(_that.pendingCount,_that.cloudSyncAvailable);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int pendingCount,  bool cloudSyncAvailable)  $default,) {final _that = this;
switch (_that) {
case _SyncStatus():
return $default(_that.pendingCount,_that.cloudSyncAvailable);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int pendingCount,  bool cloudSyncAvailable)?  $default,) {final _that = this;
switch (_that) {
case _SyncStatus() when $default != null:
return $default(_that.pendingCount,_that.cloudSyncAvailable);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SyncStatus implements SyncStatus {
  const _SyncStatus({required this.pendingCount, required this.cloudSyncAvailable});
  factory _SyncStatus.fromJson(Map<String, dynamic> json) => _$SyncStatusFromJson(json);

@override final  int pendingCount;
@override final  bool cloudSyncAvailable;

/// Create a copy of SyncStatus
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SyncStatusCopyWith<_SyncStatus> get copyWith => __$SyncStatusCopyWithImpl<_SyncStatus>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SyncStatusToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SyncStatus&&(identical(other.pendingCount, pendingCount) || other.pendingCount == pendingCount)&&(identical(other.cloudSyncAvailable, cloudSyncAvailable) || other.cloudSyncAvailable == cloudSyncAvailable));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,pendingCount,cloudSyncAvailable);
}

@override
String toString() {
    return 'SyncStatus(pendingCount: $pendingCount, cloudSyncAvailable: $cloudSyncAvailable)';
}


}

/// @nodoc
abstract mixin class _$SyncStatusCopyWith<$Res> implements $SyncStatusCopyWith<$Res> {
  factory _$SyncStatusCopyWith(_SyncStatus value, $Res Function(_SyncStatus) _then) = __$SyncStatusCopyWithImpl;
@override @useResult
$Res call({
 int pendingCount, bool cloudSyncAvailable
});




}
/// @nodoc
class __$SyncStatusCopyWithImpl<$Res>
    implements _$SyncStatusCopyWith<$Res> {
  __$SyncStatusCopyWithImpl(this._self, this._then);

  final _SyncStatus _self;
  final $Res Function(_SyncStatus) _then;

/// Create a copy of SyncStatus
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? pendingCount = null,Object? cloudSyncAvailable = null,}) {
  return _then(_SyncStatus(
pendingCount: null == pendingCount ? _self.pendingCount : pendingCount // ignore: cast_nullable_to_non_nullable
as int,cloudSyncAvailable: null == cloudSyncAvailable ? _self.cloudSyncAvailable : cloudSyncAvailable // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
