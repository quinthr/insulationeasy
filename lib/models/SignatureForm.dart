import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

class SignatureForm {
  final int signature_id;
  final String signatureName;
  final String signaturePoints;
  final String signatureImage;
  final String formId;

  SignatureForm ({
    this.signature_id,
    this.signatureName,
    this.signaturePoints,
    this.signatureImage,
    this.formId,
  });
}

class SignatureFormDB {
  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'inseasy-installform.db'),
        onCreate: (db, version) {
          return db.execute(
              'CREATE TABLE installation_form_signatures('
                  'signatureId INTEGER AUTOINCREMENT PRIMARY KEY, '
                  'signatureName TEXT,'
                  'signaturePoints TEXT,'
                  'signatureImage BLOB,'
                  'formId TEXT'
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
  static Future<dynamic> getOneFormData (String formId, String hazardName) async {
    final db = await SignatureFormDB.database();
    return await db.query(
        'installation_form_hazards',
        where: "formId = ? and hazardName = ?",
        whereArgs: [formId, hazardName],
        limit: 1
    );
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await SignatureFormDB.database();
    return db.query(table);
  }
}