import 'package:data/models/goal_model.dart';
import 'package:data/models/slime_character_model.dart';
import 'package:data/models/todo_model.dart';
import 'package:data/models/user_model.dart';
import 'package:data/models/goal_status_enum.dart';
import 'package:data/utils/gesture_mapper.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class RegisterModule {
  @lazySingleton
  Client get httpClient => Client();

  @preResolve
  Future<Box<UserModel>> get userBox => Hive.openBox<UserModel>('users');
   /* ───────── 새 캐릭터 박스 ───────── */
  @preResolve
  Future<Box<SlimeCharacterModel>> get characterBox =>
      Hive.openBox<SlimeCharacterModel>('character');     // ⭐ 추가
      
  @preResolve
  @Named('todoBox')
  Future<Box<TodoModel>> get todoBox => Hive.openBox<TodoModel>('todos');

  @preResolve
  @Named('deletedTodoBox')
  Future<Box<TodoModel>> get deletedTodoBox =>
      Hive.openBox<TodoModel>('deleted_todos');

  @preResolve
  Future<Box<GoalModel>> get goalBox => Hive.openBox<GoalModel>('goals');

  @preResolve
  Future<Box<GoalStatusEnum>> get goalStatusBox =>
      Hive.openBox<GoalStatusEnum>('goalStatus');

  @lazySingleton
  FlutterSecureStorage get secureStorage => FlutterSecureStorage();

  @lazySingleton
  GestureMapper get gestureMapper => const GestureMapper();

  @preResolve
  Future<SharedPreferences> get sharedPreferences =>
      SharedPreferences.getInstance();
}
