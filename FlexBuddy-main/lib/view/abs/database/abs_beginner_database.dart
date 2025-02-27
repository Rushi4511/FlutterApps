import 'dart:developer';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabase {
  static Database? _database;

  // Ensure database is initialized
  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initializeDatabase();
    return _database!;
  }

  // Initialize database
  static Future<Database> initializeDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), "WorkoutDetails.db"),
      version: 1,
      onCreate: (db, version) async {
        log('Creating database table: AbsBeginner');
        await db.execute(
          '''
          CREATE TABLE AbsBeginner (
            id INTEGER PRIMARY KEY,
            isStarted INTEGER,
            currentIndex INTEGER,
            progress REAL
          )
          '''
        );
        log('Inserting initial record');
        // Insert initial record
        await db.insert('AbsBeginner', {
          'id': 1,
          'isStarted': 0,
          'currentIndex': 0,
          'progress': 0.0
        });
        log('Creating database table: AbsIntermediate');
        await db.execute(
          '''
          CREATE TABLE AbsIntermediate (
            id INTEGER PRIMARY KEY,
            isStarted INTEGER,
            currentIndex INTEGER,
            progress REAL
          )
          '''
        );
        log('Inserting initial record in intermediate');
        // Insert initial record
        await db.insert('AbsIntermediate', {
          'id': 1,
          'isStarted': 0,
          'currentIndex': 0,
          'progress': 0.0
        });
      },
      onOpen: (db) {
          log('Database opened successfully');
        },
    );
  }

  // Save workout progress
  static Future<void> saveWorkoutProgress({
    required String tableName,
    required bool isStarted,
    required int currentIndex,
    required double progress,
  }) async {
    final db = await database;
    await db.update(
      tableName,
      {
        'isStarted': isStarted ? 1 : 0,
        'currentIndex': currentIndex,
        'progress': progress,
      },
      where: 'id = ?',
      whereArgs: [1],
    );
  }

  // Retrieve workout progress
  static Future<Map<String, dynamic>> getWorkoutProgress({required String tableName}) async {
    final db = await database;
    final result = await db.query(tableName, where: 'id = ?', whereArgs: [1]);
    
    if (result.isNotEmpty) {
      return {
        'isStarted': result.first['isStarted'] == 1,
        'currentIndex': result.first['currentIndex'] as int,
        'progress': result.first['progress'] as double,
      };
    }
    
    // Default values if no record found
    return {
      'isStarted': false,
      'currentIndex': 0,
      'progress': 0.0,
    };
  }

  // Reset workout progress
  static Future<void> resetWorkoutProgress({required String tableName}) async {
    final db = await database;
    await db.update(
      tableName,
      {
        'isStarted': 0,
        'currentIndex': 0,
        'progress': 0.0,
      },
      where: 'id = ?',
      whereArgs: [1],
    );
  }
}