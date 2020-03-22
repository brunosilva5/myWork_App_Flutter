import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

final String workTable = "workTable";
final String idColumn = "idColumn";
final String nameColumn = "nameColumn";
final String workColumn = "workColumn";
final String entradaColumn = "entradaColumn";
final String saidaColumn = "saidaColumn";
final String phoneColumn = "phoneColumn";
final String imgColumn = "imgColumn";
final String combustivelColumn = "combustivelColumn"; 

class WorkHelper {
  static final WorkHelper _instance = WorkHelper.internal();

  factory WorkHelper() => _instance;

  WorkHelper.internal();

  Database _db;

  Future<Database> get db async {
    if (_db != null)
      return _db;
    else {
      _db = await initDb();
      return _db;
    }
  }

  Future<Database> initDb() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, "works.db");

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int newerVersion) async {
      await db.execute(
          "CREATE TABLE $workTable($idColumn INTEGER PRIMARY KEY, $nameColumn TEXT, $entradaColumn TEXT,"
          "$saidaColumn TEXT, $phoneColumn TEXT, $imgColumn TEXT, $combustivelColumn TEXT)");
    });
  }

  Future<Work> saveWork(Work work) async {
    Database dbWork = await db;
    work.id = await dbWork.insert(workTable, work.toMap());
    return work;
  }

  Future<Work> getWork(int id) async {
    Database dbWork = await db;
    List<Map> maps = await dbWork.query(workTable,
        columns: [idColumn, nameColumn, workColumn, entradaColumn, saidaColumn, phoneColumn, imgColumn, combustivelColumn],
        where: "$idColumn = ?",
        whereArgs: [id]);
    if (maps.length > 0) {
      return Work.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<int> deleteWork(int id) async {
    Database dbWork = await db;
    return await dbWork
        .delete(workTable, where: "$idColumn = ?", whereArgs: [id]);
  }

  Future<int> updateWork(Work work) async {
    Database dbWork = await db;
    return await dbWork.update(workTable, work.toMap(),
        where: "$idColumn = ?", whereArgs: [work.id]);
  }

  Future<List>getAllWorks()async{
    Database dbWork = await db;
    List listMap = await dbWork.rawQuery("SELECT * FROM $workTable");
    List<Work> listContact = List();
    for(Map m in listMap){
      listContact.add(Work.fromMap(m));
    }
    return listContact;
  }

  Future<int>getNumber()async{
    Database dbWork = await db;
    return Sqflite.firstIntValue(await dbWork.rawQuery("SELECT COUNT(*) FROM $workTable"));
  }

  Future close()async{
    Database dbWork = await db;
    dbWork.close();
  }

}

class Work {
  int id;
  String name;
  String work;
  DateTime entrada;
  DateTime saida;
  String phone;
  String img;
  bool combustivel;

  Work();

  Work.fromMap(Map map) {
    id = map[idColumn];
    name = map[nameColumn];
    work = map[workColumn];
    entrada = map[entradaColumn];
    saida = map[saidaColumn];
    phone = map[phoneColumn];
    img = map[imgColumn];
    combustivel = map[combustivelColumn];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      nameColumn: name,
      entradaColumn: entrada,
      saidaColumn: saida,
      phoneColumn: phone,
      imgColumn: img
    };
    if (id != null) {
      map[idColumn] = id;
    }
    return map;
  }

  @override
  String toString() {
    return "Contact(id: $id, name: $name, work: $work, entrada: $entrada, saida: $saida, phone: $phone, img: $img, combustivel: $combustivel)";
  }
}
