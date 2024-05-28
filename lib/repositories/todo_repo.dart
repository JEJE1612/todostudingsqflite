import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:todoapp/model/todo_model.dart';

class TodoRepository {
  Future<List<Todo>> getTodo({required Database database}) async {
    final datas = await database.rawQuery('SELECT * FROM todoapp');
    List<Todo> todos = [];
    for (var item in datas) {
      todos.add(Todo(item['id'] as int, item['name'] as String));
    }
    return todos;
  }

  Future<dynamic> addTodo(
      {required Database database, required String text}) async {
    return await database.transaction((txn) async {
      await txn.rawInsert('INSERT INTO todoapp(name) VALUES("$text")');
    });
  }

  Future<dynamic> removeTodo(
      {required Database database, required int id}) async {
    return await database.transaction((txn) async {
      return await txn.rawDelete('DELETE FROM todoapp where id = $id');
    });
  }
}
