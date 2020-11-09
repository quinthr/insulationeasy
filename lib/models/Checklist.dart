import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

class Checklist {
  final int checklist_id;
  final String text;
  final String status;
  final String formId;


  Checklist ({
    this.checklist_id,
    this.text,
    this.status,
    this.formId,
  });
}

class ChecklistDB {
  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'inseasy-installform.db'),
        onCreate: (db, version) {
          db.execute(
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
          db.execute(
              'CREATE TABLE installation_form_images('
                  'imageName TEXT PRIMARY KEY,'
                  'imageData BLOB,'
                  'indexnum TEXT,'
                  'status TEXT,'
                  'formId TEXT'
                  ')');
          db.execute(
              'CREATE TABLE installation_form_checklist('
                  'check_id INTEGER PRIMARY KEY AUTOINCREMENT, '
                  'text TEXT,'
                  'status TEXT,'
                  'formId TEXT'
                  ')');
          return db.execute(
              'CREATE TABLE installation_form_entry('
                  'id INTEGER PRIMARY KEY AUTOINCREMENT, '
                  'formId TEXT,'
                  'orderNumber TEXT,'
                  'builderName TEXT,'
                  'address TEXT,'
                  'date TEXT, '
                  'comments TEXT,'
                  'workSiteEvaluator TEXT,'
                  'workSiteEvaluatedDate TEXT,'
                  'workSiteEvaluatorSignature TEXT,'
                  'builderConfirmation TEXT,'
                  'builderConfirmationDate TEXT,'
                  'builderConfirmationSignature TEXT,'
                  'assessorName TEXT,'
                  'status TEXT'
                  ')');
        }, version: 1);
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await ChecklistDB.database();
    db.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.abort,
    );
    print('Insert Successfully');
  }

  static Future<void> deleteCheck(String formId, String text) async {
    final db = await ChecklistDB.database();
    print(await db.delete(
      'installation_form_checklist',
      where: "formId = ? & text = ?",
      whereArgs: [formId, text],
    ));
    print(formId);
    print(text);
    db.delete(
      'installation_form_checklist',
      where: "formId = ? and text = ?",
      whereArgs: [formId, text],
    );
    print('Deleted Successfully');
  }

  static Future<dynamic> getAll(String formId) async {
    final db = await ChecklistDB.database();
    return await db.query(
        'installation_form_checklist',
        where: "formId = ?",
        whereArgs: [formId],
    );
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await ChecklistDB.database();
    return db.query(table);
  }
}