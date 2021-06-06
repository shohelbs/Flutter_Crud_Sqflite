import 'dart:io';

import 'package:flutter_design_demo/model/customer.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHelper {
  DbHelper._();
  static final DbHelper db = DbHelper._();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "CustomerDB.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE ${Customer.tblName} ("
          "id INTEGER PRIMARY KEY,"
          "name TEXT,"
          "email TEXT"
          ")");
    });
  }

  Future<int> saveCustomer(Customer customer) async {
    final dbClient = await db.database;
    int res = await dbClient.insert(Customer.tblName, customer.toMap());
    return res;
  }

  Future<int> getCustomerFromId(int customerId) async {
    final dbClient = await db.database;
    var res = await dbClient
        .rawQuery("SELECT * FROM ${Customer.tblName} WHERE id = '$customerId'");

    if (res.length > 0) {
      return 1;
    }
    return 0;
  }

  Future<int> checkCustomer(Customer customer) async {
    final dbClient = await db.database;
    var res = await dbClient.rawQuery(
        "SELECT * FROM ${Customer.tblName} WHERE name = '${customer.name}' and email = '${customer.email}'");

    if (res.length > 0) {
      return 1;
    }
    return 0;
  }

  Future<List<Customer>> getAllCustomer() async {
    final dbClient = await db.database;
    var res = await dbClient.query(Customer.tblName);

    List<Customer> list =
        res.isNotEmpty ? res.map((c) => Customer.fromMap(c)).toList() : null;
    return list;
  }

  Future<void> updateCustomer(Customer customer) async {
    final dbClient = await db.database;
    await dbClient.update(
      Customer.tblName,
      customer.toMap(),
      where: "id = ?",
      whereArgs: [customer.id],
    );
  }

  Future<void> deleteTrans(int id) async {
    await _database.delete(
      Customer.tblName,
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
