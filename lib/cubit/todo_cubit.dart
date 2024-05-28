import 'package:bloc/bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoapp/cubit/todo_state.dart';
import 'package:todoapp/model/todo_model.dart';
import 'package:todoapp/repositories/todo_repo.dart';

class TodoCubit extends Cubit<TodoState> {
  final _todoRecpo = TodoRepository();
  final Database database;
  int _counter = 1;
  TodoCubit({required this.database}) : super(const TodoInitial(0));
  List<Todo> _todos = [];
  List<Todo> get todos => _todos;
  Future<void> getTodo() async {
    try {
      _todos = await _todoRecpo.getTodo(database: database);
      emit(TodoInitial(_counter));
    } catch (e) {}
  }

  Future<void> addTodo(String text) async {
    try {
      await _todoRecpo.addTodo(database: database, text: text);
      emit(AddTodoState());
      getTodo();
    } catch (e) {}
  }

  Future<void> removeTodo(int id) async {
    try {
      await _todoRecpo.removeTodo(
        database: database,
        id: id,
      );
      emit(TodoInitial(_counter));
    } catch (e) {}
  }
}
