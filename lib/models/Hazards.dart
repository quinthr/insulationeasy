import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

class Hazards {
  final String hazardId;
  final String hazardName;
  final String probability;
  final String consequence;
  final String risk;
  final String controlMeasure;
  final String person;
  final String status;
  final String formId;

  Hazards ({
    this.hazardId,
    this.hazardName,
    this.probability,
    this.consequence,
    this.risk,
    this.controlMeasure,
    this.person,
    this.status,
    this.formId,
  });

  Map<String, dynamic> toMap() {
    return {
      'hazardId': hazardId,
      'hazardName': hazardName,
      'probability': probability,
      'consequence': consequence,
      'risk': risk,
      'controlMeasure': controlMeasure,
      'person': person,
      'status': status,
      'formId': formId,
    };
  }

}

class HazardsDB {
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
    final db = await HazardsDB.database();
    db.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<dynamic> getAll(String formId) async {
    final db = await HazardsDB.database();
    return await db.query(
      'installation_form_hazards',
      where: "formId = ?",
      whereArgs: [formId],
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

  static Future<dynamic> SetDone(String formId) async {
    final db = await HazardsDB.database();
    final getData =  await db.query(
        'installation_form_hazards',
        where: "formId = ?",
        whereArgs: [formId],
    );
    var dataList = getData.map(
          (item) => Hazards(
            hazardId: item['hazardId'],
            hazardName: item['hazardName'],
            probability: item['probability'],
            consequence: item['consequence'],
            risk: item['risk'],
            controlMeasure: item['controlMeasure'],
            person: item['person'],
            status: 'Awaiting Upload',
            formId: item['formId'],
      ),
    ).toList();
    for (var i=0; i<dataList.length; i++){
      var updated = Hazards(
        hazardId: dataList[i].hazardId,
        hazardName: dataList[i].hazardName,
        probability: dataList[i].probability,
        consequence: dataList[i].consequence,
        risk: dataList[i].risk,
        controlMeasure: dataList[i].controlMeasure,
        person: dataList[i].person,
        status: dataList[i].status,
        formId: dataList[i].formId,
      );
      await db.update(
        'installation_form_hazards',
        updated.toMap(),
        where: "formId = ? and hazardName = ?",
        whereArgs: [formId, dataList[i].hazardName],
      );
    }
  }

  static Future<dynamic> SetUploaded(String formId) async {
    final db = await HazardsDB.database();
    final getData =  await db.query(
      'installation_form_hazards',
      where: "formId = ?",
      whereArgs: [formId],
    );
    var dataList = getData.map(
          (item) => Hazards(
        hazardId: item['hazardId'],
        hazardName: item['hazardName'],
        probability: item['probability'],
        consequence: item['consequence'],
        risk: item['risk'],
        controlMeasure: item['controlMeasure'],
        person: item['person'],
        status: 'Done',
        formId: item['formId'],
      ),
    ).toList();
    for (var i=0; i<dataList.length; i++){
      var updated = Hazards(
        hazardId: dataList[i].hazardId,
        hazardName: dataList[i].hazardName,
        probability: dataList[i].probability,
        consequence: dataList[i].consequence,
        risk: dataList[i].risk,
        controlMeasure: dataList[i].controlMeasure,
        person: dataList[i].person,
        status: dataList[i].status,
        formId: dataList[i].formId,
      );
      await db.update(
        'installation_form_hazards',
        updated.toMap(),
        where: "formId = ? and hazardName = ?",
        whereArgs: [formId, dataList[i].hazardName],
      );
    }
  }
}