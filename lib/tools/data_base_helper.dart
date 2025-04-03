import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  static const String dbName = "dailyword.db";
  static const String tableChengyu = "chengyu";

  DatabaseHelper._internal();

  factory DatabaseHelper() {
    return _instance;
  }

  /// **获取数据库实例**
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  /// **初始化数据库**
  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String dbPath = join(documentsDirectory.path, dbName);

    // 检查数据库是否已经存在
    if (!await File(dbPath).exists()) {
      // 从 assets 复制数据库到本地
      ByteData data = await rootBundle.load("assets/db/$dbName");
      List<int> bytes = data.buffer.asUint8List();
      await File(dbPath).writeAsBytes(bytes);
    }

    // 打开数据库
    return await openDatabase(dbPath);
  }

  /// **查询数据库中的所有成语**
  Future<List<Map<String, dynamic>>> getAllChengyu() async {
    Database db = await database;
    return await db.query(tableChengyu);
  }

  /// **根据名称查询成语**
  Future<Map<String, dynamic>?> getChengyuByName(String name) async {
    Database db = await database;
    List<Map<String, dynamic>> results =
        await db.query(tableChengyu, where: "name = ?", whereArgs: [name]);

    return results.isNotEmpty ? results.first : null;
  }

  /// **模糊查询成语**
  Future<List<Map<String, dynamic>>> searchChengyu(String keyword) async {
    Database db = await database;
    return await db
        .query(tableChengyu, where: "name LIKE ?", whereArgs: ['%$keyword%']);
  }

  /// **插入一个新的成语**
  Future<int> insertChengyu(Map<String, dynamic> chengyu) async {
    Database db = await database;
    return await db.insert(tableChengyu, chengyu);
  }

  /// **更新成语信息**
  Future<int> updateChengyu(Map<String, dynamic> chengyu) async {
    Database db = await database;
    return await db.update(tableChengyu, chengyu,
        where: "id = ?", whereArgs: [chengyu['id']]);
  }

  /// **删除一个成语**
  Future<int> deleteChengyu(int id) async {
    Database db = await database;
    return await db.delete(tableChengyu, where: "id = ?", whereArgs: [id]);
  }

  /// **随机获取一条成语**
  Future<Map<String, dynamic>?> getRandomChengyu() async {
    Database db = await database;
    List<Map<String, dynamic>> results =
        await db.query(tableChengyu, orderBy: "RANDOM()", limit: 1);

    return results.isNotEmpty ? results.first : null;
  }
}
