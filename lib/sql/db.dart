import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class SqlDb {
  static Database? _db;
  Future<Database?> get db async {
    if (_db == null) {
      _db = await initDb();
      return _db;
    } else {
      return _db;
    }
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "uni_project.db");
    var theDb = await openDatabase(
      path,
      version: 3,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
    return theDb;
  }

  _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // await db.execute('ALTER TABLE employee ALTER COLUMN phone TEXT');
    // await db.execute('ALTER TABLE orders ALTER COLUMN patient_phone TEXT');

    // print('upgrade');
  }

  _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE "employee"(
      "id"	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
      "name" TEXT NOT NULL,
      "address" TEXT NOT NULL,
      "phone" INTEGER NOT NULL,
      "type" INTEGER NOT NULL,
      "salary" INTEGER NOT NULL
    )
    ''');

    await db.execute('''
    CREATE TABLE "users"(
      "id"	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
      "name" TEXT NOT NULL,
      "email" TEXT NOT NULL,
      "password" TEXT NOT NULL,
      "type" INTEGER NOT NULL
    )
    ''');

    await db.execute('''
    CREATE TABLE "test"(
      "id"	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
      "name" TEXT NOT NULL,
      "type" INTEGER NOT NULL,
      "price" INTEGER NOT NULL,
      "employee_id" INTEGER,
      FOREIGN KEY (employee_id) REFERENCES employee(id)
    )
    ''');

    await db.execute('''
    CREATE TABLE "expenses"(
      "id"	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
      "description" TEXT NOT NULL,
      "value" INTEGER NOT NULL,
      "employee_id" INTEGER,
      FOREIGN KEY (employee_id) REFERENCES employee(id)
    )
    ''');

    await db.execute('''
    CREATE TABLE "orders"(
      "id"	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
      "patient_name" TEXT NOT NULL,
      "date" VARCHAR NOT NULL,
      "patient_phone" INTEGER NOT NULL,
      "state" TEXT NOT NULL,
      "patient_age" INTEGER NOT NULL,
      "test_id" INTEGER,
      "employee_id" INTEGER,
      FOREIGN KEY (test_id) REFERENCES test(id),
      FOREIGN KEY (employee_id) REFERENCES employee(id)

    )
    ''');

    await db.execute('''
    CREATE TABLE "pills" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "value" INTEGER NOT NULL,
    "patient_name" TEXT NOT NULL,
    "result" TEXT NOT NULL,
    "date" VARCHAR ,
    "order_id" INTEGER,
    "test_id" INTEGER,
    "employee_id" INTEGER,
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (test_id) REFERENCES test(id),
    FOREIGN KEY (employee_id) REFERENCES employee(id)
    ) 
    ''');

    await db.execute('''
    
    ''');

    print('created');
  }

  readData(String sql) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery(sql);
    return response;
  }

  insertData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawInsert(sql);
    return response;
  }

  updateData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawUpdate(sql);
    return response;
  }

  deleteData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawDelete(sql);
    return response;
  }
}
