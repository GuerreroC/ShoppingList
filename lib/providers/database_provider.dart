import 'dart:io';
import 'package:path/path.dart';
import 'package:shopping_list/models/list_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

bool isUpdate = false;
List<bool> checkboxs = [];
int enCarrito = 0;
double amount = 0.0;
double total = 0.0;
List<ListaMandado> listaGlobal = [];
List<ListaMandado> selectedProducts = [];
Map<String, List<bool>> isSelected = {};
Map<String, bool> categoriaLista = {
  'Frutas y Verduras': false,
  'Carnes Frias': false,
  'Abarrotes': false,
  'Aseo Personal': false,
  'Baño': false,
  'Cocina': false,
  'Hogar': false,
  'Otros': false
};

class DBProvider {
  static Database _database;
  static final DBProvider db = DBProvider._();
  DBProvider._();

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  Future<Database> initDB() async {
    //path donde almacenaremos la DB
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'MandadoDB.db');
    // print(path);

    //creacion de la DB
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('''
        CREATE TABLE Lista(
          ID TEXT PRIMARY KEY,
          nombre TEXT,
          precio REAL,
          basics INTEGER,
          categoria TEXT
        )
        ''');
      //los triples ''' son de dart para multilinea
    });
  }

  //Create or INSERT (RECOMENDADO)
  Future<int> newList(Map<String, Object> mandado) async {
    final db = await database;
    // await Future.delayed(Duration(seconds: 1));
    final res = await db.insert('Lista', mandado,
        conflictAlgorithm: ConflictAlgorithm.replace);
    // print(res);
    // la variable res es el ID del ultimo registro guardado
    return res;
  }

  //READ
  Future<List> getAllProducts() async {
    final db = await database;
    final res = await db.query('Lista');
    return res.isNotEmpty
        ? res.map((s) => ListaMandado.fromJson(s)).toList()
        : [];
  }

  Future<int> getListLenght() async {
    final db = await database;
    final res = await db.query('Lista');
    print(res.length);
    return res.length;
  }

  Future<ListaMandado> getProductsById(int id) async {
    final db = await database;
    id = int.parse(id.toString());
    final res = await db.query('Lista', where: 'id = ?', whereArgs: [id]);
    return res.isNotEmpty ? ListaMandado.fromJson(res.first) : null;
  }

  Future<List> getProductsByCategory(String categoria) async {
    final db = await database;
    List<Map<String, Object>> res = await db
        .rawQuery('''SELECT * FROM Lista WHERE categoria = "$categoria" ''');
    // res = _sortListByBasics(res);
    return res.isNotEmpty ? _sortListByBasics(res) : [];
  }

  List<ListaMandado> _sortListByBasics(List<Map<String, Object>> listado) {
    List<ListaMandado> lista =
        listado.map((s) => ListaMandado.fromJson(s)).toList();
    List<ListaMandado> res = [];
    // print(lista.iterator);
    lista.forEach((element) {
      if (element.basics == 1) {
        res.add(element);
      }
    });
    lista.forEach((element) {
      if (element.basics == 0) {
        res.add(element);
      }
    });
    return res;
  }

  Future<int> deleteAllScans() async {
    final db = await database;
    final res = await db.delete('Lista');
    print('internal DB erased');
    return res;
  }

/*  #Version 2.0

    Future<int> newList(ListaMandado mandado) async {
    final db = await database;
    final res = await db.insert('Lista', mandado.toJson());
    print(res);
    // la variable res es el ID del ultimo registro guardado
    return res;
  }

  //UPDATE
  Future<int> updateScan(ScanModel nuevoScan) async {
    final db = await database;
    final res = await db.update('Scans', nuevoScan.toJson(),
        where: 'id = ?', whereArgs: [nuevoScan.id]);
    return res;
  }

  //DELETE metodo1
  Future<int> deleteScan(int id) async {
    final db = await database;
    final res = await db.delete('Scans', where: 'id = ?', whereArgs: [id]);
    return res;
  }
 */
}
