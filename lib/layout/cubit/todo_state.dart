part of 'todo_cubit.dart';

@immutable
abstract class TodoState {}

class TodoInitial extends TodoState {}
class CreateDatabaseSuccessState extends TodoState {}
class CreateDatabaseErrorState extends TodoState {}
class InsertDatabaseSuccessState extends TodoState {}
class InsertDatabaseErrorState extends TodoState {}
class AddTasksState extends TodoState {}
class ColorPickChangeState extends TodoState {}
class PickDateTask extends TodoState {}
class UpdateTaskStatus extends TodoState {}
