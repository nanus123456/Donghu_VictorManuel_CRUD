import 'package:sqflite/sqflite.dart';
import 'package:crud_flutter_victor_donghu/modelos/notas.dart';
import 'package:path/path.dart';

class Operaciones{
  static Future<Database> _openDB() async{
    try{

      return await openDatabase(
        join(await getDatabasesPath(),'notas.db'),
        onCreate: (db, version){
          return db.execute(
            "CREATE TABLE IF NOT EXISTS notas(id INTEGER PRIMARY KEY AUTOINCREMENT, titulo TEXT, descripcion TEXT)",
          );
        },
          version: 1,

      );
    }catch (e){
      print('error al abrir la bd: $e');
      throw Exception('error al abrir la bd');
    }
  }

  static Future <void> insertarOperacion(Nota nota) async
  {
    Database db = await _openDB();
    db.insert('notas', nota.toMap());
  }

  static Future <void> eliminarOperacion (Nota nota) async{
    Database db = await _openDB();
    db.delete('notas', where: 'id = ?', whereArgs: [nota.id]);
  }
  static Future <void> actualizarOperacion (Nota nota) async{
    Database db = await _openDB();
    db.update('notas', nota.toMap(), where: 'id = ?', whereArgs: [nota.id] );
  }
  static Future <List<Nota>> obtenerNotas()async{
    Database db = await _openDB();
    final List<Map<String, dynamic>>notasMaps = await db.query('notas');

    for(var n in notasMaps){
      print("___" + n['titulo'].toString());
      print("___" + n['descripcion'].toString());


    }
  

    return List.generate(notasMaps.length, (i)
      {
        return Nota(
          id: notasMaps[i]['id'],
          titulo: notasMaps[i]['titulo'],
          descripcion: notasMaps[i]['descripcion'],

        );
    } );
  }
}