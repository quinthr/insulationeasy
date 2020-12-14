import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

class FormImages {
  final int image_id;
  final Uint8List imageData;
  final String imageName;
  final String indexnum;
  final String status;
  final String formId;

  FormImages ({
    this.image_id,
    this.imageData,
    this.imageName,
    this.indexnum,
    this.status,
    this.formId,
  });

  Map<String, dynamic> toMap() {
    return {
      'imageName': imageName,
      'imageData': imageData,
      'indexnum': indexnum,
      'status': status,
      'formId': formId,
    };
  }

}

class FormImagesDB {
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
    final db = await FormImagesDB.database();
    db.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
  static Future<dynamic> getAll(String formId) async {
    final db = await FormImagesDB.database();
    return await db.query(
      'installation_form_images',
      where: "formId = ?",
      whereArgs: [formId],
    );
  }
  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await FormImagesDB.database();
    return db.query(table);
  }

  static Future<dynamic> SetDone(String formId) async {
    final db = await FormImagesDB.database();
    final getData =  await db.query(
      'installation_form_images',
      where: "formId = ?",
      whereArgs: [formId],
    );
    var dataList = getData.map(
          (item) => FormImages(
        imageName: item['imageName'],
        imageData: item['imageData'],
        indexnum: item['indexnum'],
        status: 'Awaiting Upload',
        formId: item['formId'],
      ),
    ).toList();
    print(dataList);
    print(dataList.length);
    for (var i=0; i<dataList.length; i++){
      var updated = FormImages(
        imageName: dataList[i].imageName,
        imageData: dataList[i].imageData,
        indexnum: dataList[i].indexnum,
        status: dataList[i].status,
        formId: dataList[i].formId,
      );
      await db.update(
        'installation_form_images',
        updated.toMap(),
        where: "formId = ? and imageName = ?",
        whereArgs: [formId, dataList[i].imageName],
      );
    }
  }
  static Future<dynamic> SetUploaded(String formId) async {
    final db = await FormImagesDB.database();
    final getData =  await db.query(
      'installation_form_images',
      where: "formId = ?",
      whereArgs: [formId],
    );
    var dataList = getData.map(
          (item) => FormImages(
        imageName: item['imageName'],
        imageData: item['imageData'],
        indexnum: item['indexnum'],
        status: 'Done',
        formId: item['formId'],
      ),
    ).toList();
    print(dataList);
    print(dataList.length);
    for (var i=0; i<dataList.length; i++){
      var updated = FormImages(
        imageName: dataList[i].imageName,
        imageData: dataList[i].imageData,
        indexnum: dataList[i].indexnum,
        status: dataList[i].status,
        formId: dataList[i].formId,
      );
      await db.update(
        'installation_form_images',
        updated.toMap(),
        where: "formId = ? and imageName = ?",
        whereArgs: [formId, dataList[i].imageName],
      );
    }
  }
}