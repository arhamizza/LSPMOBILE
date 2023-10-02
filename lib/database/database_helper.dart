import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:test1/Users/transaksi_model.dart';
import 'package:test1/Users/usr_model.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqlite_api.dart';

class DatabaseHelper {
    //   static final DatabaseHelper _instance = DatabaseHelper._internal();
    // static Database? _database;

    // DatabaseHelper._internal();
    // factory DatabaseHelper() => _instance;
    
    // final DateTime tableName = 'DateTime';
    // final int columnId = nominal;
    // final String columnName = 'ket';
  final _tablename ="users";
  final databaseName = "testDB.db";
  String userTable ="create table users (usrId integer primary key autoincrement, usrName Text, usrPassword Text)";
  String userData = "insert into users (usrId, usrName, usrPassword) values(1,'a','1')";
  String tabelTransaksi ="create table transaksis (id integer primary key autoincrement, tanggal DATETIME DEFAULT CURRENT_TIMESTAMP, nominal Text,ket Text)";
  String dataTransaksi = "insert into transaksis (id, tanggal, nominal. ket) values(1,'20120618 10:34:09 AM','100','kucing')";
  
  Future <Database> initDB()async{
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, databaseName);
    return await openDatabase(path,version: 1, onCreate: (db, version)async {
      //USer table
      await db.execute(userTable);
      //Default user data for login
      await db.rawQuery(userData);
      await db.execute(tabelTransaksi);
      // await db.rawQuery(dataTransaksi);
    });
    
  }

  //Authentication Method for login

  Future <bool> authentication(Users users)async{
    final Database db = await initDB();
    var result = await db.rawQuery("select * from users where usrName = '${users.usrName}' and usrPassword = '${users.usrPassword}'");
    if (result.isNotEmpty) {
      return true;
    }else {
      return false;
    }
  }
  Future <bool> authenticationPass(Users users)async{
    final Database db = await initDB();
    var result = await db.rawQuery("select * from users where usrPassword = '${users.usrPassword}'");
    if (result.isNotEmpty) {
      return true;
    }else {
      return false;
    }
  }

  Future <int> updateUser(Users users)async{
    final Database db = await initDB();
    var result = await db.update('users', users.toMap(), where: 'usrId = ?', whereArgs: [users.usrId]);
    return result;
  }

  
  //Method for creating an account
  Future <int> createTransaksi(Transaksi transaksis) async {
    final Database db = await initDB();
    return db.insert('transaksis', transaksis.toMap());
  }

  //Method to show users
  Future <List<Transaksi>> getTransaksi () async{
    final Database db = await initDB();
    final List<Map<String, Object?>>  queryResult = await db.query('transaksis',orderBy: 'id');
    return queryResult.map((e) => Transaksi.fromMap(e)).toList();
  }

  //Total users count
  Future <int?> totalTransaksis() async {
    final Database db = await initDB();
    final count = Sqflite.firstIntValue(await db.rawQuery("select count(*) from transaksis"));
    return count;
  }
  Future<List<Map<String, dynamic>>> select() async {
    Database db = await initDB();
    var mapList = await db.query('transaksis', orderBy: 'id');
    return mapList;
  }
}