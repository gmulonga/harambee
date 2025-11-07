import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:harambee/models/campaign_model.dart';

class LocalDBService {
  static final LocalDBService _instance = LocalDBService._internal();
  factory LocalDBService() => _instance;
  LocalDBService._internal();

  static Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  Future<Database> _initDB() async {
    final path = join(await getDatabasesPath(), 'harambee.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE campaigns(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            description TEXT,
            target_amount REAL,
            amount_raised REAL DEFAULT 0
          )
        ''');
      },
    );
  }

  Future<int> insertCampaign(Campaign campaign) async {
    final db = await database;
    return await db.insert('campaigns', campaign.toMap());
  }

  Future<List<Campaign>> getCampaigns() async {
    final db = await database;
    final maps = await db.query('campaigns', orderBy: 'id DESC');
    return List.generate(maps.length, (i) => Campaign.fromMap(maps[i]));
  }

  Future<int> updateCampaign(Campaign campaign) async {
    final db = await database;
    return await db.update(
      'campaigns',
      campaign.toMap(),
      where: 'id = ?',
      whereArgs: [campaign.id],
    );
  }
}
