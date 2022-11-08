// ignore_for_file: avoid_print, depend_on_referenced_packages, prefer_const_declarations

import 'package:path/path.dart';

import 'package:sqflite/sqflite.dart';
import 'package:tes_pitjarus/model/store_model.dart';

class DBStore {
  static Future<Database> initDB() async {
    var dbPath = await getDatabasesPath();
    String path = join(dbPath, 'store.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  static Future _onCreate(Database db, int version) async {
    final sql =
        ''' CREATE TABLE Store( store_id TEXT, store_code TEXT, store_name TEXT, address TEXT, dc_id TEXT, dc_name TEXT, account_id TEXT, account_name TEXT, subchannel_id TEXT, subchannel_name TEXT, channel_id TEXT, channel_name TEXT, area_id TEXT, area_name TEXT, region_id TEXT, region_name TEXT, latitude TEXT, longitude TEXT)''';
    await db.execute(sql);
  }

  static Future<int> createStores(Store store) async {
    Database db = await DBStore.initDB();
    final getdatadb = await db.insert('Store', store.toJson());
    print('data berhasil disimpan');
    return getdatadb;
  }

  static Future<List<Store>> readStores() async {
    Database db = await DBStore.initDB();
    var store = await db.rawQuery('SELECT * FROM STORE');
    List<Store> storeList = store.isNotEmpty
        ? store.map((details) => Store.fromJson(details)).toList()
        : [];
    return storeList;
  }

  static Future<int> deleteStores() async {
    Database db = await DBStore.initDB();
    final del = await db.rawDelete('DELETE FROM Store');
    print('list Store telah dihapus');
    return del;
  }
}
