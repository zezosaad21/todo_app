import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbols.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/model/task_model.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit() : super(TodoInitial());

  static TodoCubit get(context) => BlocProvider.of(context);

  int color = 0xFFFF2196F3;

  String date = DateFormat.yMMMd().format(DateTime.now());

  late List<Task> allTasks;
  late List<Task> newTasks = [];
  late List<Task> doneTasks = [];
  late List<Task> archivedTasks = [];
  late List<Task> todayTasks = [];

  void changeColor(value) {
    color = value;

    emit(ColorPickChangeState());
    print(color);
  }

  void pickedDate(BuildContext context) {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2001),
            lastDate: DateTime(2222))
        .then((value) {
      print(value);

      date = DateFormat.yMMMd().format(value!);
      print(date);
      emit(PickDateTask());
    }).catchError((error) {
      print(error.toString());
    });
  }

  late final Future<Database> database;

  void createTaskDatabase() async {
    database = openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      join(await getDatabasesPath(), 'tasks_database.db'),
      // When the database is first created, create a table to store dogs.
      onCreate: (db, version) {
        // Run the CREATE TABLE statement on the database.
        return db.execute(
          'CREATE TABLE tasks(id INTEGER PRIMARY KEY, title TEXT, description TEXT,color INTEGER , time TEXT , status TEXT)',
        );
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );

    allTasks = [];
    newTasks = [];
    doneTasks = [];
    archivedTasks = [];
    todayTasks = [];
    allTasks = await tasks();
    allTasks.forEach((element) {
      if(element.status == 'new'){
        newTasks.add(element);
      }else if(element.status == "done"){
        doneTasks.add(element);
      }else if(element.status == "archived"){
        archivedTasks.add(element);
      }
      if(element.time == DateFormat.yMMMd().format(DateTime.now())){
        todayTasks.add(element);
      }
    });

/*
  Future<void> deleteDog(int id) async {
    // Get a reference to the database.
    final db = await database;

    // Remove the Dog from the database.
    await db.delete(
      'dogs',
      // Use a `where` clause to delete a specific dog.
      where: 'id = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }
  */

  }

  Future<void> updateTask(Task task) async {
    // Get a reference to the database.
    final db = await database;

    // Update the given Dog.
    await db.update(
      'tasks',
      task.toMap(),
      // Ensure that the Dog has a matching id.
      where: 'id = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [task.id,],
    ).then((value) async {
      print(task.status);
      allTasks = await tasks();
      newTasks = [];
      doneTasks = [];
      archivedTasks = [];
      todayTasks = [];
      allTasks.forEach((element) {
        if(element.status == 'new'){
          newTasks.add(element);
        }else if(element.status == 'done'){
          doneTasks.add(element);
        }else if(element.status == 'archived'){
          archivedTasks.add(element);
        }
        if(element.time == DateFormat.yMMMd().format(DateTime.now())){
          todayTasks.add(element);
        }
      });
      emit(UpdateTaskStatus());
    });
  }

//   void updateTasks({
//   required String status,
//   required int id,
// }) async{
//     final db = await database;
//     db.rawUpdate(
//       'UPDATE tasks SET status = ? WHERE id = ?',
//       ['$status', id],
//     ).then((value){
//       emit(UpdateTaskStatus());
//     });
//   }

  // Define a function that inserts dogs into the database
  Future<void> insertTask(Task task) async {
    // Get a reference to the database.
    final db = await database;

    // Insert the Dog into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same dog is inserted twice.
    //
    // In this case, replace any previous data.
    await db
        .insert(
      'tasks',
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    )
        .then((value) async {
      emit(InsertDatabaseSuccessState());
      print(value);
      allTasks = [];
      newTasks = [];
      doneTasks = [];
      archivedTasks = [];
      todayTasks = [];
      allTasks = await tasks();
      allTasks.forEach((element) {
        if(element.status == 'new'){
          newTasks.add(element);
        }else if(element.status == "done"){
          doneTasks.add(element);
        }else if(element.status == "archived"){
          archivedTasks.add(element);
        }
        if(element.time == DateFormat.yMMMd().format(DateTime.now())){
          todayTasks.add(element);
        }
      });
      //print(allTasks[5].time);
      print(allTasks);
    }).catchError((error) {
      emit(InsertDatabaseErrorState());
      print(error.toString());
    });
  }

  // A method that retrieves all the dogs from the dogs table.
  Future<List<Task>> tasks() async {
    // Get a reference to the database.
    final db = await database;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('tasks');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return Task(
        id: maps[i]['id'],
        title: maps[i]['title'],
        description: maps[i]['description'],
        color: maps[i]['color'],
        time: maps[i]['time'],
        status: maps[i]['status'],
      );
    });
  }


/*

  void createDatabase() async {
    final Future<Database> database = openDatabase(
      join(await getDatabasesPath(), 'tasks.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE tasks(id INTEGER PRIMARY KEY, title TEXT, description TEXT,color INTEGER , time TEXT)',
        );
      },
      version: 1,
    ).then((value) {
      emit(CreateDatabaseSuccessState());
    }).catchError((error){
      emit(CreateDatabaseErrorState());
      print(error.toString());
    });

    Future<void> insertTask(Task task) async {
      final Database db = await database;

      await db
          .insert(
        'tasks',
        task.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      )
          .then((value) async {
        emit(InsertDatabaseSuccessState());
        print(value);
        print(await tasks());
      }).catchError((error){
        emit(InsertDatabaseErrorState());
        print(error.toString());
      });
    }

    // add data in the database
    // Create a tasks and add it to the dogs table
    void addTasks(String title, String description, int color , String time) async {
      await insertTask(Task(title: title, description: description,color: color, time: time));
    }

// A method that retrieves all the dogs from the dogs table.
    Future<List<Task>> tasks() async {
      // get reference to the database.
      final Database db = await database;

      // Query the table for all the tasks.
      final List<Map<String, dynamic>> maps = await db.query('tasks');

      // convert the list
      return List.generate(maps.length, (index) {
        return Task(
          title: maps[index]['title'],
          description: maps[index]['description'],
          color: maps[index]['color'],
          time: maps[index]['time'],
        );
      });
    }
  }
*/
}
