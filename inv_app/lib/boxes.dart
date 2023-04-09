import 'package:hive/hive.dart';
import 'package:inv_app/Model/userStorage.dart';

class Boxes {
  static Box<UserStorage> getUsers() => Hive.box<UserStorage>('users');
}
