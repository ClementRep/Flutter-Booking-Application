import 'package:sqflite/sqflite.dart';


class db {
  late Database _database;


  open() async {
    _database = await openDatabase(
        'local_db.db',
        version: 1,
        onCreate: (Database db, int version) async {
          await db.execute('Create table details('
              'id integer primary key autoincrement'
              'date not null'
              'time not null'
              'firstname not null'
              'lastname  not null'
              ')');
        }
    );
  }

}