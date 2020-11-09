import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

class Hazards {
  final int hazard_id;
  final String hazardName;
  final String probability;
  final String consequence;
  final String risk;
  final String controlMeasure;
  final String person;
  final String status;
  final String formId;

  Hazards ({
    this.hazard_id,
    this.hazardName,
    this.probability,
    this.consequence,
    this.risk,
    this.controlMeasure,
    this.person,
    this.status,
    this.formId,
  });
}

class HazardsDB {
  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'inseasy-installform.db'),
        onCreate: (db, version) {
          return db.execute(
              'CREATE TABLE installation_form_hazards('
                  'hazardId TEXT PRIMARY KEY, '
                  'hazardName TEXT,'
                  'probability TEXT,'
                  'consequence TEXT,'
                  'risk TEXT,'
                  'controlMeasure TEXT,'
                  'person TEXT,'
                  'status TEXT,'
                  'formId TEXT'
                  ')');
        }, version: 1);
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await HazardsDB.database();
    db.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
  static Future<dynamic> getOneFormData (String formId, String hazardName) async {
    final db = await HazardsDB.database();
    return await db.query(
        'installation_form_hazards',
        where: "formId = ? and hazardName = ?",
        whereArgs: [formId, hazardName],
        limit: 1
    );
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await HazardsDB.database();
    return db.query(table);
  }
}