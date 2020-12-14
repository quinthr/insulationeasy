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
  final String builderConfirmation;
  final String builderConfirmationDate;
  final String assessorName;
  final String status;
  final String workerName;

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
      this.builderConfirmation,
      this.builderConfirmationDate,
      this.assessorName,
      this.status,
      this.workerName,
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
      'builderConfirmation': builderConfirmation,
      'builderConfirmationDate': builderConfirmationDate,
      'assessorName': assessorName,
      'status': status,
      'workerName': workerName,
    };
  }
}

class InstallationFormEntryDB {
  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    print("DATABASE PATH:"+dbPath.toString());
    String test = path.join(dbPath, 'inseasy-installform.db');
    //await sql.deleteDatabase(test);
    return sql.openDatabase(path.join(dbPath, 'inseasy-installform.db'),
        onCreate: (db, version) {
      db.execute('CREATE TABLE installation_form_signatures('
          'signatureId INTEGER PRIMARY KEY AUTOINCREMENT, '
          'signatureName TEXT,'
          'signaturePoints TEXT,'
          'signatureImage BLOB,'
          'formId TEXT'
          ')');
      db.execute('CREATE TABLE installation_form_hazards('
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
      db.execute('CREATE TABLE installation_form_images('
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
      return db.execute('CREATE TABLE installation_form_entry('
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
          'workerName TEXT'
          ')');
    }, version: 1);
  }

  static Future<void> deleteDB() async {
    final dbPath = await sql.getDatabasesPath();
    String test = path.join(dbPath, 'inseasy-installform.db');
    await sql.deleteDatabase(test);
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await InstallationFormEntryDB.database();
    return db.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<dynamic> getAllFormId() async {
    final db = await InstallationFormEntryDB.database();
    final List<Map<String, dynamic>> maps = await db.query('installation_form_entry',
      where: "status = ?",
      whereArgs: ['Done'],
    );
    return List.generate(maps.length, (i) {
      return InstallationFormEntry(
        formId: maps[i]['formId'],
      );
    });
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await InstallationFormEntryDB.database();
    return db.query(table,
    where: "status = ? or status = ?",
    whereArgs: ['Awaiting Upload', 'Done'],
    );
  }

  static Future<List<Map<String, dynamic>>> getUploadData(String table) async {
    final db = await InstallationFormEntryDB.database();
    return db.query(table,
      where: "status = ?",
      whereArgs: ['Awaiting Upload'],
    );
  }

  static Future<dynamic> getOneFormData(String formId) async {
    print("FORMID RECEIVED: "+formId.toString());
    final db = await InstallationFormEntryDB.database();
    var check = db.query('installation_form_entry');
    print('CHECK ALL ENTRIES:' + check.toString());
    var queryresult = await db.query(
        'installation_form_entry',
        where: "formId = ?",
        whereArgs: [formId],
    );
    print("FORMDATA SENT OUT: "+queryresult.toString());
    return queryresult;
  }

  static Future<dynamic> update(
      String formId, InstallationFormEntry entry) async {
    final db = await InstallationFormEntryDB.database();
    return await db.update(
      'installation_form_entry',
      entry.toMap(),
      where: "formId = ?",
      whereArgs: [formId],
    );
  }

  static Future<dynamic> SetDone(String formId) async {
    final db = await InstallationFormEntryDB.database();
    final getData = await db.query('installation_form_entry',
        where: "formId = ?", whereArgs: [formId], limit: 1);
    var dataList = getData
        .map(
          (item) => InstallationFormEntry(
            formId: item['formId'],
            builderName: item['builderName'],
            address: item['address'],
            orderNumber: item['orderNumber'],
            date: item['date'],
            comments: item['comments'],
            workSiteEvaluator: item['workSiteEvaluator'],
            workSiteEvaluatedDate: item['workSiteEvaluatedDate'],
            builderConfirmation: item['builderConfirmation'],
            builderConfirmationDate: item['builderConfirmationDate'],
            assessorName: item['assessorName'],
            status: 'Awaiting Upload',
            workerName: item['workerName'],
          ),
        )
        .toList();
    var updated = InstallationFormEntry(
        formId: dataList[0].formId,
        builderName: dataList[0].builderName,
        address: dataList[0].address,
        orderNumber: dataList[0].orderNumber,
        date: dataList[0].date,
        comments: dataList[0].comments,
        workSiteEvaluator: dataList[0].workSiteEvaluator,
        workSiteEvaluatedDate: dataList[0].workSiteEvaluatedDate,
        builderConfirmation: dataList[0].builderConfirmation,
        builderConfirmationDate: dataList[0].builderConfirmationDate,
        assessorName: dataList[0].assessorName,
        status: dataList[0].status,
        workerName: dataList[0].workerName);
    return await db.update(
      'installation_form_entry',
      updated.toMap(),
      where: "formId = ?",
      whereArgs: [formId],
    );
  }
  static Future<dynamic> SetUploaded(String formId) async {
    final db = await InstallationFormEntryDB.database();
    final getData = await db.query('installation_form_entry',
        where: "formId = ?", whereArgs: [formId], limit: 1);
    var dataList = getData
        .map(
          (item) => InstallationFormEntry(
        formId: item['formId'],
        builderName: item['builderName'],
        address: item['address'],
        orderNumber: item['orderNumber'],
        date: item['date'],
        comments: item['comments'],
        workSiteEvaluator: item['workSiteEvaluator'],
        workSiteEvaluatedDate: item['workSiteEvaluatedDate'],
        builderConfirmation: item['builderConfirmation'],
        builderConfirmationDate: item['builderConfirmationDate'],
        assessorName: item['assessorName'],
        status: 'Done',
        workerName: item['workerName'],
      ),
    )
        .toList();
    var updated = InstallationFormEntry(
        formId: dataList[0].formId,
        builderName: dataList[0].builderName,
        address: dataList[0].address,
        orderNumber: dataList[0].orderNumber,
        date: dataList[0].date,
        comments: dataList[0].comments,
        workSiteEvaluator: dataList[0].workSiteEvaluator,
        workSiteEvaluatedDate: dataList[0].workSiteEvaluatedDate,
        builderConfirmation: dataList[0].builderConfirmation,
        builderConfirmationDate: dataList[0].builderConfirmationDate,
        assessorName: dataList[0].assessorName,
        status: dataList[0].status,
        workerName: dataList[0].workerName);
    return await db.update(
      'installation_form_entry',
      updated.toMap(),
      where: "formId = ?",
      whereArgs: [formId],
    );
  }
}
