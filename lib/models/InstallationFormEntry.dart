import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

class InstallationFormEntry {
  final int id;
  final String formId;
  final String builderName;
  final String orderNumber;
  final String address;
  final String date;
  final String comments;
  final String workSiteEvaluator;
  final String workSiteEvaluatedDate;
  final String workSiteEvaluatorSignature;
  final String builderConfirmation;
  final String builderConfirmationDate;
  final String builderConfirmationSignature;
  final String assessorName;
  final String status;

  InstallationFormEntry({
    this.id,
    this.formId,
    this.orderNumber,
    this.builderName,
    this.address,
    this.date,
    this.comments,
    this.workSiteEvaluator,
    this.workSiteEvaluatedDate,
    this.workSiteEvaluatorSignature,
    this.builderConfirmation,
    this.builderConfirmationDate,
    this.builderConfirmationSignature,
    this.assessorName,
    this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'formId': formId,
      'orderNumber': orderNumber,
      'builderName': builderName,
      'address': address,
      'date': date,
      'comments': comments,
      'workSiteEvaluator': workSiteEvaluator,
      'workSiteEvaluatedDate': workSiteEvaluatedDate,
      'workSiteEvaluatorSignature': workSiteEvaluatorSignature,
      'builderConfirmation': builderConfirmation,
      'builderConfirmationDate': builderConfirmationDate,
      'builderConfirmationSignature': builderConfirmationSignature,
      'assessorName': assessorName,
      'status': status,
    };
  }
}

class InstallationFormEntryDB {
  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    String test = path.join(dbPath, 'inseasy-installform.db');
    //await sql.deleteDatabase(test);
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
    final db = await InstallationFormEntryDB.database();
    db.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await InstallationFormEntryDB.database();
    return db.query(table);
  }
  static Future<dynamic> getOneFormData (String formId) async {
    final db = await InstallationFormEntryDB.database();
    return await db.query(
        'installation_form_entry',
        where: "formId = ?",
        whereArgs: [formId],
        limit: 1
    );
  }
  static Future<dynamic> update(String formId, InstallationFormEntry entry) async {
    final db = await InstallationFormEntryDB.database();
    return await db.update(
      'installation_form_entry',
      entry.toMap(),
      where: "formId = ?",
      whereArgs: [formId],
    );
  }
}