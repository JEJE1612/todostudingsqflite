import 'package:equatable/equatable.dart';

abstract class TodoState extends Equatable {
  const TodoState();
  @override
  List<Object> get props => [];
}

class TodoInitial extends TodoState {
  final int counter;

  const TodoInitial(this.counter);
  @override
  List<Object> get props => [];
}

class AddTodoState extends TodoState {}

class RemoveTodoState extends TodoState {}
