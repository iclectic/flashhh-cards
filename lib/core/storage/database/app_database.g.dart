// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $UsersTable extends Users with TableInfo<$UsersTable, UserRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _displayNameMeta = const VerificationMeta(
    'displayName',
  );
  @override
  late final GeneratedColumn<String> displayName = GeneratedColumn<String>(
    'display_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _authProviderMeta = const VerificationMeta(
    'authProvider',
  );
  @override
  late final GeneratedColumn<String> authProvider = GeneratedColumn<String>(
    'auth_provider',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isGuestMeta = const VerificationMeta(
    'isGuest',
  );
  @override
  late final GeneratedColumn<bool> isGuest = GeneratedColumn<bool>(
    'is_guest',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_guest" IN (0, 1))',
    ),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    email,
    displayName,
    authProvider,
    isGuest,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    }
    if (data.containsKey('display_name')) {
      context.handle(
        _displayNameMeta,
        displayName.isAcceptableOrUnknown(
          data['display_name']!,
          _displayNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_displayNameMeta);
    }
    if (data.containsKey('auth_provider')) {
      context.handle(
        _authProviderMeta,
        authProvider.isAcceptableOrUnknown(
          data['auth_provider']!,
          _authProviderMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_authProviderMeta);
    }
    if (data.containsKey('is_guest')) {
      context.handle(
        _isGuestMeta,
        isGuest.isAcceptableOrUnknown(data['is_guest']!, _isGuestMeta),
      );
    } else if (isInserting) {
      context.missing(_isGuestMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      ),
      displayName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_name'],
      )!,
      authProvider: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}auth_provider'],
      )!,
      isGuest: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_guest'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }
}

class UserRow extends DataClass implements Insertable<UserRow> {
  final String id;
  final String? email;
  final String displayName;
  final String authProvider;
  final bool isGuest;
  final DateTime createdAt;
  const UserRow({
    required this.id,
    this.email,
    required this.displayName,
    required this.authProvider,
    required this.isGuest,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    map['display_name'] = Variable<String>(displayName);
    map['auth_provider'] = Variable<String>(authProvider);
    map['is_guest'] = Variable<bool>(isGuest);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: Value(id),
      email: email == null && nullToAbsent
          ? const Value.absent()
          : Value(email),
      displayName: Value(displayName),
      authProvider: Value(authProvider),
      isGuest: Value(isGuest),
      createdAt: Value(createdAt),
    );
  }

