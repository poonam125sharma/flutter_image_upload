import 'dart:async';
import 'dart:io' as io;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/image.dart';

class DB_Helper {
  static Database _db;  // Database instance
  static const String ID = 'id'; 
  static const String NAME = 'imageName';
  static const String TABLE = 'tblimages';
  static const String DB_NAME = 'images.db';

  Future<Database> get db async {
    if(_db != null) {
      return _db;
    }
    _db = await initDB();
    return _db;
  }

  initDB() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_NAME);
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute('CREATE TABLE $TABLE ($ID INTEGER, $NAME TEXT)');
  }

  Future<Image> save(Image image) async {
    var dbClient = await db;
    image.id = await dbClient.insert(TABLE, image.toMap());
    return image;
  }

  Future<List<Image>> getImages() async {
    var dbClient = await db;
    List<Map> maps = await dbClient.query(TABLE, columns: [ID, NAME]);
    List<Image> images = [];
    if(maps.length > 0) {
      for(int i = 0; i < maps.length; i++) {
        images.add(Image.fromMap(maps[i]));
      }
    }
    return images;
  }

  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }
  
}