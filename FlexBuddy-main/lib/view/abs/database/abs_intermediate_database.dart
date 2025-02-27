// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';
// import 'dart:io';

// class AbsIntermediateLocalDatabase {
//   static const String tableName = 'AbsIntermediateInfo';
//   static const String databaseName = 'WorkoutDetails.db';
//   static Database? _database;

//   static Future<void> ensureDatabaseInitialized() async {
//     try {
//       // Explicitly print diagnostic information
//       print('Platform: ${Platform.operatingSystem}');
//       print('Database Path: ${await getDatabasesPath()}');
      
//       await database; // Force database initialization
//     } catch (e) {
//       print('Database Initialization Error: $e');
//       rethrow;
//     }
//   }

//   static Future<Database> get database async {
//     if (_database != null) return _database!;
    
//     try {
//       // Verify database path and permissions
//       String path = join(await getDatabasesPath(), databaseName);
//       print('Full Database Path: $path');
      
//       // Check directory exists
//       Directory(dirname(path)).createSync(recursive: true);
      
//       _database = await openDatabase(
//         path,
//         version: 1,
//         onCreate: (db, version) async {
//           print('Creating table: $tableName');
//           await db.execute('''
//             CREATE TABLE $tableName (
//               id INTEGER PRIMARY KEY,
//               isStarted INTEGER,
//               currentIndex INTEGER,
//               progress REAL
//             )
//           ''');
          
//           print('Inserting initial record');
//           await db.insert(tableName, {
//             'id': 1,
//             'isStarted': 0,
//             'currentIndex': 0,
//             'progress': 0.0
//           });
          
//           print('Table and initial record created successfully');
//         },
//         onOpen: (db) {
//           print('Database opened successfully');
//         },
//       );
      
//       return _database!;
//     } catch (e) {
//       print('Comprehensive Database Error: $e');
//       rethrow;
//     }
//   }

//   // Save workout progress
//   static Future<void> saveWorkoutProgress({
//     required bool isStarted,
//     required int currentIndex,
//     required double progress,
//   }) async {
//     final db = await database;
//     await db.update(
//       tableName,
//       {
//         'isStarted': isStarted ? 1 : 0,
//         'currentIndex': currentIndex,
//         'progress': progress,
//       },
//       where: 'id = ?',
//       whereArgs: [1],
//     );
//   }

//   // Retrieve workout progress
//   static Future<Map<String, dynamic>> getWorkoutProgress() async {
//     final db = await database;
//     final result = await db.query(tableName, where: 'id = ?', whereArgs: [1]);
    
//     if (result.isNotEmpty) {
//       return {
//         'isStarted': result.first['isStarted'] == 1,
//         'currentIndex': result.first['currentIndex'] as int,
//         'progress': result.first['progress'] as double,
//       };
//     }
    
//     // Default values if no record found
//     return {
//       'isStarted': false,
//       'currentIndex': 0,
//       'progress': 0.0,
//     };
//   }

//   // Reset workout progress
//   static Future<void> resetWorkoutProgress() async {
//     final db = await database;
//     await db.update(
//       tableName,
//       {
//         'isStarted': 0,
//         'currentIndex': 0,
//         'progress': 0.0,
//       },
//       where: 'id = ?',
//       whereArgs: [1],
//     );
//   }
// }