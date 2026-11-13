import 'package:uuid/uuid.dart';

/// Generates stable identifiers that can later merge across devices.
abstract interface class IdGenerator {
  String next();
}

final class UuidIdGenerator implements IdGenerator {
  UuidIdGenerator([Uuid? uuid]) : _uuid = uuid ?? const Uuid();

  final Uuid _uuid;

  @override
  String next() => _uuid.v4();
}
