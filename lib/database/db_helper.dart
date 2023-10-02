
// ignore_for_file: non_constant_identifier_names


//dbhelper ini dibuat untuk
//membuat database, membuat tabel, proses insert, read, update dan delete
        
        
import 'package:test1/Users/transaksi_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';
        
class DbHelper {
    static final DbHelper _instance = DbHelper._internal();
    static Database? _database;
        
    //inisialisasi beberapa variabel yang dibutuhkan

    final String tableName = 'tableTransaksi';
    final String columnId = 'id';
    final String columnTanggal = 'tanggal';
    final String columnNominal = 'nominal';
    final String columnKet = 'ket';
    final String columnPanah = 'panah';
        
    DbHelper._internal();
    factory DbHelper() => _instance;
        
    //cek apakah database ada
    Future<Database?> get _db  async {
        if (_database != null) {
            return _database;
        }
        _database = await _initDb();
        return _database;
    }
        
    Future<Database?> _initDb() async {
        String databasePath = await getDatabasesPath();
        String path = join(databasePath, 'tranksasi.db');
        
        return await openDatabase(path, version: 1, onCreate: _onCreate);
    }
        
    //membuat tabel dan field-fieldnya
    Future<void> _onCreate(Database db, int version) async {
        var sql = "CREATE TABLE $tableName($columnId INTEGER PRIMARY KEY, "
            "$columnTanggal TEXT,"
            "$columnNominal TEXT,"
            "$columnKet TEXT,"
            "$columnPanah TEXT)";
             await db.execute(sql);
    }
        
    //insert ke database
    Future<int?> saveTransaksi(Transaksi transaksi) async {
        var dbClient = await _db;
        return await dbClient!.insert(tableName, transaksi.toMap());
    }
        
    //read database
    Future<List?> getAllTransaksi() async {
        var dbClient = await _db;
        var result = await dbClient!.query(tableName, columns: [
            columnId,
            columnTanggal,
            columnNominal,
            columnKet,      
            columnPanah,      
        ]);
        
        return result.toList();
    }
        
    //update database
    Future<int?> updateTransaksi(Transaksi transaksi) async {
        var dbClient = await _db;
        return await dbClient!.update(tableName, transaksi.toMap(), where: '$columnId = ?', whereArgs: [transaksi.id]);
    }

    //hapus database
    Future<int?> deleteTransaksi(int id) async {
        var dbClient = await _db;
        return await dbClient!.delete(tableName, where: '$columnId = ?', whereArgs: [id]);
    }
}