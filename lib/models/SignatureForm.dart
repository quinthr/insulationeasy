import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

class SignatureForm {
  final String signatureName;
  final String signaturePoints;
  final Uint8List signatureImage;
  final String formId;

  SignatureForm ({
    this.signatureName,
    this.signaturePoints,
    this.signatureImage,
    this.formId,
  });

  Map<String, dynamic> toMap() {
    return {
      'signatureName': signatureName,
      'signaturePoints': signaturePoints,
      'signatureImage': signatureImage,
      'formId': formId,
    };
  }
}

class SignatureFormDB {
  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'inseasy-installform.db'),
        onCreate: (db, version) {
          db.execute(
              'CREATE TABLE installation_form_signatures('
                  'signatureId INTEGER PRIMARY KEY AUTOINCREMENT, '
                  'signatureName TEXT,'
                  'signaturePoints TEXT,'
                  'signatureImage BLOB,'
                  'formId TEXT'
                  ')');
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
                  'builderConfirmation TEXT,'
                  'builderConfirmationDate TEXT,'
                  'assessorName TEXT,'
                  'status TEXT,'
                  'user TEXT'
                  ')');
        }, version: 1);
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await SignatureFormDB.database();
    db.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
  static Future<dynamic> getOneFormData (String formId, String signatureName) async {
    final db = await SignatureFormDB.database();
    return await db.query(
        'installation_form_signatures',
        where: "formId = ? and signatureName = ?",
        whereArgs: [formId, signatureName],
        limit: 1
    );
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await SignatureFormDB.database();
    return db.query(table);
  }

  static Future<dynamic> update(String formId, String signatureName, SignatureForm entry) async {
    final db = await SignatureFormDB.database();
    return await db.update(
      'installation_form_signatures',
      entry.toMap(),
      where: "formId = ? and signatureName = ?",
      whereArgs: [formId, signatureName],
    );
  }
}