  factory UserRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserRow(
      id: serializer.fromJson<String>(json['id']),
      email: serializer.fromJson<String?>(json['email']),
      displayName: serializer.fromJson<String>(json['displayName']),
      authProvider: serializer.fromJson<String>(json['authProvider']),
      isGuest: serializer.fromJson<bool>(json['isGuest']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'email': serializer.toJson<String?>(email),
      'displayName': serializer.toJson<String>(displayName),
      'authProvider': serializer.toJson<String>(authProvider),
      'isGuest': serializer.toJson<bool>(isGuest),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  UserRow copyWith({
    String? id,
    Value<String?> email = const Value.absent(),
    String? displayName,
    String? authProvider,
    bool? isGuest,
    DateTime? createdAt,
  }) => UserRow(
    id: id ?? this.id,
    email: email.present ? email.value : this.email,
    displayName: displayName ?? this.displayName,
    authProvider: authProvider ?? this.authProvider,
    isGuest: isGuest ?? this.isGuest,
    createdAt: createdAt ?? this.createdAt,
  );
  UserRow copyWithCompanion(UsersCompanion data) {
    return UserRow(
      id: data.id.present ? data.id.value : this.id,
      email: data.email.present ? data.email.value : this.email,
      displayName: data.displayName.present
          ? data.displayName.value
          : this.displayName,
      authProvider: data.authProvider.present
          ? data.authProvider.value
          : this.authProvider,
      isGuest: data.isGuest.present ? data.isGuest.value : this.isGuest,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserRow(')
          ..write('id: $id, ')
          ..write('email: $email, ')
          ..write('displayName: $displayName, ')
          ..write('authProvider: $authProvider, ')
          ..write('isGuest: $isGuest, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, email, displayName, authProvider, isGuest, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserRow &&
          other.id == this.id &&
          other.email == this.email &&
          other.displayName == this.displayName &&
          other.authProvider == this.authProvider &&
          other.isGuest == this.isGuest &&
          other.createdAt == this.createdAt);
}

class UsersCompanion extends UpdateCompanion<UserRow> {
  final Value<String> id;
  final Value<String?> email;
  final Value<String> displayName;
  final Value<String> authProvider;
  final Value<bool> isGuest;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.email = const Value.absent(),
    this.displayName = const Value.absent(),
    this.authProvider = const Value.absent(),
    this.isGuest = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UsersCompanion.insert({
    required String id,
    this.email = const Value.absent(),
    required String displayName,
    required String authProvider,
    required bool isGuest,
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       displayName = Value(displayName),
       authProvider = Value(authProvider),
       isGuest = Value(isGuest),
       createdAt = Value(createdAt);
  static Insertable<UserRow> custom({
    Expression<String>? id,
    Expression<String>? email,
    Expression<String>? displayName,
    Expression<String>? authProvider,
    Expression<bool>? isGuest,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (email != null) 'email': email,
      if (displayName != null) 'display_name': displayName,
      if (authProvider != null) 'auth_provider': authProvider,
      if (isGuest != null) 'is_guest': isGuest,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UsersCompanion copyWith({
    Value<String>? id,
    Value<String?>? email,
    Value<String>? displayName,
    Value<String>? authProvider,
    Value<bool>? isGuest,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return UsersCompanion(
      id: id ?? this.id,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      authProvider: authProvider ?? this.authProvider,
      isGuest: isGuest ?? this.isGuest,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (authProvider.present) {
      map['auth_provider'] = Variable<String>(authProvider.value);
    }
    if (isGuest.present) {
      map['is_guest'] = Variable<bool>(isGuest.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('email: $email, ')
          ..write('displayName: $displayName, ')
          ..write('authProvider: $authProvider, ')
          ..write('isGuest: $isGuest, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DecksTable extends Decks with TableInfo<$DecksTable, DeckRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DecksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ownerIdMeta = const VerificationMeta(
    'ownerId',
  );
  @override
  late final GeneratedColumn<String> ownerId = GeneratedColumn<String>(
    'owner_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES users (id)',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    ownerId,
    name,
    description,
    createdAt,
    updatedAt,
    deletedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'decks';
  @override
  VerificationContext validateIntegrity(
    Insertable<DeckRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('owner_id')) {
      context.handle(
        _ownerIdMeta,
        ownerId.isAcceptableOrUnknown(data['owner_id']!, _ownerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_ownerIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DeckRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DeckRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      ownerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}owner_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
    );
  }

  @override
  $DecksTable createAlias(String alias) {
    return $DecksTable(attachedDatabase, alias);
  }
}

class DeckRow extends DataClass implements Insertable<DeckRow> {
  final String id;
  final String ownerId;
  final String name;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  const DeckRow({
    required this.id,
    required this.ownerId,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['owner_id'] = Variable<String>(ownerId);
    map['name'] = Variable<String>(name);
    map['description'] = Variable<String>(description);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    return map;
  }

  DecksCompanion toCompanion(bool nullToAbsent) {
    return DecksCompanion(
      id: Value(id),
      ownerId: Value(ownerId),
      name: Value(name),
      description: Value(description),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory DeckRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DeckRow(
      id: serializer.fromJson<String>(json['id']),
      ownerId: serializer.fromJson<String>(json['ownerId']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'ownerId': serializer.toJson<String>(ownerId),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  DeckRow copyWith({
    String? id,
    String? ownerId,
    String? name,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
  }) => DeckRow(
    id: id ?? this.id,
    ownerId: ownerId ?? this.ownerId,
    name: name ?? this.name,
    description: description ?? this.description,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
  );
  DeckRow copyWithCompanion(DecksCompanion data) {
    return DeckRow(
      id: data.id.present ? data.id.value : this.id,
      ownerId: data.ownerId.present ? data.ownerId.value : this.ownerId,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DeckRow(')
          ..write('id: $id, ')
          ..write('ownerId: $ownerId, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    ownerId,
    name,
    description,
    createdAt,
    updatedAt,
    deletedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DeckRow &&
          other.id == this.id &&
          other.ownerId == this.ownerId &&
          other.name == this.name &&
          other.description == this.description &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt);
}

class DecksCompanion extends UpdateCompanion<DeckRow> {
  final Value<String> id;
  final Value<String> ownerId;
  final Value<String> name;
  final Value<String> description;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<int> rowid;
  const DecksCompanion({
    this.id = const Value.absent(),
    this.ownerId = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DecksCompanion.insert({
    required String id,
    required String ownerId,
    required String name,
    this.description = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       ownerId = Value(ownerId),
       name = Value(name),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<DeckRow> custom({
    Expression<String>? id,
    Expression<String>? ownerId,
    Expression<String>? name,
    Expression<String>? description,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ownerId != null) 'owner_id': ownerId,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DecksCompanion copyWith({
    Value<String>? id,
    Value<String>? ownerId,
    Value<String>? name,
    Value<String>? description,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<int>? rowid,
  }) {
    return DecksCompanion(
      id: id ?? this.id,
      ownerId: ownerId ?? this.ownerId,
      name: name ?? this.name,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (ownerId.present) {
      map['owner_id'] = Variable<String>(ownerId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DecksCompanion(')
          ..write('id: $id, ')
          ..write('ownerId: $ownerId, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FlashcardsTable extends Flashcards
    with TableInfo<$FlashcardsTable, FlashcardRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FlashcardsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deckIdMeta = const VerificationMeta('deckId');
  @override
  late final GeneratedColumn<String> deckId = GeneratedColumn<String>(
    'deck_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES decks (id)',
    ),
  );
  static const VerificationMeta _questionMeta = const VerificationMeta(
    'question',
  );
  @override
  late final GeneratedColumn<String> question = GeneratedColumn<String>(
    'question',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _answerMeta = const VerificationMeta('answer');
  @override
  late final GeneratedColumn<String> answer = GeneratedColumn<String>(
    'answer',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
    'source',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _difficultyMeta = const VerificationMeta(
    'difficulty',
  );
  @override
  late final GeneratedColumn<String> difficulty = GeneratedColumn<String>(
    'difficulty',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastReviewedAtMeta = const VerificationMeta(
    'lastReviewedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastReviewedAt =
      GeneratedColumn<DateTime>(
        'last_reviewed_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _nextReviewAtMeta = const VerificationMeta(
    'nextReviewAt',
  );
  @override
  late final GeneratedColumn<DateTime> nextReviewAt = GeneratedColumn<DateTime>(
    'next_review_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _reviewCountMeta = const VerificationMeta(
    'reviewCount',
  );
  @override
  late final GeneratedColumn<int> reviewCount = GeneratedColumn<int>(
    'review_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _successCountMeta = const VerificationMeta(
    'successCount',
  );
  @override
  late final GeneratedColumn<int> successCount = GeneratedColumn<int>(
    'success_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _failureCountMeta = const VerificationMeta(
    'failureCount',
  );
  @override
  late final GeneratedColumn<int> failureCount = GeneratedColumn<int>(
    'failure_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _easeFactorMillisMeta = const VerificationMeta(
    'easeFactorMillis',
  );
  @override
  late final GeneratedColumn<int> easeFactorMillis = GeneratedColumn<int>(
    'ease_factor_millis',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(initialEaseFactorMillis),
  );
  static const VerificationMeta _intervalDaysMeta = const VerificationMeta(
    'intervalDays',
  );
  @override
  late final GeneratedColumn<int> intervalDays = GeneratedColumn<int>(
    'interval_days',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _repetitionsMeta = const VerificationMeta(
    'repetitions',
  );
  @override
  late final GeneratedColumn<int> repetitions = GeneratedColumn<int>(
    'repetitions',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lapsesMeta = const VerificationMeta('lapses');
  @override
  late final GeneratedColumn<int> lapses = GeneratedColumn<int>(
    'lapses',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    deckId,
    question,
    answer,
    createdAt,
    updatedAt,
    source,
    difficulty,
    deletedAt,
    lastReviewedAt,
    nextReviewAt,
    reviewCount,
    successCount,
    failureCount,
    easeFactorMillis,
    intervalDays,
    repetitions,
    lapses,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'flashcards';
  @override
  VerificationContext validateIntegrity(
    Insertable<FlashcardRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('deck_id')) {
      context.handle(
        _deckIdMeta,
        deckId.isAcceptableOrUnknown(data['deck_id']!, _deckIdMeta),
      );
    } else if (isInserting) {
      context.missing(_deckIdMeta);
    }
    if (data.containsKey('question')) {
      context.handle(
        _questionMeta,
        question.isAcceptableOrUnknown(data['question']!, _questionMeta),
      );
    } else if (isInserting) {
      context.missing(_questionMeta);
    }
    if (data.containsKey('answer')) {
      context.handle(
        _answerMeta,
        answer.isAcceptableOrUnknown(data['answer']!, _answerMeta),
      );
    } else if (isInserting) {
      context.missing(_answerMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('source')) {
      context.handle(
        _sourceMeta,
        source.isAcceptableOrUnknown(data['source']!, _sourceMeta),
      );
    } else if (isInserting) {
      context.missing(_sourceMeta);
    }
    if (data.containsKey('difficulty')) {
      context.handle(
        _difficultyMeta,
        difficulty.isAcceptableOrUnknown(data['difficulty']!, _difficultyMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('last_reviewed_at')) {
      context.handle(
        _lastReviewedAtMeta,
        lastReviewedAt.isAcceptableOrUnknown(
          data['last_reviewed_at']!,
          _lastReviewedAtMeta,
        ),
      );
    }
    if (data.containsKey('next_review_at')) {
      context.handle(
        _nextReviewAtMeta,
        nextReviewAt.isAcceptableOrUnknown(
          data['next_review_at']!,
          _nextReviewAtMeta,
        ),
      );
    }
    if (data.containsKey('review_count')) {
      context.handle(
        _reviewCountMeta,
        reviewCount.isAcceptableOrUnknown(
          data['review_count']!,
          _reviewCountMeta,
        ),
      );
    }
    if (data.containsKey('success_count')) {
      context.handle(
        _successCountMeta,
        successCount.isAcceptableOrUnknown(
          data['success_count']!,
          _successCountMeta,
        ),
      );
    }
    if (data.containsKey('failure_count')) {
      context.handle(
        _failureCountMeta,
        failureCount.isAcceptableOrUnknown(
          data['failure_count']!,
          _failureCountMeta,
        ),
      );
    }
    if (data.containsKey('ease_factor_millis')) {
      context.handle(
        _easeFactorMillisMeta,
        easeFactorMillis.isAcceptableOrUnknown(
          data['ease_factor_millis']!,
          _easeFactorMillisMeta,
        ),
      );
    }
    if (data.containsKey('interval_days')) {
      context.handle(
        _intervalDaysMeta,
        intervalDays.isAcceptableOrUnknown(
          data['interval_days']!,
          _intervalDaysMeta,
        ),
      );
    }
    if (data.containsKey('repetitions')) {
      context.handle(
        _repetitionsMeta,
        repetitions.isAcceptableOrUnknown(
          data['repetitions']!,
          _repetitionsMeta,
        ),
      );
    }
    if (data.containsKey('lapses')) {
      context.handle(
        _lapsesMeta,
        lapses.isAcceptableOrUnknown(data['lapses']!, _lapsesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FlashcardRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FlashcardRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      deckId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}deck_id'],
      )!,
      question: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}question'],
      )!,
      answer: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}answer'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      source: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source'],
      )!,
      difficulty: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}difficulty'],
      ),
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      lastReviewedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_reviewed_at'],
      ),
      nextReviewAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}next_review_at'],
      ),
      reviewCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}review_count'],
      )!,
      successCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}success_count'],
      )!,
      failureCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}failure_count'],
      )!,
      easeFactorMillis: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ease_factor_millis'],
      )!,
      intervalDays: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}interval_days'],
      )!,
      repetitions: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}repetitions'],
      )!,
      lapses: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}lapses'],
      )!,
    );
  }

  @override
  $FlashcardsTable createAlias(String alias) {
    return $FlashcardsTable(attachedDatabase, alias);
  }
}

class FlashcardRow extends DataClass implements Insertable<FlashcardRow> {
  final String id;
  final String deckId;
  final String question;
  final String answer;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String source;
  final String? difficulty;
  final DateTime? deletedAt;
  final DateTime? lastReviewedAt;
  final DateTime? nextReviewAt;
  final int reviewCount;
  final int successCount;
  final int failureCount;

  /// SM-2 ease factor stored as thousandths (2500 means 2.5).
  final int easeFactorMillis;
  final int intervalDays;
  final int repetitions;
  final int lapses;
  const FlashcardRow({
    required this.id,
    required this.deckId,
    required this.question,
    required this.answer,
    required this.createdAt,
    required this.updatedAt,
    required this.source,
    this.difficulty,
    this.deletedAt,
    this.lastReviewedAt,
    this.nextReviewAt,
    required this.reviewCount,
    required this.successCount,
    required this.failureCount,
    required this.easeFactorMillis,
    required this.intervalDays,
    required this.repetitions,
    required this.lapses,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['deck_id'] = Variable<String>(deckId);
    map['question'] = Variable<String>(question);
    map['answer'] = Variable<String>(answer);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['source'] = Variable<String>(source);
    if (!nullToAbsent || difficulty != null) {
      map['difficulty'] = Variable<String>(difficulty);
    }
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    if (!nullToAbsent || lastReviewedAt != null) {
      map['last_reviewed_at'] = Variable<DateTime>(lastReviewedAt);
    }
    if (!nullToAbsent || nextReviewAt != null) {
      map['next_review_at'] = Variable<DateTime>(nextReviewAt);
    }
    map['review_count'] = Variable<int>(reviewCount);
    map['success_count'] = Variable<int>(successCount);
    map['failure_count'] = Variable<int>(failureCount);
    map['ease_factor_millis'] = Variable<int>(easeFactorMillis);
    map['interval_days'] = Variable<int>(intervalDays);
    map['repetitions'] = Variable<int>(repetitions);
    map['lapses'] = Variable<int>(lapses);
    return map;
  }

  FlashcardsCompanion toCompanion(bool nullToAbsent) {
    return FlashcardsCompanion(
      id: Value(id),
      deckId: Value(deckId),
      question: Value(question),
      answer: Value(answer),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      source: Value(source),
      difficulty: difficulty == null && nullToAbsent
          ? const Value.absent()
          : Value(difficulty),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      lastReviewedAt: lastReviewedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastReviewedAt),
      nextReviewAt: nextReviewAt == null && nullToAbsent
          ? const Value.absent()
          : Value(nextReviewAt),
      reviewCount: Value(reviewCount),
      successCount: Value(successCount),
      failureCount: Value(failureCount),
      easeFactorMillis: Value(easeFactorMillis),
      intervalDays: Value(intervalDays),
      repetitions: Value(repetitions),
      lapses: Value(lapses),
    );
  }

  factory FlashcardRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FlashcardRow(
      id: serializer.fromJson<String>(json['id']),
      deckId: serializer.fromJson<String>(json['deckId']),
      question: serializer.fromJson<String>(json['question']),
      answer: serializer.fromJson<String>(json['answer']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      source: serializer.fromJson<String>(json['source']),
      difficulty: serializer.fromJson<String?>(json['difficulty']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      lastReviewedAt: serializer.fromJson<DateTime?>(json['lastReviewedAt']),
      nextReviewAt: serializer.fromJson<DateTime?>(json['nextReviewAt']),
      reviewCount: serializer.fromJson<int>(json['reviewCount']),
      successCount: serializer.fromJson<int>(json['successCount']),
      failureCount: serializer.fromJson<int>(json['failureCount']),
      easeFactorMillis: serializer.fromJson<int>(json['easeFactorMillis']),
      intervalDays: serializer.fromJson<int>(json['intervalDays']),
      repetitions: serializer.fromJson<int>(json['repetitions']),
      lapses: serializer.fromJson<int>(json['lapses']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'deckId': serializer.toJson<String>(deckId),
      'question': serializer.toJson<String>(question),
      'answer': serializer.toJson<String>(answer),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'source': serializer.toJson<String>(source),
      'difficulty': serializer.toJson<String?>(difficulty),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'lastReviewedAt': serializer.toJson<DateTime?>(lastReviewedAt),
      'nextReviewAt': serializer.toJson<DateTime?>(nextReviewAt),
      'reviewCount': serializer.toJson<int>(reviewCount),
      'successCount': serializer.toJson<int>(successCount),
      'failureCount': serializer.toJson<int>(failureCount),
      'easeFactorMillis': serializer.toJson<int>(easeFactorMillis),
      'intervalDays': serializer.toJson<int>(intervalDays),
      'repetitions': serializer.toJson<int>(repetitions),
      'lapses': serializer.toJson<int>(lapses),
    };
  }

  FlashcardRow copyWith({
    String? id,
    String? deckId,
    String? question,
    String? answer,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? source,
    Value<String?> difficulty = const Value.absent(),
    Value<DateTime?> deletedAt = const Value.absent(),
    Value<DateTime?> lastReviewedAt = const Value.absent(),
    Value<DateTime?> nextReviewAt = const Value.absent(),
    int? reviewCount,
    int? successCount,
    int? failureCount,
    int? easeFactorMillis,
    int? intervalDays,
    int? repetitions,
    int? lapses,
  }) => FlashcardRow(
    id: id ?? this.id,
    deckId: deckId ?? this.deckId,
    question: question ?? this.question,
    answer: answer ?? this.answer,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    source: source ?? this.source,
    difficulty: difficulty.present ? difficulty.value : this.difficulty,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    lastReviewedAt: lastReviewedAt.present
        ? lastReviewedAt.value
        : this.lastReviewedAt,
    nextReviewAt: nextReviewAt.present ? nextReviewAt.value : this.nextReviewAt,
    reviewCount: reviewCount ?? this.reviewCount,
    successCount: successCount ?? this.successCount,
    failureCount: failureCount ?? this.failureCount,
    easeFactorMillis: easeFactorMillis ?? this.easeFactorMillis,
    intervalDays: intervalDays ?? this.intervalDays,
    repetitions: repetitions ?? this.repetitions,
    lapses: lapses ?? this.lapses,
  );
  FlashcardRow copyWithCompanion(FlashcardsCompanion data) {
    return FlashcardRow(
      id: data.id.present ? data.id.value : this.id,
      deckId: data.deckId.present ? data.deckId.value : this.deckId,
      question: data.question.present ? data.question.value : this.question,
      answer: data.answer.present ? data.answer.value : this.answer,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      source: data.source.present ? data.source.value : this.source,
      difficulty: data.difficulty.present
          ? data.difficulty.value
          : this.difficulty,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      lastReviewedAt: data.lastReviewedAt.present
          ? data.lastReviewedAt.value
          : this.lastReviewedAt,
      nextReviewAt: data.nextReviewAt.present
          ? data.nextReviewAt.value
          : this.nextReviewAt,
      reviewCount: data.reviewCount.present
          ? data.reviewCount.value
          : this.reviewCount,
      successCount: data.successCount.present
          ? data.successCount.value
          : this.successCount,
      failureCount: data.failureCount.present
          ? data.failureCount.value
          : this.failureCount,
      easeFactorMillis: data.easeFactorMillis.present
          ? data.easeFactorMillis.value
          : this.easeFactorMillis,
      intervalDays: data.intervalDays.present
          ? data.intervalDays.value
          : this.intervalDays,
      repetitions: data.repetitions.present
          ? data.repetitions.value
          : this.repetitions,
      lapses: data.lapses.present ? data.lapses.value : this.lapses,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FlashcardRow(')
          ..write('id: $id, ')
          ..write('deckId: $deckId, ')
          ..write('question: $question, ')
          ..write('answer: $answer, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('source: $source, ')
          ..write('difficulty: $difficulty, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('lastReviewedAt: $lastReviewedAt, ')
          ..write('nextReviewAt: $nextReviewAt, ')
          ..write('reviewCount: $reviewCount, ')
          ..write('successCount: $successCount, ')
          ..write('failureCount: $failureCount, ')
          ..write('easeFactorMillis: $easeFactorMillis, ')
          ..write('intervalDays: $intervalDays, ')
          ..write('repetitions: $repetitions, ')
          ..write('lapses: $lapses')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    deckId,
    question,
    answer,
    createdAt,
    updatedAt,
    source,
    difficulty,
    deletedAt,
    lastReviewedAt,
    nextReviewAt,
    reviewCount,
    successCount,
    failureCount,
    easeFactorMillis,
    intervalDays,
    repetitions,
    lapses,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FlashcardRow &&
          other.id == this.id &&
          other.deckId == this.deckId &&
          other.question == this.question &&
          other.answer == this.answer &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.source == this.source &&
          other.difficulty == this.difficulty &&
          other.deletedAt == this.deletedAt &&
          other.lastReviewedAt == this.lastReviewedAt &&
          other.nextReviewAt == this.nextReviewAt &&
          other.reviewCount == this.reviewCount &&
          other.successCount == this.successCount &&
          other.failureCount == this.failureCount &&
          other.easeFactorMillis == this.easeFactorMillis &&
          other.intervalDays == this.intervalDays &&
          other.repetitions == this.repetitions &&
          other.lapses == this.lapses);
}

class FlashcardsCompanion extends UpdateCompanion<FlashcardRow> {
  final Value<String> id;
  final Value<String> deckId;
  final Value<String> question;
  final Value<String> answer;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> source;
  final Value<String?> difficulty;
  final Value<DateTime?> deletedAt;
  final Value<DateTime?> lastReviewedAt;
  final Value<DateTime?> nextReviewAt;
  final Value<int> reviewCount;
  final Value<int> successCount;
  final Value<int> failureCount;
  final Value<int> easeFactorMillis;
  final Value<int> intervalDays;
  final Value<int> repetitions;
  final Value<int> lapses;
  final Value<int> rowid;
  const FlashcardsCompanion({
    this.id = const Value.absent(),
    this.deckId = const Value.absent(),
    this.question = const Value.absent(),
    this.answer = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.source = const Value.absent(),
    this.difficulty = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.lastReviewedAt = const Value.absent(),
    this.nextReviewAt = const Value.absent(),
    this.reviewCount = const Value.absent(),
    this.successCount = const Value.absent(),
    this.failureCount = const Value.absent(),
    this.easeFactorMillis = const Value.absent(),
    this.intervalDays = const Value.absent(),
    this.repetitions = const Value.absent(),
    this.lapses = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FlashcardsCompanion.insert({
    required String id,
    required String deckId,
    required String question,
    required String answer,
    required DateTime createdAt,
    required DateTime updatedAt,
    required String source,
    this.difficulty = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.lastReviewedAt = const Value.absent(),
    this.nextReviewAt = const Value.absent(),
    this.reviewCount = const Value.absent(),
    this.successCount = const Value.absent(),
    this.failureCount = const Value.absent(),
    this.easeFactorMillis = const Value.absent(),
    this.intervalDays = const Value.absent(),
    this.repetitions = const Value.absent(),
    this.lapses = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       deckId = Value(deckId),
       question = Value(question),
       answer = Value(answer),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt),
       source = Value(source);
  static Insertable<FlashcardRow> custom({
    Expression<String>? id,
    Expression<String>? deckId,
    Expression<String>? question,
    Expression<String>? answer,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? source,
    Expression<String>? difficulty,
    Expression<DateTime>? deletedAt,
    Expression<DateTime>? lastReviewedAt,
    Expression<DateTime>? nextReviewAt,
    Expression<int>? reviewCount,
    Expression<int>? successCount,
    Expression<int>? failureCount,
    Expression<int>? easeFactorMillis,
    Expression<int>? intervalDays,
    Expression<int>? repetitions,
    Expression<int>? lapses,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (deckId != null) 'deck_id': deckId,
      if (question != null) 'question': question,
      if (answer != null) 'answer': answer,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (source != null) 'source': source,
      if (difficulty != null) 'difficulty': difficulty,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (lastReviewedAt != null) 'last_reviewed_at': lastReviewedAt,
      if (nextReviewAt != null) 'next_review_at': nextReviewAt,
      if (reviewCount != null) 'review_count': reviewCount,
      if (successCount != null) 'success_count': successCount,
      if (failureCount != null) 'failure_count': failureCount,
      if (easeFactorMillis != null) 'ease_factor_millis': easeFactorMillis,
      if (intervalDays != null) 'interval_days': intervalDays,
      if (repetitions != null) 'repetitions': repetitions,
      if (lapses != null) 'lapses': lapses,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FlashcardsCompanion copyWith({
    Value<String>? id,
    Value<String>? deckId,
    Value<String>? question,
    Value<String>? answer,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? source,
    Value<String?>? difficulty,
    Value<DateTime?>? deletedAt,
    Value<DateTime?>? lastReviewedAt,
    Value<DateTime?>? nextReviewAt,
    Value<int>? reviewCount,
    Value<int>? successCount,
    Value<int>? failureCount,
    Value<int>? easeFactorMillis,
    Value<int>? intervalDays,
    Value<int>? repetitions,
    Value<int>? lapses,
    Value<int>? rowid,
  }) {
    return FlashcardsCompanion(
      id: id ?? this.id,
      deckId: deckId ?? this.deckId,
      question: question ?? this.question,
      answer: answer ?? this.answer,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      source: source ?? this.source,
      difficulty: difficulty ?? this.difficulty,
      deletedAt: deletedAt ?? this.deletedAt,
      lastReviewedAt: lastReviewedAt ?? this.lastReviewedAt,
      nextReviewAt: nextReviewAt ?? this.nextReviewAt,
      reviewCount: reviewCount ?? this.reviewCount,
      successCount: successCount ?? this.successCount,
      failureCount: failureCount ?? this.failureCount,
      easeFactorMillis: easeFactorMillis ?? this.easeFactorMillis,
      intervalDays: intervalDays ?? this.intervalDays,
      repetitions: repetitions ?? this.repetitions,
      lapses: lapses ?? this.lapses,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (deckId.present) {
      map['deck_id'] = Variable<String>(deckId.value);
    }
    if (question.present) {
      map['question'] = Variable<String>(question.value);
    }
    if (answer.present) {
      map['answer'] = Variable<String>(answer.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (difficulty.present) {
      map['difficulty'] = Variable<String>(difficulty.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (lastReviewedAt.present) {
      map['last_reviewed_at'] = Variable<DateTime>(lastReviewedAt.value);
    }
    if (nextReviewAt.present) {
      map['next_review_at'] = Variable<DateTime>(nextReviewAt.value);
    }
    if (reviewCount.present) {
      map['review_count'] = Variable<int>(reviewCount.value);
    }
    if (successCount.present) {
      map['success_count'] = Variable<int>(successCount.value);
    }
    if (failureCount.present) {
      map['failure_count'] = Variable<int>(failureCount.value);
    }
    if (easeFactorMillis.present) {
      map['ease_factor_millis'] = Variable<int>(easeFactorMillis.value);
    }
    if (intervalDays.present) {
      map['interval_days'] = Variable<int>(intervalDays.value);
    }
    if (repetitions.present) {
      map['repetitions'] = Variable<int>(repetitions.value);
    }
    if (lapses.present) {
      map['lapses'] = Variable<int>(lapses.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FlashcardsCompanion(')
          ..write('id: $id, ')
          ..write('deckId: $deckId, ')
          ..write('question: $question, ')
          ..write('answer: $answer, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('source: $source, ')
          ..write('difficulty: $difficulty, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('lastReviewedAt: $lastReviewedAt, ')
          ..write('nextReviewAt: $nextReviewAt, ')
          ..write('reviewCount: $reviewCount, ')
          ..write('successCount: $successCount, ')
          ..write('failureCount: $failureCount, ')
          ..write('easeFactorMillis: $easeFactorMillis, ')
          ..write('intervalDays: $intervalDays, ')
          ..write('repetitions: $repetitions, ')
          ..write('lapses: $lapses, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FlashcardTagsTable extends FlashcardTags
    with TableInfo<$FlashcardTagsTable, FlashcardTagRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FlashcardTagsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _cardIdMeta = const VerificationMeta('cardId');
  @override
  late final GeneratedColumn<String> cardId = GeneratedColumn<String>(
    'card_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES flashcards (id)',
    ),
  );
  static const VerificationMeta _tagMeta = const VerificationMeta('tag');
  @override
  late final GeneratedColumn<String> tag = GeneratedColumn<String>(
    'tag',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [cardId, tag];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'flashcard_tags';
  @override
  VerificationContext validateIntegrity(
    Insertable<FlashcardTagRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('card_id')) {
      context.handle(
        _cardIdMeta,
        cardId.isAcceptableOrUnknown(data['card_id']!, _cardIdMeta),
      );
    } else if (isInserting) {
      context.missing(_cardIdMeta);
    }
    if (data.containsKey('tag')) {
      context.handle(
        _tagMeta,
        tag.isAcceptableOrUnknown(data['tag']!, _tagMeta),
      );
    } else if (isInserting) {
      context.missing(_tagMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {cardId, tag};
  @override
  FlashcardTagRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FlashcardTagRow(
      cardId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}card_id'],
      )!,
      tag: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tag'],
      )!,
    );
  }

  @override
  $FlashcardTagsTable createAlias(String alias) {
    return $FlashcardTagsTable(attachedDatabase, alias);
  }
}

class FlashcardTagRow extends DataClass implements Insertable<FlashcardTagRow> {
  final String cardId;
  final String tag;
  const FlashcardTagRow({required this.cardId, required this.tag});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['card_id'] = Variable<String>(cardId);
    map['tag'] = Variable<String>(tag);
    return map;
  }

  FlashcardTagsCompanion toCompanion(bool nullToAbsent) {
    return FlashcardTagsCompanion(cardId: Value(cardId), tag: Value(tag));
  }

  factory FlashcardTagRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FlashcardTagRow(
      cardId: serializer.fromJson<String>(json['cardId']),
      tag: serializer.fromJson<String>(json['tag']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'cardId': serializer.toJson<String>(cardId),
      'tag': serializer.toJson<String>(tag),
    };
  }

  FlashcardTagRow copyWith({String? cardId, String? tag}) =>
      FlashcardTagRow(cardId: cardId ?? this.cardId, tag: tag ?? this.tag);
  FlashcardTagRow copyWithCompanion(FlashcardTagsCompanion data) {
    return FlashcardTagRow(
      cardId: data.cardId.present ? data.cardId.value : this.cardId,
      tag: data.tag.present ? data.tag.value : this.tag,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FlashcardTagRow(')
          ..write('cardId: $cardId, ')
          ..write('tag: $tag')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(cardId, tag);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FlashcardTagRow &&
          other.cardId == this.cardId &&
          other.tag == this.tag);
}

class FlashcardTagsCompanion extends UpdateCompanion<FlashcardTagRow> {
  final Value<String> cardId;
  final Value<String> tag;
  final Value<int> rowid;
  const FlashcardTagsCompanion({
    this.cardId = const Value.absent(),
    this.tag = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FlashcardTagsCompanion.insert({
    required String cardId,
    required String tag,
    this.rowid = const Value.absent(),
  }) : cardId = Value(cardId),
       tag = Value(tag);
  static Insertable<FlashcardTagRow> custom({
    Expression<String>? cardId,
    Expression<String>? tag,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (cardId != null) 'card_id': cardId,
      if (tag != null) 'tag': tag,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FlashcardTagsCompanion copyWith({
    Value<String>? cardId,
    Value<String>? tag,
    Value<int>? rowid,
  }) {
    return FlashcardTagsCompanion(
      cardId: cardId ?? this.cardId,
      tag: tag ?? this.tag,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (cardId.present) {
      map['card_id'] = Variable<String>(cardId.value);
    }
    if (tag.present) {
      map['tag'] = Variable<String>(tag.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FlashcardTagsCompanion(')
          ..write('cardId: $cardId, ')
          ..write('tag: $tag, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $StudySessionsTable extends StudySessions
    with TableInfo<$StudySessionsTable, StudySessionRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StudySessionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deckIdMeta = const VerificationMeta('deckId');
  @override
  late final GeneratedColumn<String> deckId = GeneratedColumn<String>(
    'deck_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES decks (id)',
    ),
  );
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
    'started_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _cardsReviewedMeta = const VerificationMeta(
    'cardsReviewed',
  );
  @override
  late final GeneratedColumn<int> cardsReviewed = GeneratedColumn<int>(
    'cards_reviewed',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _againCountMeta = const VerificationMeta(
    'againCount',
  );
  @override
  late final GeneratedColumn<int> againCount = GeneratedColumn<int>(
    'again_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _hardCountMeta = const VerificationMeta(
    'hardCount',
  );
  @override
  late final GeneratedColumn<int> hardCount = GeneratedColumn<int>(
    'hard_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _goodCountMeta = const VerificationMeta(
    'goodCount',
  );
  @override
  late final GeneratedColumn<int> goodCount = GeneratedColumn<int>(
    'good_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _easyCountMeta = const VerificationMeta(
    'easyCount',
  );
  @override
  late final GeneratedColumn<int> easyCount = GeneratedColumn<int>(
    'easy_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    deckId,
    startedAt,
    completedAt,
    cardsReviewed,
    againCount,
    hardCount,
    goodCount,
    easyCount,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'study_sessions';
  @override
  VerificationContext validateIntegrity(
    Insertable<StudySessionRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('deck_id')) {
      context.handle(
        _deckIdMeta,
        deckId.isAcceptableOrUnknown(data['deck_id']!, _deckIdMeta),
      );
    }
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_startedAtMeta);
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    }
    if (data.containsKey('cards_reviewed')) {
      context.handle(
        _cardsReviewedMeta,
        cardsReviewed.isAcceptableOrUnknown(
          data['cards_reviewed']!,
          _cardsReviewedMeta,
        ),
      );
    }
    if (data.containsKey('again_count')) {
      context.handle(
        _againCountMeta,
        againCount.isAcceptableOrUnknown(data['again_count']!, _againCountMeta),
      );
    }
    if (data.containsKey('hard_count')) {
      context.handle(
        _hardCountMeta,
        hardCount.isAcceptableOrUnknown(data['hard_count']!, _hardCountMeta),
      );
    }
    if (data.containsKey('good_count')) {
      context.handle(
        _goodCountMeta,
        goodCount.isAcceptableOrUnknown(data['good_count']!, _goodCountMeta),
      );
    }
    if (data.containsKey('easy_count')) {
      context.handle(
        _easyCountMeta,
        easyCount.isAcceptableOrUnknown(data['easy_count']!, _easyCountMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StudySessionRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StudySessionRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      deckId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}deck_id'],
      ),
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}started_at'],
      )!,
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      ),
      cardsReviewed: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cards_reviewed'],
      )!,
      againCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}again_count'],
      )!,
      hardCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}hard_count'],
      )!,
      goodCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}good_count'],
      )!,
      easyCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}easy_count'],
      )!,
    );
  }

  @override
  $StudySessionsTable createAlias(String alias) {
    return $StudySessionsTable(attachedDatabase, alias);
  }
}

class StudySessionRow extends DataClass implements Insertable<StudySessionRow> {
  final String id;
  final String? deckId;
  final DateTime startedAt;
  final DateTime? completedAt;
  final int cardsReviewed;
  final int againCount;
  final int hardCount;
  final int goodCount;
  final int easyCount;
  const StudySessionRow({
    required this.id,
    this.deckId,
    required this.startedAt,
    this.completedAt,
    required this.cardsReviewed,
    required this.againCount,
    required this.hardCount,
    required this.goodCount,
    required this.easyCount,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || deckId != null) {
      map['deck_id'] = Variable<String>(deckId);
    }
    map['started_at'] = Variable<DateTime>(startedAt);
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    map['cards_reviewed'] = Variable<int>(cardsReviewed);
    map['again_count'] = Variable<int>(againCount);
    map['hard_count'] = Variable<int>(hardCount);
    map['good_count'] = Variable<int>(goodCount);
    map['easy_count'] = Variable<int>(easyCount);
    return map;
  }

  StudySessionsCompanion toCompanion(bool nullToAbsent) {
    return StudySessionsCompanion(
      id: Value(id),
      deckId: deckId == null && nullToAbsent
          ? const Value.absent()
          : Value(deckId),
      startedAt: Value(startedAt),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
      cardsReviewed: Value(cardsReviewed),
      againCount: Value(againCount),
      hardCount: Value(hardCount),
      goodCount: Value(goodCount),
      easyCount: Value(easyCount),
    );
  }

  factory StudySessionRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StudySessionRow(
      id: serializer.fromJson<String>(json['id']),
      deckId: serializer.fromJson<String?>(json['deckId']),
      startedAt: serializer.fromJson<DateTime>(json['startedAt']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
      cardsReviewed: serializer.fromJson<int>(json['cardsReviewed']),
      againCount: serializer.fromJson<int>(json['againCount']),
      hardCount: serializer.fromJson<int>(json['hardCount']),
      goodCount: serializer.fromJson<int>(json['goodCount']),
      easyCount: serializer.fromJson<int>(json['easyCount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'deckId': serializer.toJson<String?>(deckId),
      'startedAt': serializer.toJson<DateTime>(startedAt),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
      'cardsReviewed': serializer.toJson<int>(cardsReviewed),
      'againCount': serializer.toJson<int>(againCount),
      'hardCount': serializer.toJson<int>(hardCount),
      'goodCount': serializer.toJson<int>(goodCount),
      'easyCount': serializer.toJson<int>(easyCount),
    };
  }

  StudySessionRow copyWith({
    String? id,
    Value<String?> deckId = const Value.absent(),
    DateTime? startedAt,
    Value<DateTime?> completedAt = const Value.absent(),
    int? cardsReviewed,
    int? againCount,
    int? hardCount,
    int? goodCount,
    int? easyCount,
  }) => StudySessionRow(
    id: id ?? this.id,
    deckId: deckId.present ? deckId.value : this.deckId,
    startedAt: startedAt ?? this.startedAt,
    completedAt: completedAt.present ? completedAt.value : this.completedAt,
    cardsReviewed: cardsReviewed ?? this.cardsReviewed,
    againCount: againCount ?? this.againCount,
    hardCount: hardCount ?? this.hardCount,
    goodCount: goodCount ?? this.goodCount,
    easyCount: easyCount ?? this.easyCount,
  );
  StudySessionRow copyWithCompanion(StudySessionsCompanion data) {
    return StudySessionRow(
      id: data.id.present ? data.id.value : this.id,
      deckId: data.deckId.present ? data.deckId.value : this.deckId,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
      cardsReviewed: data.cardsReviewed.present
          ? data.cardsReviewed.value
          : this.cardsReviewed,
      againCount: data.againCount.present
          ? data.againCount.value
          : this.againCount,
      hardCount: data.hardCount.present ? data.hardCount.value : this.hardCount,
      goodCount: data.goodCount.present ? data.goodCount.value : this.goodCount,
      easyCount: data.easyCount.present ? data.easyCount.value : this.easyCount,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StudySessionRow(')
          ..write('id: $id, ')
          ..write('deckId: $deckId, ')
          ..write('startedAt: $startedAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('cardsReviewed: $cardsReviewed, ')
          ..write('againCount: $againCount, ')
          ..write('hardCount: $hardCount, ')
          ..write('goodCount: $goodCount, ')
          ..write('easyCount: $easyCount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    deckId,
    startedAt,
    completedAt,
    cardsReviewed,
    againCount,
    hardCount,
    goodCount,
    easyCount,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StudySessionRow &&
          other.id == this.id &&
          other.deckId == this.deckId &&
          other.startedAt == this.startedAt &&
          other.completedAt == this.completedAt &&
          other.cardsReviewed == this.cardsReviewed &&
          other.againCount == this.againCount &&
          other.hardCount == this.hardCount &&
          other.goodCount == this.goodCount &&
          other.easyCount == this.easyCount);
}

class StudySessionsCompanion extends UpdateCompanion<StudySessionRow> {
  final Value<String> id;
  final Value<String?> deckId;
  final Value<DateTime> startedAt;
  final Value<DateTime?> completedAt;
  final Value<int> cardsReviewed;
  final Value<int> againCount;
  final Value<int> hardCount;
  final Value<int> goodCount;
  final Value<int> easyCount;
  final Value<int> rowid;
  const StudySessionsCompanion({
    this.id = const Value.absent(),
    this.deckId = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.cardsReviewed = const Value.absent(),
    this.againCount = const Value.absent(),
    this.hardCount = const Value.absent(),
    this.goodCount = const Value.absent(),
    this.easyCount = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StudySessionsCompanion.insert({
    required String id,
    this.deckId = const Value.absent(),
    required DateTime startedAt,
    this.completedAt = const Value.absent(),
    this.cardsReviewed = const Value.absent(),
    this.againCount = const Value.absent(),
    this.hardCount = const Value.absent(),
    this.goodCount = const Value.absent(),
    this.easyCount = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       startedAt = Value(startedAt);
  static Insertable<StudySessionRow> custom({
    Expression<String>? id,
    Expression<String>? deckId,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? completedAt,
    Expression<int>? cardsReviewed,
    Expression<int>? againCount,
    Expression<int>? hardCount,
    Expression<int>? goodCount,
    Expression<int>? easyCount,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (deckId != null) 'deck_id': deckId,
      if (startedAt != null) 'started_at': startedAt,
      if (completedAt != null) 'completed_at': completedAt,
      if (cardsReviewed != null) 'cards_reviewed': cardsReviewed,
      if (againCount != null) 'again_count': againCount,
      if (hardCount != null) 'hard_count': hardCount,
      if (goodCount != null) 'good_count': goodCount,
      if (easyCount != null) 'easy_count': easyCount,
      if (rowid != null) 'rowid': rowid,
    });
  }

  StudySessionsCompanion copyWith({
    Value<String>? id,
    Value<String?>? deckId,
    Value<DateTime>? startedAt,
    Value<DateTime?>? completedAt,
    Value<int>? cardsReviewed,
    Value<int>? againCount,
    Value<int>? hardCount,
    Value<int>? goodCount,
    Value<int>? easyCount,
    Value<int>? rowid,
  }) {
    return StudySessionsCompanion(
      id: id ?? this.id,
      deckId: deckId ?? this.deckId,
      startedAt: startedAt ?? this.startedAt,
      completedAt: completedAt ?? this.completedAt,
      cardsReviewed: cardsReviewed ?? this.cardsReviewed,
      againCount: againCount ?? this.againCount,
      hardCount: hardCount ?? this.hardCount,
      goodCount: goodCount ?? this.goodCount,
      easyCount: easyCount ?? this.easyCount,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (deckId.present) {
      map['deck_id'] = Variable<String>(deckId.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (cardsReviewed.present) {
      map['cards_reviewed'] = Variable<int>(cardsReviewed.value);
    }
    if (againCount.present) {
      map['again_count'] = Variable<int>(againCount.value);
    }
    if (hardCount.present) {
      map['hard_count'] = Variable<int>(hardCount.value);
    }
    if (goodCount.present) {
      map['good_count'] = Variable<int>(goodCount.value);
    }
    if (easyCount.present) {
      map['easy_count'] = Variable<int>(easyCount.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StudySessionsCompanion(')
          ..write('id: $id, ')
          ..write('deckId: $deckId, ')
          ..write('startedAt: $startedAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('cardsReviewed: $cardsReviewed, ')
          ..write('againCount: $againCount, ')
          ..write('hardCount: $hardCount, ')
          ..write('goodCount: $goodCount, ')
          ..write('easyCount: $easyCount, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ReviewResultsTable extends ReviewResults
    with TableInfo<$ReviewResultsTable, ReviewResultRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReviewResultsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sessionIdMeta = const VerificationMeta(
    'sessionId',
  );
  @override
  late final GeneratedColumn<String> sessionId = GeneratedColumn<String>(
    'session_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES study_sessions (id)',
    ),
  );
  static const VerificationMeta _cardIdMeta = const VerificationMeta('cardId');
  @override
  late final GeneratedColumn<String> cardId = GeneratedColumn<String>(
    'card_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES flashcards (id)',
    ),
  );
  static const VerificationMeta _gradeMeta = const VerificationMeta('grade');
  @override
  late final GeneratedColumn<String> grade = GeneratedColumn<String>(
    'grade',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _reviewedAtMeta = const VerificationMeta(
    'reviewedAt',
  );
  @override
  late final GeneratedColumn<DateTime> reviewedAt = GeneratedColumn<DateTime>(
    'reviewed_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _previousIntervalDaysMeta =
      const VerificationMeta('previousIntervalDays');
  @override
  late final GeneratedColumn<int> previousIntervalDays = GeneratedColumn<int>(
    'previous_interval_days',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _newIntervalDaysMeta = const VerificationMeta(
    'newIntervalDays',
  );
  @override
  late final GeneratedColumn<int> newIntervalDays = GeneratedColumn<int>(
    'new_interval_days',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _elapsedMillisecondsMeta =
      const VerificationMeta('elapsedMilliseconds');
  @override
  late final GeneratedColumn<int> elapsedMilliseconds = GeneratedColumn<int>(
    'elapsed_milliseconds',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    sessionId,
    cardId,
    grade,
    reviewedAt,
    previousIntervalDays,
    newIntervalDays,
    elapsedMilliseconds,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'review_results';
  @override
  VerificationContext validateIntegrity(
    Insertable<ReviewResultRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('session_id')) {
      context.handle(
        _sessionIdMeta,
        sessionId.isAcceptableOrUnknown(data['session_id']!, _sessionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sessionIdMeta);
    }
    if (data.containsKey('card_id')) {
      context.handle(
        _cardIdMeta,
        cardId.isAcceptableOrUnknown(data['card_id']!, _cardIdMeta),
      );
    } else if (isInserting) {
      context.missing(_cardIdMeta);
    }
    if (data.containsKey('grade')) {
      context.handle(
        _gradeMeta,
        grade.isAcceptableOrUnknown(data['grade']!, _gradeMeta),
      );
    } else if (isInserting) {
      context.missing(_gradeMeta);
    }
    if (data.containsKey('reviewed_at')) {
      context.handle(
        _reviewedAtMeta,
        reviewedAt.isAcceptableOrUnknown(data['reviewed_at']!, _reviewedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_reviewedAtMeta);
    }
    if (data.containsKey('previous_interval_days')) {
      context.handle(
        _previousIntervalDaysMeta,
        previousIntervalDays.isAcceptableOrUnknown(
          data['previous_interval_days']!,
          _previousIntervalDaysMeta,
        ),
      );
    }
    if (data.containsKey('new_interval_days')) {
      context.handle(
        _newIntervalDaysMeta,
        newIntervalDays.isAcceptableOrUnknown(
          data['new_interval_days']!,
          _newIntervalDaysMeta,
        ),
      );
    }
    if (data.containsKey('elapsed_milliseconds')) {
      context.handle(
        _elapsedMillisecondsMeta,
        elapsedMilliseconds.isAcceptableOrUnknown(
          data['elapsed_milliseconds']!,
          _elapsedMillisecondsMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ReviewResultRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReviewResultRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      sessionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}session_id'],
      )!,
      cardId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}card_id'],
      )!,
      grade: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}grade'],
      )!,
      reviewedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}reviewed_at'],
      )!,
      previousIntervalDays: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}previous_interval_days'],
      ),
      newIntervalDays: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}new_interval_days'],
      ),
      elapsedMilliseconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}elapsed_milliseconds'],
      ),
    );
  }

  @override
  $ReviewResultsTable createAlias(String alias) {
    return $ReviewResultsTable(attachedDatabase, alias);
  }
}

class ReviewResultRow extends DataClass implements Insertable<ReviewResultRow> {
  final String id;
  final String sessionId;
  final String cardId;
  final String grade;
  final DateTime reviewedAt;
  final int? previousIntervalDays;
  final int? newIntervalDays;
  final int? elapsedMilliseconds;
  const ReviewResultRow({
    required this.id,
    required this.sessionId,
    required this.cardId,
    required this.grade,
    required this.reviewedAt,
    this.previousIntervalDays,
    this.newIntervalDays,
    this.elapsedMilliseconds,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['session_id'] = Variable<String>(sessionId);
    map['card_id'] = Variable<String>(cardId);
    map['grade'] = Variable<String>(grade);
    map['reviewed_at'] = Variable<DateTime>(reviewedAt);
    if (!nullToAbsent || previousIntervalDays != null) {
      map['previous_interval_days'] = Variable<int>(previousIntervalDays);
    }
    if (!nullToAbsent || newIntervalDays != null) {
      map['new_interval_days'] = Variable<int>(newIntervalDays);
    }
    if (!nullToAbsent || elapsedMilliseconds != null) {
      map['elapsed_milliseconds'] = Variable<int>(elapsedMilliseconds);
    }
    return map;
  }

  ReviewResultsCompanion toCompanion(bool nullToAbsent) {
    return ReviewResultsCompanion(
      id: Value(id),
      sessionId: Value(sessionId),
      cardId: Value(cardId),
      grade: Value(grade),
      reviewedAt: Value(reviewedAt),
      previousIntervalDays: previousIntervalDays == null && nullToAbsent
          ? const Value.absent()
          : Value(previousIntervalDays),
      newIntervalDays: newIntervalDays == null && nullToAbsent
          ? const Value.absent()
          : Value(newIntervalDays),
      elapsedMilliseconds: elapsedMilliseconds == null && nullToAbsent
          ? const Value.absent()
          : Value(elapsedMilliseconds),
    );
  }

  factory ReviewResultRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReviewResultRow(
      id: serializer.fromJson<String>(json['id']),
      sessionId: serializer.fromJson<String>(json['sessionId']),
      cardId: serializer.fromJson<String>(json['cardId']),
      grade: serializer.fromJson<String>(json['grade']),
      reviewedAt: serializer.fromJson<DateTime>(json['reviewedAt']),
      previousIntervalDays: serializer.fromJson<int?>(
        json['previousIntervalDays'],
      ),
      newIntervalDays: serializer.fromJson<int?>(json['newIntervalDays']),
      elapsedMilliseconds: serializer.fromJson<int?>(
        json['elapsedMilliseconds'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'sessionId': serializer.toJson<String>(sessionId),
      'cardId': serializer.toJson<String>(cardId),
      'grade': serializer.toJson<String>(grade),
      'reviewedAt': serializer.toJson<DateTime>(reviewedAt),
      'previousIntervalDays': serializer.toJson<int?>(previousIntervalDays),
      'newIntervalDays': serializer.toJson<int?>(newIntervalDays),
      'elapsedMilliseconds': serializer.toJson<int?>(elapsedMilliseconds),
    };
  }

  ReviewResultRow copyWith({
    String? id,
    String? sessionId,
    String? cardId,
    String? grade,
    DateTime? reviewedAt,
    Value<int?> previousIntervalDays = const Value.absent(),
    Value<int?> newIntervalDays = const Value.absent(),
    Value<int?> elapsedMilliseconds = const Value.absent(),
  }) => ReviewResultRow(
    id: id ?? this.id,
    sessionId: sessionId ?? this.sessionId,
    cardId: cardId ?? this.cardId,
    grade: grade ?? this.grade,
    reviewedAt: reviewedAt ?? this.reviewedAt,
    previousIntervalDays: previousIntervalDays.present
        ? previousIntervalDays.value
        : this.previousIntervalDays,
    newIntervalDays: newIntervalDays.present
        ? newIntervalDays.value
        : this.newIntervalDays,
    elapsedMilliseconds: elapsedMilliseconds.present
        ? elapsedMilliseconds.value
        : this.elapsedMilliseconds,
  );
  ReviewResultRow copyWithCompanion(ReviewResultsCompanion data) {
    return ReviewResultRow(
      id: data.id.present ? data.id.value : this.id,
      sessionId: data.sessionId.present ? data.sessionId.value : this.sessionId,
      cardId: data.cardId.present ? data.cardId.value : this.cardId,
      grade: data.grade.present ? data.grade.value : this.grade,
      reviewedAt: data.reviewedAt.present
          ? data.reviewedAt.value
          : this.reviewedAt,
      previousIntervalDays: data.previousIntervalDays.present
          ? data.previousIntervalDays.value
          : this.previousIntervalDays,
      newIntervalDays: data.newIntervalDays.present
          ? data.newIntervalDays.value
          : this.newIntervalDays,
      elapsedMilliseconds: data.elapsedMilliseconds.present
          ? data.elapsedMilliseconds.value
          : this.elapsedMilliseconds,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ReviewResultRow(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('cardId: $cardId, ')
          ..write('grade: $grade, ')
          ..write('reviewedAt: $reviewedAt, ')
          ..write('previousIntervalDays: $previousIntervalDays, ')
          ..write('newIntervalDays: $newIntervalDays, ')
          ..write('elapsedMilliseconds: $elapsedMilliseconds')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    sessionId,
    cardId,
    grade,
    reviewedAt,
    previousIntervalDays,
    newIntervalDays,
    elapsedMilliseconds,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReviewResultRow &&
          other.id == this.id &&
          other.sessionId == this.sessionId &&
          other.cardId == this.cardId &&
          other.grade == this.grade &&
          other.reviewedAt == this.reviewedAt &&
          other.previousIntervalDays == this.previousIntervalDays &&
          other.newIntervalDays == this.newIntervalDays &&
          other.elapsedMilliseconds == this.elapsedMilliseconds);
}

class ReviewResultsCompanion extends UpdateCompanion<ReviewResultRow> {
  final Value<String> id;
  final Value<String> sessionId;
  final Value<String> cardId;
  final Value<String> grade;
  final Value<DateTime> reviewedAt;
  final Value<int?> previousIntervalDays;
  final Value<int?> newIntervalDays;
  final Value<int?> elapsedMilliseconds;
  final Value<int> rowid;
  const ReviewResultsCompanion({
    this.id = const Value.absent(),
    this.sessionId = const Value.absent(),
    this.cardId = const Value.absent(),
    this.grade = const Value.absent(),
    this.reviewedAt = const Value.absent(),
    this.previousIntervalDays = const Value.absent(),
    this.newIntervalDays = const Value.absent(),
    this.elapsedMilliseconds = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ReviewResultsCompanion.insert({
    required String id,
    required String sessionId,
    required String cardId,
    required String grade,
    required DateTime reviewedAt,
    this.previousIntervalDays = const Value.absent(),
    this.newIntervalDays = const Value.absent(),
    this.elapsedMilliseconds = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       sessionId = Value(sessionId),
       cardId = Value(cardId),
       grade = Value(grade),
       reviewedAt = Value(reviewedAt);
  static Insertable<ReviewResultRow> custom({
    Expression<String>? id,
    Expression<String>? sessionId,
    Expression<String>? cardId,
    Expression<String>? grade,
    Expression<DateTime>? reviewedAt,
    Expression<int>? previousIntervalDays,
    Expression<int>? newIntervalDays,
    Expression<int>? elapsedMilliseconds,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sessionId != null) 'session_id': sessionId,
      if (cardId != null) 'card_id': cardId,
      if (grade != null) 'grade': grade,
      if (reviewedAt != null) 'reviewed_at': reviewedAt,
      if (previousIntervalDays != null)
        'previous_interval_days': previousIntervalDays,
      if (newIntervalDays != null) 'new_interval_days': newIntervalDays,
      if (elapsedMilliseconds != null)
        'elapsed_milliseconds': elapsedMilliseconds,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ReviewResultsCompanion copyWith({
    Value<String>? id,
    Value<String>? sessionId,
    Value<String>? cardId,
    Value<String>? grade,
    Value<DateTime>? reviewedAt,
    Value<int?>? previousIntervalDays,
    Value<int?>? newIntervalDays,
    Value<int?>? elapsedMilliseconds,
    Value<int>? rowid,
  }) {
    return ReviewResultsCompanion(
      id: id ?? this.id,
      sessionId: sessionId ?? this.sessionId,
      cardId: cardId ?? this.cardId,
      grade: grade ?? this.grade,
      reviewedAt: reviewedAt ?? this.reviewedAt,
      previousIntervalDays: previousIntervalDays ?? this.previousIntervalDays,
      newIntervalDays: newIntervalDays ?? this.newIntervalDays,
      elapsedMilliseconds: elapsedMilliseconds ?? this.elapsedMilliseconds,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (sessionId.present) {
      map['session_id'] = Variable<String>(sessionId.value);
    }
    if (cardId.present) {
      map['card_id'] = Variable<String>(cardId.value);
    }
    if (grade.present) {
      map['grade'] = Variable<String>(grade.value);
    }
    if (reviewedAt.present) {
      map['reviewed_at'] = Variable<DateTime>(reviewedAt.value);
    }
    if (previousIntervalDays.present) {
      map['previous_interval_days'] = Variable<int>(previousIntervalDays.value);
    }
    if (newIntervalDays.present) {
      map['new_interval_days'] = Variable<int>(newIntervalDays.value);
    }
    if (elapsedMilliseconds.present) {
      map['elapsed_milliseconds'] = Variable<int>(elapsedMilliseconds.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReviewResultsCompanion(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('cardId: $cardId, ')
          ..write('grade: $grade, ')
          ..write('reviewedAt: $reviewedAt, ')
          ..write('previousIntervalDays: $previousIntervalDays, ')
          ..write('newIntervalDays: $newIntervalDays, ')
          ..write('elapsedMilliseconds: $elapsedMilliseconds, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DocumentImportsTable extends DocumentImports
    with TableInfo<$DocumentImportsTable, DocumentImportRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DocumentImportsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fileNameMeta = const VerificationMeta(
    'fileName',
  );
  @override
  late final GeneratedColumn<String> fileName = GeneratedColumn<String>(
    'file_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _byteSizeMeta = const VerificationMeta(
    'byteSize',
  );
  @override
  late final GeneratedColumn<int> byteSize = GeneratedColumn<int>(
    'byte_size',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contentHashMeta = const VerificationMeta(
    'contentHash',
  );
  @override
  late final GeneratedColumn<String> contentHash = GeneratedColumn<String>(
    'content_hash',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _pageCountMeta = const VerificationMeta(
    'pageCount',
  );
  @override
  late final GeneratedColumn<int> pageCount = GeneratedColumn<int>(
    'page_count',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _textCharacterCountMeta =
      const VerificationMeta('textCharacterCount');
  @override
  late final GeneratedColumn<int> textCharacterCount = GeneratedColumn<int>(
    'text_character_count',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _errorMessageMeta = const VerificationMeta(
    'errorMessage',
  );
  @override
  late final GeneratedColumn<String> errorMessage = GeneratedColumn<String>(
    'error_message',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _discardedAtMeta = const VerificationMeta(
    'discardedAt',
  );
  @override
  late final GeneratedColumn<DateTime> discardedAt = GeneratedColumn<DateTime>(
    'discarded_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    fileName,
    byteSize,
    contentHash,
    pageCount,
    textCharacterCount,
    status,
    errorMessage,
    createdAt,
    updatedAt,
    discardedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'document_imports';
  @override
  VerificationContext validateIntegrity(
    Insertable<DocumentImportRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('file_name')) {
      context.handle(
        _fileNameMeta,
        fileName.isAcceptableOrUnknown(data['file_name']!, _fileNameMeta),
      );
    } else if (isInserting) {
      context.missing(_fileNameMeta);
    }
    if (data.containsKey('byte_size')) {
      context.handle(
        _byteSizeMeta,
        byteSize.isAcceptableOrUnknown(data['byte_size']!, _byteSizeMeta),
      );
    } else if (isInserting) {
      context.missing(_byteSizeMeta);
    }
    if (data.containsKey('content_hash')) {
      context.handle(
        _contentHashMeta,
        contentHash.isAcceptableOrUnknown(
          data['content_hash']!,
          _contentHashMeta,
        ),
      );
    }
    if (data.containsKey('page_count')) {
      context.handle(
        _pageCountMeta,
        pageCount.isAcceptableOrUnknown(data['page_count']!, _pageCountMeta),
      );
    }
    if (data.containsKey('text_character_count')) {
      context.handle(
        _textCharacterCountMeta,
        textCharacterCount.isAcceptableOrUnknown(
          data['text_character_count']!,
          _textCharacterCountMeta,
        ),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('error_message')) {
      context.handle(
        _errorMessageMeta,
        errorMessage.isAcceptableOrUnknown(
          data['error_message']!,
          _errorMessageMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('discarded_at')) {
      context.handle(
        _discardedAtMeta,
        discardedAt.isAcceptableOrUnknown(
          data['discarded_at']!,
          _discardedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DocumentImportRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DocumentImportRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      fileName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}file_name'],
      )!,
      byteSize: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}byte_size'],
      )!,
      contentHash: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content_hash'],
      ),
      pageCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}page_count'],
      ),
      textCharacterCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}text_character_count'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      errorMessage: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}error_message'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      discardedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}discarded_at'],
      ),
    );
  }

  @override
  $DocumentImportsTable createAlias(String alias) {
    return $DocumentImportsTable(attachedDatabase, alias);
  }
}

class DocumentImportRow extends DataClass
    implements Insertable<DocumentImportRow> {
  final String id;
  final String fileName;
  final int byteSize;
  final String? contentHash;
  final int? pageCount;
  final int? textCharacterCount;
  final String status;
  final String? errorMessage;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? discardedAt;
  const DocumentImportRow({
    required this.id,
    required this.fileName,
    required this.byteSize,
    this.contentHash,
    this.pageCount,
    this.textCharacterCount,
    required this.status,
    this.errorMessage,
    required this.createdAt,
    required this.updatedAt,
    this.discardedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['file_name'] = Variable<String>(fileName);
    map['byte_size'] = Variable<int>(byteSize);
    if (!nullToAbsent || contentHash != null) {
      map['content_hash'] = Variable<String>(contentHash);
    }
    if (!nullToAbsent || pageCount != null) {
      map['page_count'] = Variable<int>(pageCount);
    }
    if (!nullToAbsent || textCharacterCount != null) {
      map['text_character_count'] = Variable<int>(textCharacterCount);
    }
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || errorMessage != null) {
      map['error_message'] = Variable<String>(errorMessage);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || discardedAt != null) {
      map['discarded_at'] = Variable<DateTime>(discardedAt);
    }
    return map;
  }

  DocumentImportsCompanion toCompanion(bool nullToAbsent) {
    return DocumentImportsCompanion(
      id: Value(id),
      fileName: Value(fileName),
      byteSize: Value(byteSize),
      contentHash: contentHash == null && nullToAbsent
          ? const Value.absent()
          : Value(contentHash),
      pageCount: pageCount == null && nullToAbsent
          ? const Value.absent()
          : Value(pageCount),
      textCharacterCount: textCharacterCount == null && nullToAbsent
          ? const Value.absent()
          : Value(textCharacterCount),
      status: Value(status),
      errorMessage: errorMessage == null && nullToAbsent
          ? const Value.absent()
          : Value(errorMessage),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      discardedAt: discardedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(discardedAt),
    );
  }

  factory DocumentImportRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DocumentImportRow(
      id: serializer.fromJson<String>(json['id']),
      fileName: serializer.fromJson<String>(json['fileName']),
      byteSize: serializer.fromJson<int>(json['byteSize']),
      contentHash: serializer.fromJson<String?>(json['contentHash']),
      pageCount: serializer.fromJson<int?>(json['pageCount']),
      textCharacterCount: serializer.fromJson<int?>(json['textCharacterCount']),
      status: serializer.fromJson<String>(json['status']),
      errorMessage: serializer.fromJson<String?>(json['errorMessage']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      discardedAt: serializer.fromJson<DateTime?>(json['discardedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'fileName': serializer.toJson<String>(fileName),
      'byteSize': serializer.toJson<int>(byteSize),
      'contentHash': serializer.toJson<String?>(contentHash),
      'pageCount': serializer.toJson<int?>(pageCount),
      'textCharacterCount': serializer.toJson<int?>(textCharacterCount),
      'status': serializer.toJson<String>(status),
      'errorMessage': serializer.toJson<String?>(errorMessage),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'discardedAt': serializer.toJson<DateTime?>(discardedAt),
    };
  }

  DocumentImportRow copyWith({
    String? id,
    String? fileName,
    int? byteSize,
    Value<String?> contentHash = const Value.absent(),
    Value<int?> pageCount = const Value.absent(),
    Value<int?> textCharacterCount = const Value.absent(),
    String? status,
    Value<String?> errorMessage = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> discardedAt = const Value.absent(),
  }) => DocumentImportRow(
    id: id ?? this.id,
    fileName: fileName ?? this.fileName,
    byteSize: byteSize ?? this.byteSize,
    contentHash: contentHash.present ? contentHash.value : this.contentHash,
    pageCount: pageCount.present ? pageCount.value : this.pageCount,
    textCharacterCount: textCharacterCount.present
        ? textCharacterCount.value
        : this.textCharacterCount,
    status: status ?? this.status,
    errorMessage: errorMessage.present ? errorMessage.value : this.errorMessage,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    discardedAt: discardedAt.present ? discardedAt.value : this.discardedAt,
  );
  DocumentImportRow copyWithCompanion(DocumentImportsCompanion data) {
    return DocumentImportRow(
      id: data.id.present ? data.id.value : this.id,
      fileName: data.fileName.present ? data.fileName.value : this.fileName,
      byteSize: data.byteSize.present ? data.byteSize.value : this.byteSize,
      contentHash: data.contentHash.present
          ? data.contentHash.value
          : this.contentHash,
      pageCount: data.pageCount.present ? data.pageCount.value : this.pageCount,
      textCharacterCount: data.textCharacterCount.present
          ? data.textCharacterCount.value
          : this.textCharacterCount,
      status: data.status.present ? data.status.value : this.status,
      errorMessage: data.errorMessage.present
          ? data.errorMessage.value
          : this.errorMessage,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      discardedAt: data.discardedAt.present
          ? data.discardedAt.value
          : this.discardedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DocumentImportRow(')
          ..write('id: $id, ')
          ..write('fileName: $fileName, ')
          ..write('byteSize: $byteSize, ')
          ..write('contentHash: $contentHash, ')
          ..write('pageCount: $pageCount, ')
          ..write('textCharacterCount: $textCharacterCount, ')
          ..write('status: $status, ')
          ..write('errorMessage: $errorMessage, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('discardedAt: $discardedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    fileName,
    byteSize,
    contentHash,
    pageCount,
    textCharacterCount,
    status,
    errorMessage,
    createdAt,
    updatedAt,
    discardedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DocumentImportRow &&
          other.id == this.id &&
          other.fileName == this.fileName &&
          other.byteSize == this.byteSize &&
          other.contentHash == this.contentHash &&
          other.pageCount == this.pageCount &&
          other.textCharacterCount == this.textCharacterCount &&
          other.status == this.status &&
          other.errorMessage == this.errorMessage &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.discardedAt == this.discardedAt);
}

class DocumentImportsCompanion extends UpdateCompanion<DocumentImportRow> {
  final Value<String> id;
  final Value<String> fileName;
  final Value<int> byteSize;
  final Value<String?> contentHash;
  final Value<int?> pageCount;
  final Value<int?> textCharacterCount;
  final Value<String> status;
  final Value<String?> errorMessage;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> discardedAt;
  final Value<int> rowid;
  const DocumentImportsCompanion({
    this.id = const Value.absent(),
    this.fileName = const Value.absent(),
    this.byteSize = const Value.absent(),
    this.contentHash = const Value.absent(),
    this.pageCount = const Value.absent(),
    this.textCharacterCount = const Value.absent(),
    this.status = const Value.absent(),
    this.errorMessage = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.discardedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DocumentImportsCompanion.insert({
    required String id,
    required String fileName,
    required int byteSize,
    this.contentHash = const Value.absent(),
    this.pageCount = const Value.absent(),
    this.textCharacterCount = const Value.absent(),
    required String status,
    this.errorMessage = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.discardedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       fileName = Value(fileName),
       byteSize = Value(byteSize),
       status = Value(status),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<DocumentImportRow> custom({
    Expression<String>? id,
    Expression<String>? fileName,
    Expression<int>? byteSize,
    Expression<String>? contentHash,
    Expression<int>? pageCount,
    Expression<int>? textCharacterCount,
    Expression<String>? status,
    Expression<String>? errorMessage,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? discardedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (fileName != null) 'file_name': fileName,
      if (byteSize != null) 'byte_size': byteSize,
      if (contentHash != null) 'content_hash': contentHash,
      if (pageCount != null) 'page_count': pageCount,
      if (textCharacterCount != null)
        'text_character_count': textCharacterCount,
      if (status != null) 'status': status,
      if (errorMessage != null) 'error_message': errorMessage,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (discardedAt != null) 'discarded_at': discardedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DocumentImportsCompanion copyWith({
    Value<String>? id,
    Value<String>? fileName,
    Value<int>? byteSize,
    Value<String?>? contentHash,
    Value<int?>? pageCount,
    Value<int?>? textCharacterCount,
    Value<String>? status,
    Value<String?>? errorMessage,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? discardedAt,
    Value<int>? rowid,
  }) {
    return DocumentImportsCompanion(
      id: id ?? this.id,
      fileName: fileName ?? this.fileName,
      byteSize: byteSize ?? this.byteSize,
      contentHash: contentHash ?? this.contentHash,
      pageCount: pageCount ?? this.pageCount,
      textCharacterCount: textCharacterCount ?? this.textCharacterCount,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      discardedAt: discardedAt ?? this.discardedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (fileName.present) {
      map['file_name'] = Variable<String>(fileName.value);
    }
    if (byteSize.present) {
      map['byte_size'] = Variable<int>(byteSize.value);
    }
    if (contentHash.present) {
      map['content_hash'] = Variable<String>(contentHash.value);
    }
    if (pageCount.present) {
      map['page_count'] = Variable<int>(pageCount.value);
    }
    if (textCharacterCount.present) {
      map['text_character_count'] = Variable<int>(textCharacterCount.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (errorMessage.present) {
      map['error_message'] = Variable<String>(errorMessage.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (discardedAt.present) {
      map['discarded_at'] = Variable<DateTime>(discardedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DocumentImportsCompanion(')
          ..write('id: $id, ')
          ..write('fileName: $fileName, ')
          ..write('byteSize: $byteSize, ')
          ..write('contentHash: $contentHash, ')
          ..write('pageCount: $pageCount, ')
          ..write('textCharacterCount: $textCharacterCount, ')
          ..write('status: $status, ')
          ..write('errorMessage: $errorMessage, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('discardedAt: $discardedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $GenerationUsageRecordsTable extends GenerationUsageRecords
    with TableInfo<$GenerationUsageRecordsTable, GenerationUsageRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GenerationUsageRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _documentImportIdMeta = const VerificationMeta(
    'documentImportId',
  );
  @override
  late final GeneratedColumn<String> documentImportId = GeneratedColumn<String>(
    'document_import_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES document_imports (id)',
    ),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _documentBytesMeta = const VerificationMeta(
    'documentBytes',
  );
  @override
  late final GeneratedColumn<int> documentBytes = GeneratedColumn<int>(
    'document_bytes',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _promptTokensMeta = const VerificationMeta(
    'promptTokens',
  );
  @override
  late final GeneratedColumn<int> promptTokens = GeneratedColumn<int>(
    'prompt_tokens',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _completionTokensMeta = const VerificationMeta(
    'completionTokens',
  );
  @override
  late final GeneratedColumn<int> completionTokens = GeneratedColumn<int>(
    'completion_tokens',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _cardCountMeta = const VerificationMeta(
    'cardCount',
  );
  @override
  late final GeneratedColumn<int> cardCount = GeneratedColumn<int>(
    'card_count',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _estimatedCostUsdMeta = const VerificationMeta(
    'estimatedCostUsd',
  );
  @override
  late final GeneratedColumn<double> estimatedCostUsd = GeneratedColumn<double>(
    'estimated_cost_usd',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _failureCodeMeta = const VerificationMeta(
    'failureCode',
  );
  @override
  late final GeneratedColumn<String> failureCode = GeneratedColumn<String>(
    'failure_code',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    documentImportId,
    createdAt,
    status,
    documentBytes,
    promptTokens,
    completionTokens,
    cardCount,
    estimatedCostUsd,
    failureCode,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'generation_usage_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<GenerationUsageRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('document_import_id')) {
      context.handle(
        _documentImportIdMeta,
        documentImportId.isAcceptableOrUnknown(
          data['document_import_id']!,
          _documentImportIdMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('document_bytes')) {
      context.handle(
        _documentBytesMeta,
        documentBytes.isAcceptableOrUnknown(
          data['document_bytes']!,
          _documentBytesMeta,
        ),
      );
    }
    if (data.containsKey('prompt_tokens')) {
      context.handle(
        _promptTokensMeta,
        promptTokens.isAcceptableOrUnknown(
          data['prompt_tokens']!,
          _promptTokensMeta,
        ),
      );
    }
    if (data.containsKey('completion_tokens')) {
      context.handle(
        _completionTokensMeta,
        completionTokens.isAcceptableOrUnknown(
          data['completion_tokens']!,
          _completionTokensMeta,
        ),
      );
    }
    if (data.containsKey('card_count')) {
      context.handle(
        _cardCountMeta,
        cardCount.isAcceptableOrUnknown(data['card_count']!, _cardCountMeta),
      );
    }
    if (data.containsKey('estimated_cost_usd')) {
      context.handle(
        _estimatedCostUsdMeta,
        estimatedCostUsd.isAcceptableOrUnknown(
          data['estimated_cost_usd']!,
          _estimatedCostUsdMeta,
        ),
      );
    }
    if (data.containsKey('failure_code')) {
      context.handle(
        _failureCodeMeta,
        failureCode.isAcceptableOrUnknown(
          data['failure_code']!,
          _failureCodeMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GenerationUsageRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GenerationUsageRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      documentImportId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}document_import_id'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      documentBytes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}document_bytes'],
      ),
      promptTokens: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}prompt_tokens'],
      ),
      completionTokens: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}completion_tokens'],
      ),
      cardCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}card_count'],
      ),
      estimatedCostUsd: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}estimated_cost_usd'],
      ),
      failureCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}failure_code'],
      ),
    );
  }

  @override
  $GenerationUsageRecordsTable createAlias(String alias) {
    return $GenerationUsageRecordsTable(attachedDatabase, alias);
  }
}

class GenerationUsageRow extends DataClass
    implements Insertable<GenerationUsageRow> {
  final String id;
  final String? documentImportId;
  final DateTime createdAt;
  final String status;
  final int? documentBytes;
  final int? promptTokens;
  final int? completionTokens;
  final int? cardCount;
  final double? estimatedCostUsd;
  final String? failureCode;
  const GenerationUsageRow({
    required this.id,
    this.documentImportId,
    required this.createdAt,
    required this.status,
    this.documentBytes,
    this.promptTokens,
    this.completionTokens,
    this.cardCount,
    this.estimatedCostUsd,
    this.failureCode,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || documentImportId != null) {
      map['document_import_id'] = Variable<String>(documentImportId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || documentBytes != null) {
      map['document_bytes'] = Variable<int>(documentBytes);
    }
    if (!nullToAbsent || promptTokens != null) {
      map['prompt_tokens'] = Variable<int>(promptTokens);
    }
    if (!nullToAbsent || completionTokens != null) {
      map['completion_tokens'] = Variable<int>(completionTokens);
    }
    if (!nullToAbsent || cardCount != null) {
      map['card_count'] = Variable<int>(cardCount);
    }
    if (!nullToAbsent || estimatedCostUsd != null) {
      map['estimated_cost_usd'] = Variable<double>(estimatedCostUsd);
    }
    if (!nullToAbsent || failureCode != null) {
      map['failure_code'] = Variable<String>(failureCode);
    }
    return map;
  }

  GenerationUsageRecordsCompanion toCompanion(bool nullToAbsent) {
    return GenerationUsageRecordsCompanion(
      id: Value(id),
      documentImportId: documentImportId == null && nullToAbsent
          ? const Value.absent()
          : Value(documentImportId),
      createdAt: Value(createdAt),
      status: Value(status),
      documentBytes: documentBytes == null && nullToAbsent
          ? const Value.absent()
          : Value(documentBytes),
      promptTokens: promptTokens == null && nullToAbsent
          ? const Value.absent()
          : Value(promptTokens),
      completionTokens: completionTokens == null && nullToAbsent
          ? const Value.absent()
          : Value(completionTokens),
      cardCount: cardCount == null && nullToAbsent
          ? const Value.absent()
          : Value(cardCount),
      estimatedCostUsd: estimatedCostUsd == null && nullToAbsent
          ? const Value.absent()
          : Value(estimatedCostUsd),
      failureCode: failureCode == null && nullToAbsent
          ? const Value.absent()
          : Value(failureCode),
    );
  }

  factory GenerationUsageRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GenerationUsageRow(
      id: serializer.fromJson<String>(json['id']),
      documentImportId: serializer.fromJson<String?>(json['documentImportId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      status: serializer.fromJson<String>(json['status']),
      documentBytes: serializer.fromJson<int?>(json['documentBytes']),
      promptTokens: serializer.fromJson<int?>(json['promptTokens']),
      completionTokens: serializer.fromJson<int?>(json['completionTokens']),
      cardCount: serializer.fromJson<int?>(json['cardCount']),
      estimatedCostUsd: serializer.fromJson<double?>(json['estimatedCostUsd']),
      failureCode: serializer.fromJson<String?>(json['failureCode']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'documentImportId': serializer.toJson<String?>(documentImportId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'status': serializer.toJson<String>(status),
      'documentBytes': serializer.toJson<int?>(documentBytes),
      'promptTokens': serializer.toJson<int?>(promptTokens),
      'completionTokens': serializer.toJson<int?>(completionTokens),
      'cardCount': serializer.toJson<int?>(cardCount),
      'estimatedCostUsd': serializer.toJson<double?>(estimatedCostUsd),
      'failureCode': serializer.toJson<String?>(failureCode),
    };
  }

  GenerationUsageRow copyWith({
    String? id,
    Value<String?> documentImportId = const Value.absent(),
    DateTime? createdAt,
    String? status,
    Value<int?> documentBytes = const Value.absent(),
    Value<int?> promptTokens = const Value.absent(),
    Value<int?> completionTokens = const Value.absent(),
    Value<int?> cardCount = const Value.absent(),
    Value<double?> estimatedCostUsd = const Value.absent(),
    Value<String?> failureCode = const Value.absent(),
  }) => GenerationUsageRow(
    id: id ?? this.id,
    documentImportId: documentImportId.present
        ? documentImportId.value
        : this.documentImportId,
    createdAt: createdAt ?? this.createdAt,
    status: status ?? this.status,
    documentBytes: documentBytes.present
        ? documentBytes.value
        : this.documentBytes,
    promptTokens: promptTokens.present ? promptTokens.value : this.promptTokens,
    completionTokens: completionTokens.present
        ? completionTokens.value
        : this.completionTokens,
    cardCount: cardCount.present ? cardCount.value : this.cardCount,
    estimatedCostUsd: estimatedCostUsd.present
        ? estimatedCostUsd.value
        : this.estimatedCostUsd,
    failureCode: failureCode.present ? failureCode.value : this.failureCode,
  );
  GenerationUsageRow copyWithCompanion(GenerationUsageRecordsCompanion data) {
    return GenerationUsageRow(
      id: data.id.present ? data.id.value : this.id,
      documentImportId: data.documentImportId.present
          ? data.documentImportId.value
          : this.documentImportId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      status: data.status.present ? data.status.value : this.status,
      documentBytes: data.documentBytes.present
          ? data.documentBytes.value
          : this.documentBytes,
      promptTokens: data.promptTokens.present
          ? data.promptTokens.value
          : this.promptTokens,
      completionTokens: data.completionTokens.present
          ? data.completionTokens.value
          : this.completionTokens,
      cardCount: data.cardCount.present ? data.cardCount.value : this.cardCount,
      estimatedCostUsd: data.estimatedCostUsd.present
          ? data.estimatedCostUsd.value
          : this.estimatedCostUsd,
      failureCode: data.failureCode.present
          ? data.failureCode.value
          : this.failureCode,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GenerationUsageRow(')
          ..write('id: $id, ')
          ..write('documentImportId: $documentImportId, ')
          ..write('createdAt: $createdAt, ')
          ..write('status: $status, ')
          ..write('documentBytes: $documentBytes, ')
          ..write('promptTokens: $promptTokens, ')
          ..write('completionTokens: $completionTokens, ')
          ..write('cardCount: $cardCount, ')
          ..write('estimatedCostUsd: $estimatedCostUsd, ')
          ..write('failureCode: $failureCode')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    documentImportId,
    createdAt,
    status,
    documentBytes,
    promptTokens,
    completionTokens,
    cardCount,
    estimatedCostUsd,
    failureCode,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GenerationUsageRow &&
          other.id == this.id &&
          other.documentImportId == this.documentImportId &&
          other.createdAt == this.createdAt &&
          other.status == this.status &&
          other.documentBytes == this.documentBytes &&
          other.promptTokens == this.promptTokens &&
          other.completionTokens == this.completionTokens &&
          other.cardCount == this.cardCount &&
          other.estimatedCostUsd == this.estimatedCostUsd &&
          other.failureCode == this.failureCode);
}

class GenerationUsageRecordsCompanion
    extends UpdateCompanion<GenerationUsageRow> {
  final Value<String> id;
  final Value<String?> documentImportId;
  final Value<DateTime> createdAt;
  final Value<String> status;
  final Value<int?> documentBytes;
  final Value<int?> promptTokens;
  final Value<int?> completionTokens;
  final Value<int?> cardCount;
  final Value<double?> estimatedCostUsd;
  final Value<String?> failureCode;
  final Value<int> rowid;
  const GenerationUsageRecordsCompanion({
    this.id = const Value.absent(),
    this.documentImportId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.status = const Value.absent(),
    this.documentBytes = const Value.absent(),
    this.promptTokens = const Value.absent(),
    this.completionTokens = const Value.absent(),
    this.cardCount = const Value.absent(),
    this.estimatedCostUsd = const Value.absent(),
    this.failureCode = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GenerationUsageRecordsCompanion.insert({
    required String id,
    this.documentImportId = const Value.absent(),
    required DateTime createdAt,
    required String status,
    this.documentBytes = const Value.absent(),
    this.promptTokens = const Value.absent(),
    this.completionTokens = const Value.absent(),
    this.cardCount = const Value.absent(),
    this.estimatedCostUsd = const Value.absent(),
    this.failureCode = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       createdAt = Value(createdAt),
       status = Value(status);
  static Insertable<GenerationUsageRow> custom({
    Expression<String>? id,
    Expression<String>? documentImportId,
    Expression<DateTime>? createdAt,
    Expression<String>? status,
    Expression<int>? documentBytes,
    Expression<int>? promptTokens,
    Expression<int>? completionTokens,
    Expression<int>? cardCount,
    Expression<double>? estimatedCostUsd,
    Expression<String>? failureCode,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (documentImportId != null) 'document_import_id': documentImportId,
      if (createdAt != null) 'created_at': createdAt,
      if (status != null) 'status': status,
      if (documentBytes != null) 'document_bytes': documentBytes,
      if (promptTokens != null) 'prompt_tokens': promptTokens,
      if (completionTokens != null) 'completion_tokens': completionTokens,
      if (cardCount != null) 'card_count': cardCount,
      if (estimatedCostUsd != null) 'estimated_cost_usd': estimatedCostUsd,
      if (failureCode != null) 'failure_code': failureCode,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GenerationUsageRecordsCompanion copyWith({
    Value<String>? id,
    Value<String?>? documentImportId,
    Value<DateTime>? createdAt,
    Value<String>? status,
    Value<int?>? documentBytes,
    Value<int?>? promptTokens,
    Value<int?>? completionTokens,
    Value<int?>? cardCount,
    Value<double?>? estimatedCostUsd,
    Value<String?>? failureCode,
    Value<int>? rowid,
  }) {
    return GenerationUsageRecordsCompanion(
      id: id ?? this.id,
      documentImportId: documentImportId ?? this.documentImportId,
      createdAt: createdAt ?? this.createdAt,
      status: status ?? this.status,
      documentBytes: documentBytes ?? this.documentBytes,
      promptTokens: promptTokens ?? this.promptTokens,
      completionTokens: completionTokens ?? this.completionTokens,
      cardCount: cardCount ?? this.cardCount,
      estimatedCostUsd: estimatedCostUsd ?? this.estimatedCostUsd,
      failureCode: failureCode ?? this.failureCode,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (documentImportId.present) {
      map['document_import_id'] = Variable<String>(documentImportId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (documentBytes.present) {
      map['document_bytes'] = Variable<int>(documentBytes.value);
    }
    if (promptTokens.present) {
      map['prompt_tokens'] = Variable<int>(promptTokens.value);
    }
    if (completionTokens.present) {
      map['completion_tokens'] = Variable<int>(completionTokens.value);
    }
    if (cardCount.present) {
      map['card_count'] = Variable<int>(cardCount.value);
    }
    if (estimatedCostUsd.present) {
      map['estimated_cost_usd'] = Variable<double>(estimatedCostUsd.value);
    }
    if (failureCode.present) {
      map['failure_code'] = Variable<String>(failureCode.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GenerationUsageRecordsCompanion(')
          ..write('id: $id, ')
          ..write('documentImportId: $documentImportId, ')
          ..write('createdAt: $createdAt, ')
          ..write('status: $status, ')
          ..write('documentBytes: $documentBytes, ')
          ..write('promptTokens: $promptTokens, ')
          ..write('completionTokens: $completionTokens, ')
          ..write('cardCount: $cardCount, ')
          ..write('estimatedCostUsd: $estimatedCostUsd, ')
          ..write('failureCode: $failureCode, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AppPreferencesTable extends AppPreferences
    with TableInfo<$AppPreferencesTable, AppPreferenceRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppPreferencesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _themeModeMeta = const VerificationMeta(
    'themeMode',
  );
  @override
  late final GeneratedColumn<String> themeMode = GeneratedColumn<String>(
    'theme_mode',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('system'),
  );
  static const VerificationMeta _hasCompletedOnboardingMeta =
      const VerificationMeta('hasCompletedOnboarding');
  @override
  late final GeneratedColumn<bool> hasCompletedOnboarding =
      GeneratedColumn<bool>(
        'has_completed_onboarding',
        aliasedName,
        false,
        type: DriftSqlType.bool,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("has_completed_onboarding" IN (0, 1))',
        ),
        defaultValue: const Constant(false),
      );
  @override
  List<GeneratedColumn> get $columns => [id, themeMode, hasCompletedOnboarding];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_preferences';
  @override
  VerificationContext validateIntegrity(
    Insertable<AppPreferenceRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('theme_mode')) {
      context.handle(
        _themeModeMeta,
        themeMode.isAcceptableOrUnknown(data['theme_mode']!, _themeModeMeta),
      );
    }
    if (data.containsKey('has_completed_onboarding')) {
      context.handle(
        _hasCompletedOnboardingMeta,
        hasCompletedOnboarding.isAcceptableOrUnknown(
          data['has_completed_onboarding']!,
          _hasCompletedOnboardingMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AppPreferenceRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppPreferenceRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      themeMode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}theme_mode'],
      )!,
      hasCompletedOnboarding: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}has_completed_onboarding'],
      )!,
    );
  }

  @override
  $AppPreferencesTable createAlias(String alias) {
    return $AppPreferencesTable(attachedDatabase, alias);
  }
}

class AppPreferenceRow extends DataClass
    implements Insertable<AppPreferenceRow> {
  final int id;
  final String themeMode;
  final bool hasCompletedOnboarding;
  const AppPreferenceRow({
    required this.id,
    required this.themeMode,
    required this.hasCompletedOnboarding,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['theme_mode'] = Variable<String>(themeMode);
    map['has_completed_onboarding'] = Variable<bool>(hasCompletedOnboarding);
    return map;
  }

  AppPreferencesCompanion toCompanion(bool nullToAbsent) {
    return AppPreferencesCompanion(
      id: Value(id),
      themeMode: Value(themeMode),
      hasCompletedOnboarding: Value(hasCompletedOnboarding),
    );
  }

  factory AppPreferenceRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppPreferenceRow(
      id: serializer.fromJson<int>(json['id']),
      themeMode: serializer.fromJson<String>(json['themeMode']),
      hasCompletedOnboarding: serializer.fromJson<bool>(
        json['hasCompletedOnboarding'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'themeMode': serializer.toJson<String>(themeMode),
      'hasCompletedOnboarding': serializer.toJson<bool>(hasCompletedOnboarding),
    };
  }

  AppPreferenceRow copyWith({
    int? id,
    String? themeMode,
    bool? hasCompletedOnboarding,
  }) => AppPreferenceRow(
    id: id ?? this.id,
    themeMode: themeMode ?? this.themeMode,
    hasCompletedOnboarding:
        hasCompletedOnboarding ?? this.hasCompletedOnboarding,
  );
  AppPreferenceRow copyWithCompanion(AppPreferencesCompanion data) {
    return AppPreferenceRow(
      id: data.id.present ? data.id.value : this.id,
      themeMode: data.themeMode.present ? data.themeMode.value : this.themeMode,
      hasCompletedOnboarding: data.hasCompletedOnboarding.present
          ? data.hasCompletedOnboarding.value
          : this.hasCompletedOnboarding,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppPreferenceRow(')
          ..write('id: $id, ')
          ..write('themeMode: $themeMode, ')
          ..write('hasCompletedOnboarding: $hasCompletedOnboarding')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, themeMode, hasCompletedOnboarding);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppPreferenceRow &&
          other.id == this.id &&
          other.themeMode == this.themeMode &&
          other.hasCompletedOnboarding == this.hasCompletedOnboarding);
}

class AppPreferencesCompanion extends UpdateCompanion<AppPreferenceRow> {
  final Value<int> id;
  final Value<String> themeMode;
  final Value<bool> hasCompletedOnboarding;
  const AppPreferencesCompanion({
    this.id = const Value.absent(),
    this.themeMode = const Value.absent(),
    this.hasCompletedOnboarding = const Value.absent(),
  });
  AppPreferencesCompanion.insert({
    this.id = const Value.absent(),
    this.themeMode = const Value.absent(),
    this.hasCompletedOnboarding = const Value.absent(),
  });
  static Insertable<AppPreferenceRow> custom({
    Expression<int>? id,
    Expression<String>? themeMode,
    Expression<bool>? hasCompletedOnboarding,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (themeMode != null) 'theme_mode': themeMode,
      if (hasCompletedOnboarding != null)
        'has_completed_onboarding': hasCompletedOnboarding,
    });
  }

  AppPreferencesCompanion copyWith({
    Value<int>? id,
    Value<String>? themeMode,
    Value<bool>? hasCompletedOnboarding,
  }) {
    return AppPreferencesCompanion(
      id: id ?? this.id,
      themeMode: themeMode ?? this.themeMode,
      hasCompletedOnboarding:
          hasCompletedOnboarding ?? this.hasCompletedOnboarding,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (themeMode.present) {
      map['theme_mode'] = Variable<String>(themeMode.value);
    }
    if (hasCompletedOnboarding.present) {
      map['has_completed_onboarding'] = Variable<bool>(
        hasCompletedOnboarding.value,
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppPreferencesCompanion(')
          ..write('id: $id, ')
          ..write('themeMode: $themeMode, ')
          ..write('hasCompletedOnboarding: $hasCompletedOnboarding')
          ..write(')'))
        .toString();
  }
}

class $SyncOutboxEntriesTable extends SyncOutboxEntries
    with TableInfo<$SyncOutboxEntriesTable, SyncOutboxRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncOutboxEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _entityTypeMeta = const VerificationMeta(
    'entityType',
  );
  @override
  late final GeneratedColumn<String> entityType = GeneratedColumn<String>(
    'entity_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _entityIdMeta = const VerificationMeta(
    'entityId',
  );
  @override
  late final GeneratedColumn<String> entityId = GeneratedColumn<String>(
    'entity_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _operationMeta = const VerificationMeta(
    'operation',
  );
  @override
  late final GeneratedColumn<String> operation = GeneratedColumn<String>(
    'operation',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _payloadJsonMeta = const VerificationMeta(
    'payloadJson',
  );
  @override
  late final GeneratedColumn<String> payloadJson = GeneratedColumn<String>(
    'payload_json',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _attemptCountMeta = const VerificationMeta(
    'attemptCount',
  );
  @override
  late final GeneratedColumn<int> attemptCount = GeneratedColumn<int>(
    'attempt_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lastErrorMeta = const VerificationMeta(
    'lastError',
  );
  @override
  late final GeneratedColumn<String> lastError = GeneratedColumn<String>(
    'last_error',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _processedAtMeta = const VerificationMeta(
    'processedAt',
  );
  @override
  late final GeneratedColumn<DateTime> processedAt = GeneratedColumn<DateTime>(
    'processed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    entityType,
    entityId,
    operation,
    payloadJson,
    createdAt,
    attemptCount,
    lastError,
    processedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_outbox_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<SyncOutboxRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('entity_type')) {
      context.handle(
        _entityTypeMeta,
        entityType.isAcceptableOrUnknown(data['entity_type']!, _entityTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_entityTypeMeta);
    }
    if (data.containsKey('entity_id')) {
      context.handle(
        _entityIdMeta,
        entityId.isAcceptableOrUnknown(data['entity_id']!, _entityIdMeta),
      );
    } else if (isInserting) {
      context.missing(_entityIdMeta);
    }
    if (data.containsKey('operation')) {
      context.handle(
        _operationMeta,
        operation.isAcceptableOrUnknown(data['operation']!, _operationMeta),
      );
    } else if (isInserting) {
      context.missing(_operationMeta);
    }
    if (data.containsKey('payload_json')) {
      context.handle(
        _payloadJsonMeta,
        payloadJson.isAcceptableOrUnknown(
          data['payload_json']!,
          _payloadJsonMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('attempt_count')) {
      context.handle(
        _attemptCountMeta,
        attemptCount.isAcceptableOrUnknown(
          data['attempt_count']!,
          _attemptCountMeta,
        ),
      );
    }
    if (data.containsKey('last_error')) {
      context.handle(
        _lastErrorMeta,
        lastError.isAcceptableOrUnknown(data['last_error']!, _lastErrorMeta),
      );
    }
    if (data.containsKey('processed_at')) {
      context.handle(
        _processedAtMeta,
        processedAt.isAcceptableOrUnknown(
          data['processed_at']!,
          _processedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SyncOutboxRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncOutboxRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      entityType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity_type'],
      )!,
      entityId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity_id'],
      )!,
      operation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}operation'],
      )!,
      payloadJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload_json'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      attemptCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}attempt_count'],
      )!,
      lastError: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_error'],
      ),
      processedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}processed_at'],
      ),
    );
  }

  @override
  $SyncOutboxEntriesTable createAlias(String alias) {
    return $SyncOutboxEntriesTable(attachedDatabase, alias);
  }
}

class SyncOutboxRow extends DataClass implements Insertable<SyncOutboxRow> {
  final String id;
  final String entityType;
  final String entityId;
  final String operation;
  final String? payloadJson;
  final DateTime createdAt;
  final int attemptCount;
  final String? lastError;
  final DateTime? processedAt;
  const SyncOutboxRow({
    required this.id,
    required this.entityType,
    required this.entityId,
    required this.operation,
    this.payloadJson,
    required this.createdAt,
    required this.attemptCount,
    this.lastError,
    this.processedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['entity_type'] = Variable<String>(entityType);
    map['entity_id'] = Variable<String>(entityId);
    map['operation'] = Variable<String>(operation);
    if (!nullToAbsent || payloadJson != null) {
      map['payload_json'] = Variable<String>(payloadJson);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['attempt_count'] = Variable<int>(attemptCount);
    if (!nullToAbsent || lastError != null) {
      map['last_error'] = Variable<String>(lastError);
    }
    if (!nullToAbsent || processedAt != null) {
      map['processed_at'] = Variable<DateTime>(processedAt);
    }
    return map;
  }

  SyncOutboxEntriesCompanion toCompanion(bool nullToAbsent) {
    return SyncOutboxEntriesCompanion(
      id: Value(id),
      entityType: Value(entityType),
      entityId: Value(entityId),
      operation: Value(operation),
      payloadJson: payloadJson == null && nullToAbsent
          ? const Value.absent()
          : Value(payloadJson),
      createdAt: Value(createdAt),
      attemptCount: Value(attemptCount),
      lastError: lastError == null && nullToAbsent
          ? const Value.absent()
          : Value(lastError),
      processedAt: processedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(processedAt),
    );
  }

  factory SyncOutboxRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncOutboxRow(
      id: serializer.fromJson<String>(json['id']),
      entityType: serializer.fromJson<String>(json['entityType']),
      entityId: serializer.fromJson<String>(json['entityId']),
      operation: serializer.fromJson<String>(json['operation']),
      payloadJson: serializer.fromJson<String?>(json['payloadJson']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      attemptCount: serializer.fromJson<int>(json['attemptCount']),
      lastError: serializer.fromJson<String?>(json['lastError']),
      processedAt: serializer.fromJson<DateTime?>(json['processedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'entityType': serializer.toJson<String>(entityType),
      'entityId': serializer.toJson<String>(entityId),
      'operation': serializer.toJson<String>(operation),
      'payloadJson': serializer.toJson<String?>(payloadJson),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'attemptCount': serializer.toJson<int>(attemptCount),
      'lastError': serializer.toJson<String?>(lastError),
      'processedAt': serializer.toJson<DateTime?>(processedAt),
    };
  }

  SyncOutboxRow copyWith({
    String? id,
    String? entityType,
    String? entityId,
    String? operation,
    Value<String?> payloadJson = const Value.absent(),
    DateTime? createdAt,
    int? attemptCount,
    Value<String?> lastError = const Value.absent(),
    Value<DateTime?> processedAt = const Value.absent(),
  }) => SyncOutboxRow(
    id: id ?? this.id,
    entityType: entityType ?? this.entityType,
    entityId: entityId ?? this.entityId,
    operation: operation ?? this.operation,
    payloadJson: payloadJson.present ? payloadJson.value : this.payloadJson,
    createdAt: createdAt ?? this.createdAt,
    attemptCount: attemptCount ?? this.attemptCount,
    lastError: lastError.present ? lastError.value : this.lastError,
    processedAt: processedAt.present ? processedAt.value : this.processedAt,
  );
  SyncOutboxRow copyWithCompanion(SyncOutboxEntriesCompanion data) {
    return SyncOutboxRow(
      id: data.id.present ? data.id.value : this.id,
      entityType: data.entityType.present
          ? data.entityType.value
          : this.entityType,
      entityId: data.entityId.present ? data.entityId.value : this.entityId,
      operation: data.operation.present ? data.operation.value : this.operation,
      payloadJson: data.payloadJson.present
          ? data.payloadJson.value
          : this.payloadJson,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      attemptCount: data.attemptCount.present
          ? data.attemptCount.value
          : this.attemptCount,
      lastError: data.lastError.present ? data.lastError.value : this.lastError,
      processedAt: data.processedAt.present
          ? data.processedAt.value
          : this.processedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncOutboxRow(')
          ..write('id: $id, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId, ')
          ..write('operation: $operation, ')
          ..write('payloadJson: $payloadJson, ')
          ..write('createdAt: $createdAt, ')
          ..write('attemptCount: $attemptCount, ')
          ..write('lastError: $lastError, ')
          ..write('processedAt: $processedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    entityType,
    entityId,
    operation,
    payloadJson,
    createdAt,
    attemptCount,
    lastError,
    processedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncOutboxRow &&
          other.id == this.id &&
          other.entityType == this.entityType &&
          other.entityId == this.entityId &&
          other.operation == this.operation &&
          other.payloadJson == this.payloadJson &&
          other.createdAt == this.createdAt &&
          other.attemptCount == this.attemptCount &&
          other.lastError == this.lastError &&
          other.processedAt == this.processedAt);
}

class SyncOutboxEntriesCompanion extends UpdateCompanion<SyncOutboxRow> {
  final Value<String> id;
  final Value<String> entityType;
  final Value<String> entityId;
  final Value<String> operation;
  final Value<String?> payloadJson;
  final Value<DateTime> createdAt;
  final Value<int> attemptCount;
  final Value<String?> lastError;
  final Value<DateTime?> processedAt;
  final Value<int> rowid;
  const SyncOutboxEntriesCompanion({
    this.id = const Value.absent(),
    this.entityType = const Value.absent(),
    this.entityId = const Value.absent(),
    this.operation = const Value.absent(),
    this.payloadJson = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.attemptCount = const Value.absent(),
    this.lastError = const Value.absent(),
    this.processedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SyncOutboxEntriesCompanion.insert({
    required String id,
    required String entityType,
    required String entityId,
    required String operation,
    this.payloadJson = const Value.absent(),
    required DateTime createdAt,
    this.attemptCount = const Value.absent(),
    this.lastError = const Value.absent(),
    this.processedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       entityType = Value(entityType),
       entityId = Value(entityId),
       operation = Value(operation),
       createdAt = Value(createdAt);
  static Insertable<SyncOutboxRow> custom({
    Expression<String>? id,
    Expression<String>? entityType,
    Expression<String>? entityId,
    Expression<String>? operation,
    Expression<String>? payloadJson,
    Expression<DateTime>? createdAt,
    Expression<int>? attemptCount,
    Expression<String>? lastError,
    Expression<DateTime>? processedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (entityType != null) 'entity_type': entityType,
      if (entityId != null) 'entity_id': entityId,
      if (operation != null) 'operation': operation,
      if (payloadJson != null) 'payload_json': payloadJson,
      if (createdAt != null) 'created_at': createdAt,
      if (attemptCount != null) 'attempt_count': attemptCount,
      if (lastError != null) 'last_error': lastError,
      if (processedAt != null) 'processed_at': processedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SyncOutboxEntriesCompanion copyWith({
    Value<String>? id,
    Value<String>? entityType,
    Value<String>? entityId,
    Value<String>? operation,
    Value<String?>? payloadJson,
    Value<DateTime>? createdAt,
    Value<int>? attemptCount,
    Value<String?>? lastError,
    Value<DateTime?>? processedAt,
    Value<int>? rowid,
  }) {
    return SyncOutboxEntriesCompanion(
      id: id ?? this.id,
      entityType: entityType ?? this.entityType,
      entityId: entityId ?? this.entityId,
      operation: operation ?? this.operation,
      payloadJson: payloadJson ?? this.payloadJson,
      createdAt: createdAt ?? this.createdAt,
      attemptCount: attemptCount ?? this.attemptCount,
      lastError: lastError ?? this.lastError,
      processedAt: processedAt ?? this.processedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (entityType.present) {
      map['entity_type'] = Variable<String>(entityType.value);
    }
    if (entityId.present) {
      map['entity_id'] = Variable<String>(entityId.value);
    }
    if (operation.present) {
      map['operation'] = Variable<String>(operation.value);
    }
    if (payloadJson.present) {
      map['payload_json'] = Variable<String>(payloadJson.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (attemptCount.present) {
      map['attempt_count'] = Variable<int>(attemptCount.value);
    }
    if (lastError.present) {
      map['last_error'] = Variable<String>(lastError.value);
    }
    if (processedAt.present) {
      map['processed_at'] = Variable<DateTime>(processedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncOutboxEntriesCompanion(')
          ..write('id: $id, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId, ')
          ..write('operation: $operation, ')
          ..write('payloadJson: $payloadJson, ')
          ..write('createdAt: $createdAt, ')
          ..write('attemptCount: $attemptCount, ')
          ..write('lastError: $lastError, ')
          ..write('processedAt: $processedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UsersTable users = $UsersTable(this);
  late final $DecksTable decks = $DecksTable(this);
  late final $FlashcardsTable flashcards = $FlashcardsTable(this);
  late final $FlashcardTagsTable flashcardTags = $FlashcardTagsTable(this);
  late final $StudySessionsTable studySessions = $StudySessionsTable(this);
  late final $ReviewResultsTable reviewResults = $ReviewResultsTable(this);
  late final $DocumentImportsTable documentImports = $DocumentImportsTable(
    this,
  );
  late final $GenerationUsageRecordsTable generationUsageRecords =
      $GenerationUsageRecordsTable(this);
  late final $AppPreferencesTable appPreferences = $AppPreferencesTable(this);
  late final $SyncOutboxEntriesTable syncOutboxEntries =
      $SyncOutboxEntriesTable(this);
  late final Index decksOwnerIdx = Index(
    'decks_owner_idx',
    'CREATE INDEX decks_owner_idx ON decks (owner_id)',
  );
  late final Index flashcardsDeckIdx = Index(
    'flashcards_deck_idx',
    'CREATE INDEX flashcards_deck_idx ON flashcards (deck_id)',
  );
  late final Index flashcardsNextReviewIdx = Index(
    'flashcards_next_review_idx',
    'CREATE INDEX flashcards_next_review_idx ON flashcards (next_review_at)',
  );
  late final Index reviewResultsReviewedAtIdx = Index(
    'review_results_reviewed_at_idx',
    'CREATE INDEX review_results_reviewed_at_idx ON review_results (reviewed_at)',
  );
  late final Index reviewResultsCardIdx = Index(
    'review_results_card_idx',
    'CREATE INDEX review_results_card_idx ON review_results (card_id)',
  );
  late final Index syncOutboxCreatedAtIdx = Index(
    'sync_outbox_created_at_idx',
    'CREATE INDEX sync_outbox_created_at_idx ON sync_outbox_entries (created_at)',
  );
  late final Index syncOutboxEntityIdx = Index(
    'sync_outbox_entity_idx',
    'CREATE INDEX sync_outbox_entity_idx ON sync_outbox_entries (entity_type, entity_id)',
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    users,
    decks,
    flashcards,
    flashcardTags,
    studySessions,
    reviewResults,
    documentImports,
    generationUsageRecords,
    appPreferences,
    syncOutboxEntries,
    decksOwnerIdx,
    flashcardsDeckIdx,
    flashcardsNextReviewIdx,
    reviewResultsReviewedAtIdx,
    reviewResultsCardIdx,
    syncOutboxCreatedAtIdx,
    syncOutboxEntityIdx,
  ];
}

typedef $$UsersTableCreateCompanionBuilder = UsersCompanion Function({
  required String id,
  Value<String?> email,
  required String displayName,
  required String authProvider,
  required bool isGuest,
  required DateTime createdAt,
  Value<int> rowid,
});
typedef $$UsersTableUpdateCompanionBuilder = UsersCompanion Function({
  Value<String> id,
  Value<String?> email,
  Value<String> displayName,
  Value<String> authProvider,
  Value<bool> isGuest,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

final class $$UsersTableReferences
    extends BaseReferences<_$AppDatabase, $UsersTable, UserRow> {
  $$UsersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$DecksTable, List<DeckRow>> _decksRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.decks,
    aliasName: 'users__id__decks__owner_id',
  );

  $$DecksTableProcessedTableManager get decksRefs {
    final manager = $$DecksTableTableManager(
      $_db,
      $_db.decks,
    ).filter((f) => f.ownerId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_decksRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$UsersTableFilterComposer extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get authProvider => $composableBuilder(
    column: $table.authProvider,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isGuest => $composableBuilder(
    column: $table.isGuest,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> decksRefs(
    Expression<bool> Function($$DecksTableFilterComposer f) f,
  ) {
    final $$DecksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.decks,
      getReferencedColumn: (t) => t.ownerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DecksTableFilterComposer(
            $db: $db,
            $table: $db.decks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$UsersTableOrderingComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get authProvider => $composableBuilder(
    column: $table.authProvider,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isGuest => $composableBuilder(
    column: $table.isGuest,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UsersTableAnnotationComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get authProvider => $composableBuilder(
    column: $table.authProvider,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isGuest =>
      $composableBuilder(column: $table.isGuest, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> decksRefs<T extends Object>(
    Expression<T> Function($$DecksTableAnnotationComposer a) f,
  ) {
    final $$DecksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.decks,
      getReferencedColumn: (t) => t.ownerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DecksTableAnnotationComposer(
            $db: $db,
            $table: $db.decks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$UsersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UsersTable,
          UserRow,
          $$UsersTableFilterComposer,
          $$UsersTableOrderingComposer,
          $$UsersTableAnnotationComposer,
          $$UsersTableCreateCompanionBuilder,
          $$UsersTableUpdateCompanionBuilder,
          (UserRow, $$UsersTableReferences),
          UserRow,
          PrefetchHooks Function({bool decksRefs})
        > {
  $$UsersTableTableManager(_$AppDatabase db, $UsersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String> displayName = const Value.absent(),
                Value<String> authProvider = const Value.absent(),
                Value<bool> isGuest = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UsersCompanion(
                id: id,
                email: email,
                displayName: displayName,
                authProvider: authProvider,
                isGuest: isGuest,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> email = const Value.absent(),
                required String displayName,
                required String authProvider,
                required bool isGuest,
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => UsersCompanion.insert(
                id: id,
                email: email,
                displayName: displayName,
                authProvider: authProvider,
                isGuest: isGuest,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$UsersTable, UserRow>(table),
                  $$UsersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({decksRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (decksRefs) db.decks],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (decksRefs)
                    await $_getPrefetchedData<UserRow, $UsersTable, DeckRow>(
                      currentTable: table,
                      referencedTable: $$UsersTableReferences._decksRefsTable(
                        db,
                      ),
                      managerFromTypedResult: (p0) =>
                          $$UsersTableReferences(db, table, p0).decksRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.ownerId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$UsersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UsersTable,
      UserRow,
      $$UsersTableFilterComposer,
      $$UsersTableOrderingComposer,
      $$UsersTableAnnotationComposer,
      $$UsersTableCreateCompanionBuilder,
      $$UsersTableUpdateCompanionBuilder,
      (UserRow, $$UsersTableReferences),
      UserRow,
      PrefetchHooks Function({bool decksRefs})
    >;
typedef $$DecksTableCreateCompanionBuilder = DecksCompanion Function({
  required String id,
  required String ownerId,
  required String name,
  Value<String> description,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<DateTime?> deletedAt,
  Value<int> rowid,
});
typedef $$DecksTableUpdateCompanionBuilder = DecksCompanion Function({
  Value<String> id,
  Value<String> ownerId,
  Value<String> name,
  Value<String> description,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  Value<int> rowid,
});

final class $$DecksTableReferences
    extends BaseReferences<_$AppDatabase, $DecksTable, DeckRow> {
  $$DecksTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UsersTable _ownerIdTable(_$AppDatabase db) =>
      db.users.createAlias('decks__owner_id__users__id');

  $$UsersTableProcessedTableManager get ownerId {
    final $_column = $_itemColumn<String>('owner_id')!;

    final manager = $$UsersTableTableManager(
      $_db,
      $_db.users,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_ownerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$FlashcardsTable, List<FlashcardRow>>
  _flashcardsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.flashcards,
    aliasName: 'decks__id__flashcards__deck_id',
  );

  $$FlashcardsTableProcessedTableManager get flashcardsRefs {
    final manager = $$FlashcardsTableTableManager(
      $_db,
      $_db.flashcards,
    ).filter((f) => f.deckId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_flashcardsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$StudySessionsTable, List<StudySessionRow>>
  _studySessionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.studySessions,
    aliasName: 'decks__id__study_sessions__deck_id',
  );

  $$StudySessionsTableProcessedTableManager get studySessionsRefs {
    final manager = $$StudySessionsTableTableManager(
      $_db,
      $_db.studySessions,
    ).filter((f) => f.deckId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_studySessionsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$DecksTableFilterComposer extends Composer<_$AppDatabase, $DecksTable> {
  $$DecksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$UsersTableFilterComposer get ownerId {
    final $$UsersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ownerId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableFilterComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> flashcardsRefs(
    Expression<bool> Function($$FlashcardsTableFilterComposer f) f,
  ) {
    final $$FlashcardsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.flashcards,
      getReferencedColumn: (t) => t.deckId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FlashcardsTableFilterComposer(
            $db: $db,
            $table: $db.flashcards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> studySessionsRefs(
    Expression<bool> Function($$StudySessionsTableFilterComposer f) f,
  ) {
    final $$StudySessionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.studySessions,
      getReferencedColumn: (t) => t.deckId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudySessionsTableFilterComposer(
            $db: $db,
            $table: $db.studySessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$DecksTableOrderingComposer
    extends Composer<_$AppDatabase, $DecksTable> {
  $$DecksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$UsersTableOrderingComposer get ownerId {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ownerId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableOrderingComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DecksTableAnnotationComposer
    extends Composer<_$AppDatabase, $DecksTable> {
  $$DecksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  $$UsersTableAnnotationComposer get ownerId {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ownerId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableAnnotationComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> flashcardsRefs<T extends Object>(
    Expression<T> Function($$FlashcardsTableAnnotationComposer a) f,
  ) {
    final $$FlashcardsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.flashcards,
      getReferencedColumn: (t) => t.deckId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FlashcardsTableAnnotationComposer(
            $db: $db,
            $table: $db.flashcards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> studySessionsRefs<T extends Object>(
    Expression<T> Function($$StudySessionsTableAnnotationComposer a) f,
  ) {
    final $$StudySessionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.studySessions,
      getReferencedColumn: (t) => t.deckId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudySessionsTableAnnotationComposer(
            $db: $db,
            $table: $db.studySessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$DecksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DecksTable,
          DeckRow,
          $$DecksTableFilterComposer,
          $$DecksTableOrderingComposer,
          $$DecksTableAnnotationComposer,
          $$DecksTableCreateCompanionBuilder,
          $$DecksTableUpdateCompanionBuilder,
          (DeckRow, $$DecksTableReferences),
          DeckRow,
          PrefetchHooks Function({
            bool ownerId,
            bool flashcardsRefs,
            bool studySessionsRefs,
          })
        > {
  $$DecksTableTableManager(_$AppDatabase db, $DecksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DecksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DecksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DecksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> ownerId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DecksCompanion(
                id: id,
                ownerId: ownerId,
                name: name,
                description: description,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String ownerId,
                required String name,
                Value<String> description = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DecksCompanion.insert(
                id: id,
                ownerId: ownerId,
                name: name,
                description: description,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$DecksTable, DeckRow>(table),
                  $$DecksTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                ownerId = false,
                flashcardsRefs = false,
                studySessionsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (flashcardsRefs) db.flashcards,
                    if (studySessionsRefs) db.studySessions,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (ownerId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.ownerId,
                            referencedTable: $$DecksTableReferences
                                ._ownerIdTable(db),
                            referencedColumn: $$DecksTableReferences
                                ._ownerIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (flashcardsRefs)
                        await $_getPrefetchedData<
                          DeckRow,
                          $DecksTable,
                          FlashcardRow
                        >(
                          currentTable: table,
                          referencedTable: $$DecksTableReferences
                              ._flashcardsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$DecksTableReferences(
                                db,
                                table,
                                p0,
                              ).flashcardsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.deckId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (studySessionsRefs)
                        await $_getPrefetchedData<
                          DeckRow,
                          $DecksTable,
                          StudySessionRow
                        >(
                          currentTable: table,
                          referencedTable: $$DecksTableReferences
                              ._studySessionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$DecksTableReferences(
                                db,
                                table,
                                p0,
                              ).studySessionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.deckId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$DecksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DecksTable,
      DeckRow,
      $$DecksTableFilterComposer,
      $$DecksTableOrderingComposer,
      $$DecksTableAnnotationComposer,
      $$DecksTableCreateCompanionBuilder,
      $$DecksTableUpdateCompanionBuilder,
      (DeckRow, $$DecksTableReferences),
      DeckRow,
      PrefetchHooks Function({
        bool ownerId,
        bool flashcardsRefs,
        bool studySessionsRefs,
      })
    >;
typedef $$FlashcardsTableCreateCompanionBuilder = FlashcardsCompanion Function({
  required String id,
  required String deckId,
  required String question,
  required String answer,
  required DateTime createdAt,
  required DateTime updatedAt,
  required String source,
  Value<String?> difficulty,
  Value<DateTime?> deletedAt,
  Value<DateTime?> lastReviewedAt,
  Value<DateTime?> nextReviewAt,
  Value<int> reviewCount,
  Value<int> successCount,
  Value<int> failureCount,
  Value<int> easeFactorMillis,
  Value<int> intervalDays,
  Value<int> repetitions,
  Value<int> lapses,
  Value<int> rowid,
});
typedef $$FlashcardsTableUpdateCompanionBuilder = FlashcardsCompanion Function({
  Value<String> id,
  Value<String> deckId,
  Value<String> question,
  Value<String> answer,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<String> source,
  Value<String?> difficulty,
  Value<DateTime?> deletedAt,
  Value<DateTime?> lastReviewedAt,
  Value<DateTime?> nextReviewAt,
  Value<int> reviewCount,
  Value<int> successCount,
  Value<int> failureCount,
  Value<int> easeFactorMillis,
  Value<int> intervalDays,
  Value<int> repetitions,
  Value<int> lapses,
  Value<int> rowid,
});

final class $$FlashcardsTableReferences
    extends BaseReferences<_$AppDatabase, $FlashcardsTable, FlashcardRow> {
  $$FlashcardsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $DecksTable _deckIdTable(_$AppDatabase db) =>
      db.decks.createAlias('flashcards__deck_id__decks__id');

  $$DecksTableProcessedTableManager get deckId {
    final $_column = $_itemColumn<String>('deck_id')!;

    final manager = $$DecksTableTableManager(
      $_db,
      $_db.decks,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_deckIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$FlashcardTagsTable, List<FlashcardTagRow>>
  _flashcardTagsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.flashcardTags,
    aliasName: 'flashcards__id__flashcard_tags__card_id',
  );

  $$FlashcardTagsTableProcessedTableManager get flashcardTagsRefs {
    final manager = $$FlashcardTagsTableTableManager(
      $_db,
      $_db.flashcardTags,
    ).filter((f) => f.cardId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_flashcardTagsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ReviewResultsTable, List<ReviewResultRow>>
  _reviewResultsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.reviewResults,
    aliasName: 'flashcards__id__review_results__card_id',
  );

  $$ReviewResultsTableProcessedTableManager get reviewResultsRefs {
    final manager = $$ReviewResultsTableTableManager(
      $_db,
      $_db.reviewResults,
    ).filter((f) => f.cardId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_reviewResultsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$FlashcardsTableFilterComposer
    extends Composer<_$AppDatabase, $FlashcardsTable> {
  $$FlashcardsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get question => $composableBuilder(
    column: $table.question,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get answer => $composableBuilder(
    column: $table.answer,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastReviewedAt => $composableBuilder(
    column: $table.lastReviewedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get nextReviewAt => $composableBuilder(
    column: $table.nextReviewAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get reviewCount => $composableBuilder(
    column: $table.reviewCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get successCount => $composableBuilder(
    column: $table.successCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get failureCount => $composableBuilder(
    column: $table.failureCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get easeFactorMillis => $composableBuilder(
    column: $table.easeFactorMillis,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get intervalDays => $composableBuilder(
    column: $table.intervalDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get repetitions => $composableBuilder(
    column: $table.repetitions,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lapses => $composableBuilder(
    column: $table.lapses,
    builder: (column) => ColumnFilters(column),
  );

  $$DecksTableFilterComposer get deckId {
    final $$DecksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.deckId,
      referencedTable: $db.decks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DecksTableFilterComposer(
            $db: $db,
            $table: $db.decks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> flashcardTagsRefs(
    Expression<bool> Function($$FlashcardTagsTableFilterComposer f) f,
  ) {
    final $$FlashcardTagsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.flashcardTags,
      getReferencedColumn: (t) => t.cardId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FlashcardTagsTableFilterComposer(
            $db: $db,
            $table: $db.flashcardTags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> reviewResultsRefs(
    Expression<bool> Function($$ReviewResultsTableFilterComposer f) f,
  ) {
    final $$ReviewResultsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.reviewResults,
      getReferencedColumn: (t) => t.cardId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReviewResultsTableFilterComposer(
            $db: $db,
            $table: $db.reviewResults,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$FlashcardsTableOrderingComposer
    extends Composer<_$AppDatabase, $FlashcardsTable> {
  $$FlashcardsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get question => $composableBuilder(
    column: $table.question,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get answer => $composableBuilder(
    column: $table.answer,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastReviewedAt => $composableBuilder(
    column: $table.lastReviewedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get nextReviewAt => $composableBuilder(
    column: $table.nextReviewAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reviewCount => $composableBuilder(
    column: $table.reviewCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get successCount => $composableBuilder(
    column: $table.successCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get failureCount => $composableBuilder(
    column: $table.failureCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get easeFactorMillis => $composableBuilder(
    column: $table.easeFactorMillis,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get intervalDays => $composableBuilder(
    column: $table.intervalDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get repetitions => $composableBuilder(
    column: $table.repetitions,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lapses => $composableBuilder(
    column: $table.lapses,
    builder: (column) => ColumnOrderings(column),
  );

  $$DecksTableOrderingComposer get deckId {
    final $$DecksTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.deckId,
      referencedTable: $db.decks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DecksTableOrderingComposer(
            $db: $db,
            $table: $db.decks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FlashcardsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FlashcardsTable> {
  $$FlashcardsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get question =>
      $composableBuilder(column: $table.question, builder: (column) => column);

  GeneratedColumn<String> get answer =>
      $composableBuilder(column: $table.answer, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<String> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get lastReviewedAt => $composableBuilder(
    column: $table.lastReviewedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get nextReviewAt => $composableBuilder(
    column: $table.nextReviewAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get reviewCount => $composableBuilder(
    column: $table.reviewCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get successCount => $composableBuilder(
    column: $table.successCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get failureCount => $composableBuilder(
    column: $table.failureCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get easeFactorMillis => $composableBuilder(
    column: $table.easeFactorMillis,
    builder: (column) => column,
  );

  GeneratedColumn<int> get intervalDays => $composableBuilder(
    column: $table.intervalDays,
    builder: (column) => column,
  );

  GeneratedColumn<int> get repetitions => $composableBuilder(
    column: $table.repetitions,
    builder: (column) => column,
  );

  GeneratedColumn<int> get lapses =>
      $composableBuilder(column: $table.lapses, builder: (column) => column);

  $$DecksTableAnnotationComposer get deckId {
    final $$DecksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.deckId,
      referencedTable: $db.decks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DecksTableAnnotationComposer(
            $db: $db,
            $table: $db.decks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> flashcardTagsRefs<T extends Object>(
    Expression<T> Function($$FlashcardTagsTableAnnotationComposer a) f,
  ) {
    final $$FlashcardTagsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.flashcardTags,
      getReferencedColumn: (t) => t.cardId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FlashcardTagsTableAnnotationComposer(
            $db: $db,
            $table: $db.flashcardTags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> reviewResultsRefs<T extends Object>(
    Expression<T> Function($$ReviewResultsTableAnnotationComposer a) f,
  ) {
    final $$ReviewResultsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.reviewResults,
      getReferencedColumn: (t) => t.cardId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReviewResultsTableAnnotationComposer(
            $db: $db,
            $table: $db.reviewResults,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$FlashcardsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FlashcardsTable,
          FlashcardRow,
          $$FlashcardsTableFilterComposer,
          $$FlashcardsTableOrderingComposer,
          $$FlashcardsTableAnnotationComposer,
          $$FlashcardsTableCreateCompanionBuilder,
          $$FlashcardsTableUpdateCompanionBuilder,
          (FlashcardRow, $$FlashcardsTableReferences),
          FlashcardRow,
          PrefetchHooks Function({
            bool deckId,
            bool flashcardTagsRefs,
            bool reviewResultsRefs,
          })
        > {
  $$FlashcardsTableTableManager(_$AppDatabase db, $FlashcardsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FlashcardsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FlashcardsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FlashcardsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> deckId = const Value.absent(),
                Value<String> question = const Value.absent(),
                Value<String> answer = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<String?> difficulty = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<DateTime?> lastReviewedAt = const Value.absent(),
                Value<DateTime?> nextReviewAt = const Value.absent(),
                Value<int> reviewCount = const Value.absent(),
                Value<int> successCount = const Value.absent(),
                Value<int> failureCount = const Value.absent(),
                Value<int> easeFactorMillis = const Value.absent(),
                Value<int> intervalDays = const Value.absent(),
                Value<int> repetitions = const Value.absent(),
                Value<int> lapses = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FlashcardsCompanion(
                id: id,
                deckId: deckId,
                question: question,
                answer: answer,
                createdAt: createdAt,
                updatedAt: updatedAt,
                source: source,
                difficulty: difficulty,
                deletedAt: deletedAt,
                lastReviewedAt: lastReviewedAt,
                nextReviewAt: nextReviewAt,
                reviewCount: reviewCount,
                successCount: successCount,
                failureCount: failureCount,
                easeFactorMillis: easeFactorMillis,
                intervalDays: intervalDays,
                repetitions: repetitions,
                lapses: lapses,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String deckId,
                required String question,
                required String answer,
                required DateTime createdAt,
                required DateTime updatedAt,
                required String source,
                Value<String?> difficulty = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<DateTime?> lastReviewedAt = const Value.absent(),
                Value<DateTime?> nextReviewAt = const Value.absent(),
                Value<int> reviewCount = const Value.absent(),
                Value<int> successCount = const Value.absent(),
                Value<int> failureCount = const Value.absent(),
                Value<int> easeFactorMillis = const Value.absent(),
                Value<int> intervalDays = const Value.absent(),
                Value<int> repetitions = const Value.absent(),
                Value<int> lapses = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FlashcardsCompanion.insert(
                id: id,
                deckId: deckId,
                question: question,
                answer: answer,
                createdAt: createdAt,
                updatedAt: updatedAt,
                source: source,
                difficulty: difficulty,
                deletedAt: deletedAt,
                lastReviewedAt: lastReviewedAt,
                nextReviewAt: nextReviewAt,
                reviewCount: reviewCount,
                successCount: successCount,
                failureCount: failureCount,
                easeFactorMillis: easeFactorMillis,
                intervalDays: intervalDays,
                repetitions: repetitions,
                lapses: lapses,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$FlashcardsTable, FlashcardRow>(table),
                  $$FlashcardsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                deckId = false,
                flashcardTagsRefs = false,
                reviewResultsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (flashcardTagsRefs) db.flashcardTags,
                    if (reviewResultsRefs) db.reviewResults,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (deckId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.deckId,
                            referencedTable: $$FlashcardsTableReferences
                                ._deckIdTable(db),
                            referencedColumn: $$FlashcardsTableReferences
                                ._deckIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (flashcardTagsRefs)
                        await $_getPrefetchedData<
                          FlashcardRow,
                          $FlashcardsTable,
                          FlashcardTagRow
                        >(
                          currentTable: table,
                          referencedTable: $$FlashcardsTableReferences
                              ._flashcardTagsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$FlashcardsTableReferences(
                                db,
                                table,
                                p0,
                              ).flashcardTagsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.cardId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (reviewResultsRefs)
                        await $_getPrefetchedData<
                          FlashcardRow,
                          $FlashcardsTable,
                          ReviewResultRow
                        >(
                          currentTable: table,
                          referencedTable: $$FlashcardsTableReferences
                              ._reviewResultsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$FlashcardsTableReferences(
                                db,
                                table,
                                p0,
                              ).reviewResultsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.cardId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$FlashcardsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FlashcardsTable,
      FlashcardRow,
      $$FlashcardsTableFilterComposer,
      $$FlashcardsTableOrderingComposer,
      $$FlashcardsTableAnnotationComposer,
      $$FlashcardsTableCreateCompanionBuilder,
      $$FlashcardsTableUpdateCompanionBuilder,
      (FlashcardRow, $$FlashcardsTableReferences),
      FlashcardRow,
      PrefetchHooks Function({
        bool deckId,
        bool flashcardTagsRefs,
        bool reviewResultsRefs,
      })
    >;
typedef $$FlashcardTagsTableCreateCompanionBuilder =
    FlashcardTagsCompanion Function({
      required String cardId,
      required String tag,
      Value<int> rowid,
    });
typedef $$FlashcardTagsTableUpdateCompanionBuilder =
    FlashcardTagsCompanion Function({
      Value<String> cardId,
      Value<String> tag,
      Value<int> rowid,
    });

final class $$FlashcardTagsTableReferences
    extends
        BaseReferences<_$AppDatabase, $FlashcardTagsTable, FlashcardTagRow> {
  $$FlashcardTagsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $FlashcardsTable _cardIdTable(_$AppDatabase db) =>
      db.flashcards.createAlias('flashcard_tags__card_id__flashcards__id');

  $$FlashcardsTableProcessedTableManager get cardId {
    final $_column = $_itemColumn<String>('card_id')!;

    final manager = $$FlashcardsTableTableManager(
      $_db,
      $_db.flashcards,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_cardIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$FlashcardTagsTableFilterComposer
    extends Composer<_$AppDatabase, $FlashcardTagsTable> {
  $$FlashcardTagsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get tag => $composableBuilder(
    column: $table.tag,
    builder: (column) => ColumnFilters(column),
  );

  $$FlashcardsTableFilterComposer get cardId {
    final $$FlashcardsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.cardId,
      referencedTable: $db.flashcards,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FlashcardsTableFilterComposer(
            $db: $db,
            $table: $db.flashcards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FlashcardTagsTableOrderingComposer
    extends Composer<_$AppDatabase, $FlashcardTagsTable> {
  $$FlashcardTagsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get tag => $composableBuilder(
    column: $table.tag,
    builder: (column) => ColumnOrderings(column),
  );

  $$FlashcardsTableOrderingComposer get cardId {
    final $$FlashcardsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.cardId,
      referencedTable: $db.flashcards,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FlashcardsTableOrderingComposer(
            $db: $db,
            $table: $db.flashcards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FlashcardTagsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FlashcardTagsTable> {
  $$FlashcardTagsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get tag =>
      $composableBuilder(column: $table.tag, builder: (column) => column);

  $$FlashcardsTableAnnotationComposer get cardId {
    final $$FlashcardsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.cardId,
      referencedTable: $db.flashcards,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FlashcardsTableAnnotationComposer(
            $db: $db,
            $table: $db.flashcards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FlashcardTagsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FlashcardTagsTable,
          FlashcardTagRow,
          $$FlashcardTagsTableFilterComposer,
          $$FlashcardTagsTableOrderingComposer,
          $$FlashcardTagsTableAnnotationComposer,
          $$FlashcardTagsTableCreateCompanionBuilder,
          $$FlashcardTagsTableUpdateCompanionBuilder,
          (FlashcardTagRow, $$FlashcardTagsTableReferences),
          FlashcardTagRow,
          PrefetchHooks Function({bool cardId})
        > {
  $$FlashcardTagsTableTableManager(_$AppDatabase db, $FlashcardTagsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FlashcardTagsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FlashcardTagsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FlashcardTagsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> cardId = const Value.absent(),
            Value<String> tag = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) => FlashcardTagsCompanion(cardId: cardId, tag: tag, rowid: rowid),
          createCompanionCallback:
              ({
                required String cardId,
                required String tag,
                Value<int> rowid = const Value.absent(),
              }) => FlashcardTagsCompanion.insert(
                cardId: cardId,
                tag: tag,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$FlashcardTagsTable, FlashcardTagRow>(table),
                  $$FlashcardTagsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({cardId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (cardId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.cardId,
                        referencedTable: $$FlashcardTagsTableReferences
                            ._cardIdTable(db),
                        referencedColumn: $$FlashcardTagsTableReferences
                            ._cardIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$FlashcardTagsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FlashcardTagsTable,
      FlashcardTagRow,
      $$FlashcardTagsTableFilterComposer,
      $$FlashcardTagsTableOrderingComposer,
      $$FlashcardTagsTableAnnotationComposer,
      $$FlashcardTagsTableCreateCompanionBuilder,
      $$FlashcardTagsTableUpdateCompanionBuilder,
      (FlashcardTagRow, $$FlashcardTagsTableReferences),
      FlashcardTagRow,
      PrefetchHooks Function({bool cardId})
    >;
typedef $$StudySessionsTableCreateCompanionBuilder =
    StudySessionsCompanion Function({
      required String id,
      Value<String?> deckId,
      required DateTime startedAt,
      Value<DateTime?> completedAt,
      Value<int> cardsReviewed,
      Value<int> againCount,
      Value<int> hardCount,
      Value<int> goodCount,
      Value<int> easyCount,
      Value<int> rowid,
    });
typedef $$StudySessionsTableUpdateCompanionBuilder =
    StudySessionsCompanion Function({
      Value<String> id,
      Value<String?> deckId,
      Value<DateTime> startedAt,
      Value<DateTime?> completedAt,
      Value<int> cardsReviewed,
      Value<int> againCount,
      Value<int> hardCount,
      Value<int> goodCount,
      Value<int> easyCount,
      Value<int> rowid,
    });

final class $$StudySessionsTableReferences
    extends
        BaseReferences<_$AppDatabase, $StudySessionsTable, StudySessionRow> {
  $$StudySessionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $DecksTable _deckIdTable(_$AppDatabase db) =>
      db.decks.createAlias('study_sessions__deck_id__decks__id');

  $$DecksTableProcessedTableManager? get deckId {
    final $_column = $_itemColumn<String>('deck_id');
    if ($_column == null) return null;
    final manager = $$DecksTableTableManager(
      $_db,
      $_db.decks,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_deckIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$ReviewResultsTable, List<ReviewResultRow>>
  _reviewResultsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.reviewResults,
    aliasName: 'study_sessions__id__review_results__session_id',
  );

  $$ReviewResultsTableProcessedTableManager get reviewResultsRefs {
    final manager = $$ReviewResultsTableTableManager(
      $_db,
      $_db.reviewResults,
    ).filter((f) => f.sessionId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_reviewResultsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$StudySessionsTableFilterComposer
    extends Composer<_$AppDatabase, $StudySessionsTable> {
  $$StudySessionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get cardsReviewed => $composableBuilder(
    column: $table.cardsReviewed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get againCount => $composableBuilder(
    column: $table.againCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get hardCount => $composableBuilder(
    column: $table.hardCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get goodCount => $composableBuilder(
    column: $table.goodCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get easyCount => $composableBuilder(
    column: $table.easyCount,
    builder: (column) => ColumnFilters(column),
  );

  $$DecksTableFilterComposer get deckId {
    final $$DecksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.deckId,
      referencedTable: $db.decks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DecksTableFilterComposer(
            $db: $db,
            $table: $db.decks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> reviewResultsRefs(
    Expression<bool> Function($$ReviewResultsTableFilterComposer f) f,
  ) {
    final $$ReviewResultsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.reviewResults,
      getReferencedColumn: (t) => t.sessionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReviewResultsTableFilterComposer(
            $db: $db,
            $table: $db.reviewResults,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$StudySessionsTableOrderingComposer
    extends Composer<_$AppDatabase, $StudySessionsTable> {
  $$StudySessionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get cardsReviewed => $composableBuilder(
    column: $table.cardsReviewed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get againCount => $composableBuilder(
    column: $table.againCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get hardCount => $composableBuilder(
    column: $table.hardCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get goodCount => $composableBuilder(
    column: $table.goodCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get easyCount => $composableBuilder(
    column: $table.easyCount,
    builder: (column) => ColumnOrderings(column),
  );

  $$DecksTableOrderingComposer get deckId {
    final $$DecksTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.deckId,
      referencedTable: $db.decks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DecksTableOrderingComposer(
            $db: $db,
            $table: $db.decks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StudySessionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $StudySessionsTable> {
  $$StudySessionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get cardsReviewed => $composableBuilder(
    column: $table.cardsReviewed,
    builder: (column) => column,
  );

  GeneratedColumn<int> get againCount => $composableBuilder(
    column: $table.againCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get hardCount =>
      $composableBuilder(column: $table.hardCount, builder: (column) => column);

  GeneratedColumn<int> get goodCount =>
      $composableBuilder(column: $table.goodCount, builder: (column) => column);

  GeneratedColumn<int> get easyCount =>
      $composableBuilder(column: $table.easyCount, builder: (column) => column);

  $$DecksTableAnnotationComposer get deckId {
    final $$DecksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.deckId,
      referencedTable: $db.decks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DecksTableAnnotationComposer(
            $db: $db,
            $table: $db.decks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> reviewResultsRefs<T extends Object>(
    Expression<T> Function($$ReviewResultsTableAnnotationComposer a) f,
  ) {
    final $$ReviewResultsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.reviewResults,
      getReferencedColumn: (t) => t.sessionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReviewResultsTableAnnotationComposer(
            $db: $db,
            $table: $db.reviewResults,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$StudySessionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StudySessionsTable,
          StudySessionRow,
          $$StudySessionsTableFilterComposer,
          $$StudySessionsTableOrderingComposer,
          $$StudySessionsTableAnnotationComposer,
          $$StudySessionsTableCreateCompanionBuilder,
          $$StudySessionsTableUpdateCompanionBuilder,
          (StudySessionRow, $$StudySessionsTableReferences),
          StudySessionRow,
          PrefetchHooks Function({bool deckId, bool reviewResultsRefs})
        > {
  $$StudySessionsTableTableManager(_$AppDatabase db, $StudySessionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StudySessionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StudySessionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StudySessionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> deckId = const Value.absent(),
                Value<DateTime> startedAt = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<int> cardsReviewed = const Value.absent(),
                Value<int> againCount = const Value.absent(),
                Value<int> hardCount = const Value.absent(),
                Value<int> goodCount = const Value.absent(),
                Value<int> easyCount = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StudySessionsCompanion(
                id: id,
                deckId: deckId,
                startedAt: startedAt,
                completedAt: completedAt,
                cardsReviewed: cardsReviewed,
                againCount: againCount,
                hardCount: hardCount,
                goodCount: goodCount,
                easyCount: easyCount,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> deckId = const Value.absent(),
                required DateTime startedAt,
                Value<DateTime?> completedAt = const Value.absent(),
                Value<int> cardsReviewed = const Value.absent(),
                Value<int> againCount = const Value.absent(),
                Value<int> hardCount = const Value.absent(),
                Value<int> goodCount = const Value.absent(),
                Value<int> easyCount = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StudySessionsCompanion.insert(
                id: id,
                deckId: deckId,
                startedAt: startedAt,
                completedAt: completedAt,
                cardsReviewed: cardsReviewed,
                againCount: againCount,
                hardCount: hardCount,
                goodCount: goodCount,
                easyCount: easyCount,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$StudySessionsTable, StudySessionRow>(table),
                  $$StudySessionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({deckId = false, reviewResultsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (reviewResultsRefs) db.reviewResults,
              ],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (deckId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.deckId,
                        referencedTable: $$StudySessionsTableReferences
                            ._deckIdTable(db),
                        referencedColumn: $$StudySessionsTableReferences
                            ._deckIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (reviewResultsRefs)
                    await $_getPrefetchedData<
                      StudySessionRow,
                      $StudySessionsTable,
                      ReviewResultRow
                    >(
                      currentTable: table,
                      referencedTable: $$StudySessionsTableReferences
                          ._reviewResultsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$StudySessionsTableReferences(
                            db,
                            table,
                            p0,
                          ).reviewResultsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.sessionId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$StudySessionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StudySessionsTable,
      StudySessionRow,
      $$StudySessionsTableFilterComposer,
      $$StudySessionsTableOrderingComposer,
      $$StudySessionsTableAnnotationComposer,
      $$StudySessionsTableCreateCompanionBuilder,
      $$StudySessionsTableUpdateCompanionBuilder,
      (StudySessionRow, $$StudySessionsTableReferences),
      StudySessionRow,
      PrefetchHooks Function({bool deckId, bool reviewResultsRefs})
    >;
typedef $$ReviewResultsTableCreateCompanionBuilder =
    ReviewResultsCompanion Function({
      required String id,
      required String sessionId,
      required String cardId,
      required String grade,
      required DateTime reviewedAt,
      Value<int?> previousIntervalDays,
      Value<int?> newIntervalDays,
      Value<int?> elapsedMilliseconds,
      Value<int> rowid,
    });
typedef $$ReviewResultsTableUpdateCompanionBuilder =
    ReviewResultsCompanion Function({
      Value<String> id,
      Value<String> sessionId,
      Value<String> cardId,
      Value<String> grade,
      Value<DateTime> reviewedAt,
      Value<int?> previousIntervalDays,
      Value<int?> newIntervalDays,
      Value<int?> elapsedMilliseconds,
      Value<int> rowid,
    });

final class $$ReviewResultsTableReferences
    extends
        BaseReferences<_$AppDatabase, $ReviewResultsTable, ReviewResultRow> {
  $$ReviewResultsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $StudySessionsTable _sessionIdTable(_$AppDatabase db) => db
      .studySessions
      .createAlias('review_results__session_id__study_sessions__id');

  $$StudySessionsTableProcessedTableManager get sessionId {
    final $_column = $_itemColumn<String>('session_id')!;

    final manager = $$StudySessionsTableTableManager(
      $_db,
      $_db.studySessions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sessionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $FlashcardsTable _cardIdTable(_$AppDatabase db) =>
      db.flashcards.createAlias('review_results__card_id__flashcards__id');

  $$FlashcardsTableProcessedTableManager get cardId {
    final $_column = $_itemColumn<String>('card_id')!;

    final manager = $$FlashcardsTableTableManager(
      $_db,
      $_db.flashcards,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_cardIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ReviewResultsTableFilterComposer
    extends Composer<_$AppDatabase, $ReviewResultsTable> {
  $$ReviewResultsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get grade => $composableBuilder(
    column: $table.grade,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get reviewedAt => $composableBuilder(
    column: $table.reviewedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get previousIntervalDays => $composableBuilder(
    column: $table.previousIntervalDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get newIntervalDays => $composableBuilder(
    column: $table.newIntervalDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get elapsedMilliseconds => $composableBuilder(
    column: $table.elapsedMilliseconds,
    builder: (column) => ColumnFilters(column),
  );

  $$StudySessionsTableFilterComposer get sessionId {
    final $$StudySessionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.studySessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudySessionsTableFilterComposer(
            $db: $db,
            $table: $db.studySessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$FlashcardsTableFilterComposer get cardId {
    final $$FlashcardsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.cardId,
      referencedTable: $db.flashcards,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FlashcardsTableFilterComposer(
            $db: $db,
            $table: $db.flashcards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReviewResultsTableOrderingComposer
    extends Composer<_$AppDatabase, $ReviewResultsTable> {
  $$ReviewResultsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get grade => $composableBuilder(
    column: $table.grade,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get reviewedAt => $composableBuilder(
    column: $table.reviewedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get previousIntervalDays => $composableBuilder(
    column: $table.previousIntervalDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get newIntervalDays => $composableBuilder(
    column: $table.newIntervalDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get elapsedMilliseconds => $composableBuilder(
    column: $table.elapsedMilliseconds,
    builder: (column) => ColumnOrderings(column),
  );

  $$StudySessionsTableOrderingComposer get sessionId {
    final $$StudySessionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.studySessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudySessionsTableOrderingComposer(
            $db: $db,
            $table: $db.studySessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$FlashcardsTableOrderingComposer get cardId {
    final $$FlashcardsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.cardId,
      referencedTable: $db.flashcards,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FlashcardsTableOrderingComposer(
            $db: $db,
            $table: $db.flashcards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReviewResultsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReviewResultsTable> {
  $$ReviewResultsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get grade =>
      $composableBuilder(column: $table.grade, builder: (column) => column);

  GeneratedColumn<DateTime> get reviewedAt => $composableBuilder(
    column: $table.reviewedAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get previousIntervalDays => $composableBuilder(
    column: $table.previousIntervalDays,
    builder: (column) => column,
  );

  GeneratedColumn<int> get newIntervalDays => $composableBuilder(
    column: $table.newIntervalDays,
    builder: (column) => column,
  );

  GeneratedColumn<int> get elapsedMilliseconds => $composableBuilder(
    column: $table.elapsedMilliseconds,
    builder: (column) => column,
  );

  $$StudySessionsTableAnnotationComposer get sessionId {
    final $$StudySessionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.studySessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudySessionsTableAnnotationComposer(
            $db: $db,
            $table: $db.studySessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$FlashcardsTableAnnotationComposer get cardId {
    final $$FlashcardsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.cardId,
      referencedTable: $db.flashcards,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FlashcardsTableAnnotationComposer(
            $db: $db,
            $table: $db.flashcards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReviewResultsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ReviewResultsTable,
          ReviewResultRow,
          $$ReviewResultsTableFilterComposer,
          $$ReviewResultsTableOrderingComposer,
          $$ReviewResultsTableAnnotationComposer,
          $$ReviewResultsTableCreateCompanionBuilder,
          $$ReviewResultsTableUpdateCompanionBuilder,
          (ReviewResultRow, $$ReviewResultsTableReferences),
          ReviewResultRow,
          PrefetchHooks Function({bool sessionId, bool cardId})
        > {
  $$ReviewResultsTableTableManager(_$AppDatabase db, $ReviewResultsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReviewResultsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ReviewResultsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ReviewResultsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> sessionId = const Value.absent(),
                Value<String> cardId = const Value.absent(),
                Value<String> grade = const Value.absent(),
                Value<DateTime> reviewedAt = const Value.absent(),
                Value<int?> previousIntervalDays = const Value.absent(),
                Value<int?> newIntervalDays = const Value.absent(),
                Value<int?> elapsedMilliseconds = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ReviewResultsCompanion(
                id: id,
                sessionId: sessionId,
                cardId: cardId,
                grade: grade,
                reviewedAt: reviewedAt,
                previousIntervalDays: previousIntervalDays,
                newIntervalDays: newIntervalDays,
                elapsedMilliseconds: elapsedMilliseconds,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String sessionId,
                required String cardId,
                required String grade,
                required DateTime reviewedAt,
                Value<int?> previousIntervalDays = const Value.absent(),
                Value<int?> newIntervalDays = const Value.absent(),
                Value<int?> elapsedMilliseconds = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ReviewResultsCompanion.insert(
                id: id,
                sessionId: sessionId,
                cardId: cardId,
                grade: grade,
                reviewedAt: reviewedAt,
                previousIntervalDays: previousIntervalDays,
                newIntervalDays: newIntervalDays,
                elapsedMilliseconds: elapsedMilliseconds,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ReviewResultsTable, ReviewResultRow>(table),
                  $$ReviewResultsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({sessionId = false, cardId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (sessionId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.sessionId,
                        referencedTable: $$ReviewResultsTableReferences
                            ._sessionIdTable(db),
                        referencedColumn: $$ReviewResultsTableReferences
                            ._sessionIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (cardId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.cardId,
                        referencedTable: $$ReviewResultsTableReferences
                            ._cardIdTable(db),
                        referencedColumn: $$ReviewResultsTableReferences
                            ._cardIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ReviewResultsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ReviewResultsTable,
      ReviewResultRow,
      $$ReviewResultsTableFilterComposer,
      $$ReviewResultsTableOrderingComposer,
      $$ReviewResultsTableAnnotationComposer,
      $$ReviewResultsTableCreateCompanionBuilder,
      $$ReviewResultsTableUpdateCompanionBuilder,
      (ReviewResultRow, $$ReviewResultsTableReferences),
      ReviewResultRow,
      PrefetchHooks Function({bool sessionId, bool cardId})
    >;
typedef $$DocumentImportsTableCreateCompanionBuilder =
    DocumentImportsCompanion Function({
      required String id,
      required String fileName,
      required int byteSize,
      Value<String?> contentHash,
      Value<int?> pageCount,
      Value<int?> textCharacterCount,
      required String status,
      Value<String?> errorMessage,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<DateTime?> discardedAt,
      Value<int> rowid,
    });
typedef $$DocumentImportsTableUpdateCompanionBuilder =
    DocumentImportsCompanion Function({
      Value<String> id,
      Value<String> fileName,
      Value<int> byteSize,
      Value<String?> contentHash,
      Value<int?> pageCount,
      Value<int?> textCharacterCount,
      Value<String> status,
      Value<String?> errorMessage,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> discardedAt,
      Value<int> rowid,
    });

final class $$DocumentImportsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $DocumentImportsTable,
          DocumentImportRow
        > {
  $$DocumentImportsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<
    $GenerationUsageRecordsTable,
    List<GenerationUsageRow>
  >
  _generationUsageRecordsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.generationUsageRecords,
    aliasName:
        'document_imports__id__generation_usage_records__document_import_id',
  );

  $$GenerationUsageRecordsTableProcessedTableManager
  get generationUsageRecordsRefs {
    final manager =
        $$GenerationUsageRecordsTableTableManager(
          $_db,
          $_db.generationUsageRecords,
        ).filter(
          (f) => f.documentImportId.id.sqlEquals($_itemColumn<String>('id')!),
        );

    final cache = $_typedResult.readTableOrNull(
      _generationUsageRecordsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$DocumentImportsTableFilterComposer
    extends Composer<_$AppDatabase, $DocumentImportsTable> {
  $$DocumentImportsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fileName => $composableBuilder(
    column: $table.fileName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get byteSize => $composableBuilder(
    column: $table.byteSize,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contentHash => $composableBuilder(
    column: $table.contentHash,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get pageCount => $composableBuilder(
    column: $table.pageCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get textCharacterCount => $composableBuilder(
    column: $table.textCharacterCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get errorMessage => $composableBuilder(
    column: $table.errorMessage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get discardedAt => $composableBuilder(
    column: $table.discardedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> generationUsageRecordsRefs(
    Expression<bool> Function($$GenerationUsageRecordsTableFilterComposer f) f,
  ) {
    final $$GenerationUsageRecordsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.generationUsageRecords,
          getReferencedColumn: (t) => t.documentImportId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$GenerationUsageRecordsTableFilterComposer(
                $db: $db,
                $table: $db.generationUsageRecords,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$DocumentImportsTableOrderingComposer
    extends Composer<_$AppDatabase, $DocumentImportsTable> {
  $$DocumentImportsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fileName => $composableBuilder(
    column: $table.fileName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get byteSize => $composableBuilder(
    column: $table.byteSize,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contentHash => $composableBuilder(
    column: $table.contentHash,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get pageCount => $composableBuilder(
    column: $table.pageCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get textCharacterCount => $composableBuilder(
    column: $table.textCharacterCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get errorMessage => $composableBuilder(
    column: $table.errorMessage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get discardedAt => $composableBuilder(
    column: $table.discardedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DocumentImportsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DocumentImportsTable> {
  $$DocumentImportsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get fileName =>
      $composableBuilder(column: $table.fileName, builder: (column) => column);

  GeneratedColumn<int> get byteSize =>
      $composableBuilder(column: $table.byteSize, builder: (column) => column);

  GeneratedColumn<String> get contentHash => $composableBuilder(
    column: $table.contentHash,
    builder: (column) => column,
  );

  GeneratedColumn<int> get pageCount =>
      $composableBuilder(column: $table.pageCount, builder: (column) => column);

  GeneratedColumn<int> get textCharacterCount => $composableBuilder(
    column: $table.textCharacterCount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get errorMessage => $composableBuilder(
    column: $table.errorMessage,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get discardedAt => $composableBuilder(
    column: $table.discardedAt,
    builder: (column) => column,
  );

  Expression<T> generationUsageRecordsRefs<T extends Object>(
    Expression<T> Function($$GenerationUsageRecordsTableAnnotationComposer a) f,
  ) {
    final $$GenerationUsageRecordsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.generationUsageRecords,
          getReferencedColumn: (t) => t.documentImportId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$GenerationUsageRecordsTableAnnotationComposer(
                $db: $db,
                $table: $db.generationUsageRecords,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$DocumentImportsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DocumentImportsTable,
          DocumentImportRow,
          $$DocumentImportsTableFilterComposer,
          $$DocumentImportsTableOrderingComposer,
          $$DocumentImportsTableAnnotationComposer,
          $$DocumentImportsTableCreateCompanionBuilder,
          $$DocumentImportsTableUpdateCompanionBuilder,
          (DocumentImportRow, $$DocumentImportsTableReferences),
          DocumentImportRow,
          PrefetchHooks Function({bool generationUsageRecordsRefs})
        > {
  $$DocumentImportsTableTableManager(
    _$AppDatabase db,
    $DocumentImportsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DocumentImportsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DocumentImportsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DocumentImportsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> fileName = const Value.absent(),
                Value<int> byteSize = const Value.absent(),
                Value<String?> contentHash = const Value.absent(),
                Value<int?> pageCount = const Value.absent(),
                Value<int?> textCharacterCount = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> errorMessage = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> discardedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DocumentImportsCompanion(
                id: id,
                fileName: fileName,
                byteSize: byteSize,
                contentHash: contentHash,
                pageCount: pageCount,
                textCharacterCount: textCharacterCount,
                status: status,
                errorMessage: errorMessage,
                createdAt: createdAt,
                updatedAt: updatedAt,
                discardedAt: discardedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String fileName,
                required int byteSize,
                Value<String?> contentHash = const Value.absent(),
                Value<int?> pageCount = const Value.absent(),
                Value<int?> textCharacterCount = const Value.absent(),
                required String status,
                Value<String?> errorMessage = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<DateTime?> discardedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DocumentImportsCompanion.insert(
                id: id,
                fileName: fileName,
                byteSize: byteSize,
                contentHash: contentHash,
                pageCount: pageCount,
                textCharacterCount: textCharacterCount,
                status: status,
                errorMessage: errorMessage,
                createdAt: createdAt,
                updatedAt: updatedAt,
                discardedAt: discardedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$DocumentImportsTable, DocumentImportRow>(table),
                  $$DocumentImportsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({generationUsageRecordsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (generationUsageRecordsRefs) db.generationUsageRecords,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (generationUsageRecordsRefs)
                    await $_getPrefetchedData<
                      DocumentImportRow,
                      $DocumentImportsTable,
                      GenerationUsageRow
                    >(
                      currentTable: table,
                      referencedTable: $$DocumentImportsTableReferences
                          ._generationUsageRecordsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$DocumentImportsTableReferences(
                            db,
                            table,
                            p0,
                          ).generationUsageRecordsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.documentImportId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$DocumentImportsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DocumentImportsTable,
      DocumentImportRow,
      $$DocumentImportsTableFilterComposer,
      $$DocumentImportsTableOrderingComposer,
      $$DocumentImportsTableAnnotationComposer,
      $$DocumentImportsTableCreateCompanionBuilder,
      $$DocumentImportsTableUpdateCompanionBuilder,
      (DocumentImportRow, $$DocumentImportsTableReferences),
      DocumentImportRow,
      PrefetchHooks Function({bool generationUsageRecordsRefs})
    >;
typedef $$GenerationUsageRecordsTableCreateCompanionBuilder =
    GenerationUsageRecordsCompanion Function({
      required String id,
      Value<String?> documentImportId,
      required DateTime createdAt,
      required String status,
      Value<int?> documentBytes,
      Value<int?> promptTokens,
      Value<int?> completionTokens,
      Value<int?> cardCount,
      Value<double?> estimatedCostUsd,
      Value<String?> failureCode,
      Value<int> rowid,
    });
typedef $$GenerationUsageRecordsTableUpdateCompanionBuilder =
    GenerationUsageRecordsCompanion Function({
      Value<String> id,
      Value<String?> documentImportId,
      Value<DateTime> createdAt,
      Value<String> status,
      Value<int?> documentBytes,
      Value<int?> promptTokens,
      Value<int?> completionTokens,
      Value<int?> cardCount,
      Value<double?> estimatedCostUsd,
      Value<String?> failureCode,
      Value<int> rowid,
    });

final class $$GenerationUsageRecordsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $GenerationUsageRecordsTable,
          GenerationUsageRow
        > {
  $$GenerationUsageRecordsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $DocumentImportsTable _documentImportIdTable(_$AppDatabase db) =>
      db.documentImports.createAlias(
        'generation_usage_records__document_import_id__document_imports__id',
      );

  $$DocumentImportsTableProcessedTableManager? get documentImportId {
    final $_column = $_itemColumn<String>('document_import_id');
    if ($_column == null) return null;
    final manager = $$DocumentImportsTableTableManager(
      $_db,
      $_db.documentImports,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_documentImportIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$GenerationUsageRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $GenerationUsageRecordsTable> {
  $$GenerationUsageRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get documentBytes => $composableBuilder(
    column: $table.documentBytes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get promptTokens => $composableBuilder(
    column: $table.promptTokens,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get completionTokens => $composableBuilder(
    column: $table.completionTokens,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get cardCount => $composableBuilder(
    column: $table.cardCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get estimatedCostUsd => $composableBuilder(
    column: $table.estimatedCostUsd,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get failureCode => $composableBuilder(
    column: $table.failureCode,
    builder: (column) => ColumnFilters(column),
  );

  $$DocumentImportsTableFilterComposer get documentImportId {
    final $$DocumentImportsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.documentImportId,
      referencedTable: $db.documentImports,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumentImportsTableFilterComposer(
            $db: $db,
            $table: $db.documentImports,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GenerationUsageRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $GenerationUsageRecordsTable> {
  $$GenerationUsageRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get documentBytes => $composableBuilder(
    column: $table.documentBytes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get promptTokens => $composableBuilder(
    column: $table.promptTokens,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get completionTokens => $composableBuilder(
    column: $table.completionTokens,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get cardCount => $composableBuilder(
    column: $table.cardCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get estimatedCostUsd => $composableBuilder(
    column: $table.estimatedCostUsd,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get failureCode => $composableBuilder(
    column: $table.failureCode,
    builder: (column) => ColumnOrderings(column),
  );

  $$DocumentImportsTableOrderingComposer get documentImportId {
    final $$DocumentImportsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.documentImportId,
      referencedTable: $db.documentImports,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumentImportsTableOrderingComposer(
            $db: $db,
            $table: $db.documentImports,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GenerationUsageRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $GenerationUsageRecordsTable> {
  $$GenerationUsageRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get documentBytes => $composableBuilder(
    column: $table.documentBytes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get promptTokens => $composableBuilder(
    column: $table.promptTokens,
    builder: (column) => column,
  );

  GeneratedColumn<int> get completionTokens => $composableBuilder(
    column: $table.completionTokens,
    builder: (column) => column,
  );

  GeneratedColumn<int> get cardCount =>
      $composableBuilder(column: $table.cardCount, builder: (column) => column);

  GeneratedColumn<double> get estimatedCostUsd => $composableBuilder(
    column: $table.estimatedCostUsd,
    builder: (column) => column,
  );

  GeneratedColumn<String> get failureCode => $composableBuilder(
    column: $table.failureCode,
    builder: (column) => column,
  );

  $$DocumentImportsTableAnnotationComposer get documentImportId {
    final $$DocumentImportsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.documentImportId,
      referencedTable: $db.documentImports,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumentImportsTableAnnotationComposer(
            $db: $db,
            $table: $db.documentImports,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GenerationUsageRecordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GenerationUsageRecordsTable,
          GenerationUsageRow,
          $$GenerationUsageRecordsTableFilterComposer,
          $$GenerationUsageRecordsTableOrderingComposer,
          $$GenerationUsageRecordsTableAnnotationComposer,
          $$GenerationUsageRecordsTableCreateCompanionBuilder,
          $$GenerationUsageRecordsTableUpdateCompanionBuilder,
          (GenerationUsageRow, $$GenerationUsageRecordsTableReferences),
          GenerationUsageRow,
          PrefetchHooks Function({bool documentImportId})
        > {
  $$GenerationUsageRecordsTableTableManager(
    _$AppDatabase db,
    $GenerationUsageRecordsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GenerationUsageRecordsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$GenerationUsageRecordsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$GenerationUsageRecordsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> documentImportId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int?> documentBytes = const Value.absent(),
                Value<int?> promptTokens = const Value.absent(),
                Value<int?> completionTokens = const Value.absent(),
                Value<int?> cardCount = const Value.absent(),
                Value<double?> estimatedCostUsd = const Value.absent(),
                Value<String?> failureCode = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GenerationUsageRecordsCompanion(
                id: id,
                documentImportId: documentImportId,
                createdAt: createdAt,
                status: status,
                documentBytes: documentBytes,
                promptTokens: promptTokens,
                completionTokens: completionTokens,
                cardCount: cardCount,
                estimatedCostUsd: estimatedCostUsd,
                failureCode: failureCode,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> documentImportId = const Value.absent(),
                required DateTime createdAt,
                required String status,
                Value<int?> documentBytes = const Value.absent(),
                Value<int?> promptTokens = const Value.absent(),
                Value<int?> completionTokens = const Value.absent(),
                Value<int?> cardCount = const Value.absent(),
                Value<double?> estimatedCostUsd = const Value.absent(),
                Value<String?> failureCode = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GenerationUsageRecordsCompanion.insert(
                id: id,
                documentImportId: documentImportId,
                createdAt: createdAt,
                status: status,
                documentBytes: documentBytes,
                promptTokens: promptTokens,
                completionTokens: completionTokens,
                cardCount: cardCount,
                estimatedCostUsd: estimatedCostUsd,
                failureCode: failureCode,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$GenerationUsageRecordsTable, GenerationUsageRow>(
                    table,
                  ),
                  $$GenerationUsageRecordsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({documentImportId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (documentImportId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.documentImportId,
                        referencedTable: $$GenerationUsageRecordsTableReferences
                            ._documentImportIdTable(db),
                        referencedColumn:
                            $$GenerationUsageRecordsTableReferences
                                ._documentImportIdTable(db)
                                .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$GenerationUsageRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GenerationUsageRecordsTable,
      GenerationUsageRow,
      $$GenerationUsageRecordsTableFilterComposer,
      $$GenerationUsageRecordsTableOrderingComposer,
      $$GenerationUsageRecordsTableAnnotationComposer,
      $$GenerationUsageRecordsTableCreateCompanionBuilder,
      $$GenerationUsageRecordsTableUpdateCompanionBuilder,
      (GenerationUsageRow, $$GenerationUsageRecordsTableReferences),
      GenerationUsageRow,
      PrefetchHooks Function({bool documentImportId})
    >;
typedef $$AppPreferencesTableCreateCompanionBuilder =
    AppPreferencesCompanion Function({
      Value<int> id,
      Value<String> themeMode,
      Value<bool> hasCompletedOnboarding,
    });
typedef $$AppPreferencesTableUpdateCompanionBuilder =
    AppPreferencesCompanion Function({
      Value<int> id,
      Value<String> themeMode,
      Value<bool> hasCompletedOnboarding,
    });

class $$AppPreferencesTableFilterComposer
    extends Composer<_$AppDatabase, $AppPreferencesTable> {
  $$AppPreferencesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get themeMode => $composableBuilder(
    column: $table.themeMode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get hasCompletedOnboarding => $composableBuilder(
    column: $table.hasCompletedOnboarding,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AppPreferencesTableOrderingComposer
    extends Composer<_$AppDatabase, $AppPreferencesTable> {
  $$AppPreferencesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get themeMode => $composableBuilder(
    column: $table.themeMode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get hasCompletedOnboarding => $composableBuilder(
    column: $table.hasCompletedOnboarding,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AppPreferencesTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppPreferencesTable> {
  $$AppPreferencesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get themeMode =>
      $composableBuilder(column: $table.themeMode, builder: (column) => column);

  GeneratedColumn<bool> get hasCompletedOnboarding => $composableBuilder(
    column: $table.hasCompletedOnboarding,
    builder: (column) => column,
  );
}

class $$AppPreferencesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AppPreferencesTable,
          AppPreferenceRow,
          $$AppPreferencesTableFilterComposer,
          $$AppPreferencesTableOrderingComposer,
          $$AppPreferencesTableAnnotationComposer,
          $$AppPreferencesTableCreateCompanionBuilder,
          $$AppPreferencesTableUpdateCompanionBuilder,
          (
            AppPreferenceRow,
            BaseReferences<
              _$AppDatabase,
              $AppPreferencesTable,
              AppPreferenceRow
            >,
          ),
          AppPreferenceRow,
          PrefetchHooks Function()
        > {
  $$AppPreferencesTableTableManager(
    _$AppDatabase db,
    $AppPreferencesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppPreferencesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppPreferencesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppPreferencesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> themeMode = const Value.absent(),
                Value<bool> hasCompletedOnboarding = const Value.absent(),
              }) => AppPreferencesCompanion(
                id: id,
                themeMode: themeMode,
                hasCompletedOnboarding: hasCompletedOnboarding,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> themeMode = const Value.absent(),
                Value<bool> hasCompletedOnboarding = const Value.absent(),
              }) => AppPreferencesCompanion.insert(
                id: id,
                themeMode: themeMode,
                hasCompletedOnboarding: hasCompletedOnboarding,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$AppPreferencesTable, AppPreferenceRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $AppPreferencesTable,
                    AppPreferenceRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AppPreferencesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AppPreferencesTable,
      AppPreferenceRow,
      $$AppPreferencesTableFilterComposer,
      $$AppPreferencesTableOrderingComposer,
      $$AppPreferencesTableAnnotationComposer,
      $$AppPreferencesTableCreateCompanionBuilder,
      $$AppPreferencesTableUpdateCompanionBuilder,
      (
        AppPreferenceRow,
        BaseReferences<_$AppDatabase, $AppPreferencesTable, AppPreferenceRow>,
      ),
      AppPreferenceRow,
      PrefetchHooks Function()
    >;
typedef $$SyncOutboxEntriesTableCreateCompanionBuilder =
    SyncOutboxEntriesCompanion Function({
      required String id,
      required String entityType,
      required String entityId,
      required String operation,
      Value<String?> payloadJson,
      required DateTime createdAt,
      Value<int> attemptCount,
      Value<String?> lastError,
      Value<DateTime?> processedAt,
      Value<int> rowid,
    });
typedef $$SyncOutboxEntriesTableUpdateCompanionBuilder =
    SyncOutboxEntriesCompanion Function({
      Value<String> id,
      Value<String> entityType,
      Value<String> entityId,
      Value<String> operation,
      Value<String?> payloadJson,
      Value<DateTime> createdAt,
      Value<int> attemptCount,
      Value<String?> lastError,
      Value<DateTime?> processedAt,
      Value<int> rowid,
    });

class $$SyncOutboxEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $SyncOutboxEntriesTable> {
  $$SyncOutboxEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entityId => $composableBuilder(
    column: $table.entityId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get operation => $composableBuilder(
    column: $table.operation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get attemptCount => $composableBuilder(
    column: $table.attemptCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastError => $composableBuilder(
    column: $table.lastError,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get processedAt => $composableBuilder(
    column: $table.processedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SyncOutboxEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncOutboxEntriesTable> {
  $$SyncOutboxEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entityId => $composableBuilder(
    column: $table.entityId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get operation => $composableBuilder(
    column: $table.operation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get attemptCount => $composableBuilder(
    column: $table.attemptCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastError => $composableBuilder(
    column: $table.lastError,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get processedAt => $composableBuilder(
    column: $table.processedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SyncOutboxEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncOutboxEntriesTable> {
  $$SyncOutboxEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get entityId =>
      $composableBuilder(column: $table.entityId, builder: (column) => column);

  GeneratedColumn<String> get operation =>
      $composableBuilder(column: $table.operation, builder: (column) => column);

  GeneratedColumn<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get attemptCount => $composableBuilder(
    column: $table.attemptCount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastError =>
      $composableBuilder(column: $table.lastError, builder: (column) => column);

  GeneratedColumn<DateTime> get processedAt => $composableBuilder(
    column: $table.processedAt,
    builder: (column) => column,
  );
}

class $$SyncOutboxEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SyncOutboxEntriesTable,
          SyncOutboxRow,
          $$SyncOutboxEntriesTableFilterComposer,
          $$SyncOutboxEntriesTableOrderingComposer,
          $$SyncOutboxEntriesTableAnnotationComposer,
          $$SyncOutboxEntriesTableCreateCompanionBuilder,
          $$SyncOutboxEntriesTableUpdateCompanionBuilder,
          (
            SyncOutboxRow,
            BaseReferences<
              _$AppDatabase,
              $SyncOutboxEntriesTable,
              SyncOutboxRow
            >,
          ),
          SyncOutboxRow,
          PrefetchHooks Function()
        > {
  $$SyncOutboxEntriesTableTableManager(
    _$AppDatabase db,
    $SyncOutboxEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncOutboxEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncOutboxEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncOutboxEntriesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> entityType = const Value.absent(),
                Value<String> entityId = const Value.absent(),
                Value<String> operation = const Value.absent(),
                Value<String?> payloadJson = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> attemptCount = const Value.absent(),
                Value<String?> lastError = const Value.absent(),
                Value<DateTime?> processedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncOutboxEntriesCompanion(
                id: id,
                entityType: entityType,
                entityId: entityId,
                operation: operation,
                payloadJson: payloadJson,
                createdAt: createdAt,
                attemptCount: attemptCount,
                lastError: lastError,
                processedAt: processedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String entityType,
                required String entityId,
                required String operation,
                Value<String?> payloadJson = const Value.absent(),
                required DateTime createdAt,
                Value<int> attemptCount = const Value.absent(),
                Value<String?> lastError = const Value.absent(),
                Value<DateTime?> processedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncOutboxEntriesCompanion.insert(
                id: id,
                entityType: entityType,
                entityId: entityId,
                operation: operation,
                payloadJson: payloadJson,
                createdAt: createdAt,
                attemptCount: attemptCount,
                lastError: lastError,
                processedAt: processedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SyncOutboxEntriesTable, SyncOutboxRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $SyncOutboxEntriesTable,
                    SyncOutboxRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SyncOutboxEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SyncOutboxEntriesTable,
      SyncOutboxRow,
      $$SyncOutboxEntriesTableFilterComposer,
      $$SyncOutboxEntriesTableOrderingComposer,
      $$SyncOutboxEntriesTableAnnotationComposer,
      $$SyncOutboxEntriesTableCreateCompanionBuilder,
      $$SyncOutboxEntriesTableUpdateCompanionBuilder,
      (
        SyncOutboxRow,
        BaseReferences<_$AppDatabase, $SyncOutboxEntriesTable, SyncOutboxRow>,
      ),
      SyncOutboxRow,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db, _db.users);
  $$DecksTableTableManager get decks =>
      $$DecksTableTableManager(_db, _db.decks);
  $$FlashcardsTableTableManager get flashcards =>
      $$FlashcardsTableTableManager(_db, _db.flashcards);
  $$FlashcardTagsTableTableManager get flashcardTags =>
      $$FlashcardTagsTableTableManager(_db, _db.flashcardTags);
  $$StudySessionsTableTableManager get studySessions =>
      $$StudySessionsTableTableManager(_db, _db.studySessions);
  $$ReviewResultsTableTableManager get reviewResults =>
      $$ReviewResultsTableTableManager(_db, _db.reviewResults);
  $$DocumentImportsTableTableManager get documentImports =>
      $$DocumentImportsTableTableManager(_db, _db.documentImports);
  $$GenerationUsageRecordsTableTableManager get generationUsageRecords =>
      $$GenerationUsageRecordsTableTableManager(
        _db,
        _db.generationUsageRecords,
      );
  $$AppPreferencesTableTableManager get appPreferences =>
      $$AppPreferencesTableTableManager(_db, _db.appPreferences);
  $$SyncOutboxEntriesTableTableManager get syncOutboxEntries =>
      $$SyncOutboxEntriesTableTableManager(_db, _db.syncOutboxEntries);
}
