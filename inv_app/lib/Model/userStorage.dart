import 'package:hive/hive.dart';

part 'userStorage.g.dart';

@HiveType(typeId: 0)
class UserStorage extends HiveObject {
  @HiveField(0)
  int? userId;

  @HiveField(1)
  String? jwt;

  @HiveField(2)
  int? organizationId;
}
