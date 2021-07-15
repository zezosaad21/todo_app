import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/layout/cubit/todo_cubit.dart';
import 'package:todo_app/layout/todo_home_layout.dart';
import 'package:todo_app/test_new_packages/test_radial.dart';

import 'bloc_observer.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  runApp(MyApp());

  //calculate dayes left
  // int dayesBetween(DateTime from,DateTime to) {
  //   from = DateTime(from.year, from.month, from.day);
  //   to = DateTime(to.year, to.month, to.day);
  //   return(to.difference(from).inHours/24).round();
  // }
  // print(dayesBetween(DateTime(2001,02,1), DateTime(2001,03,1)));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(), title: 'TODY',
        home: HomeLayout(),
      ),
    );
  }
}
