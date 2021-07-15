import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/layout/cubit/todo_cubit.dart';
import 'package:todo_app/model/task_model.dart';

class AllTasks extends StatelessWidget {
  const AllTasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoCubit, TodoState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        TodoCubit cubit = BlocProvider.of(context);
        List<Task> allTasks = cubit.allTasks;
        List<Task> newTask = cubit.newTasks;
        List<Task> doneTask = cubit.doneTasks;
        List<Task> archiveTask = cubit.archivedTasks;


        return DefaultTabController(
          length: 4,
          child: Scaffold(
            backgroundColor: Color(0xFF17171A),
            appBar: AppBar(
              bottom: TabBar(
                tabs: [
                  Tab(child: Text("All"),),
                  Tab(child: Text("New"),),
                  Tab(child: Text("Done"),),
                  Tab(child: Text("Archived"),),
                ],
              ),
              backgroundColor: Color(0xFF17171A),
              elevation: 0.0,
            ),
            body: TabBarView(
              physics: BouncingScrollPhysics(),
              children: [
                _buildContentTask(cubit, allTasks),
                _buildContentTask(cubit, newTask),
                _buildContentTask(cubit, doneTask),
                _buildContentTask(cubit, archiveTask),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildContentTask(TodoCubit cubit, List<Task> tasks )=> Padding(
    padding: const EdgeInsets.all(8.0),
    child: StaggeredGridView.countBuilder(
      physics: BouncingScrollPhysics(),
      crossAxisCount: 4,
      itemCount: tasks.length,
      itemBuilder: (BuildContext context, int index) =>
          Stack(
            children: [
              Container(
                  decoration: BoxDecoration(
                      color: Color(tasks[index].color),
                      borderRadius: BorderRadius.circular(20.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white12,
                          blurRadius: 3,
                          offset: Offset(0.0,0.5),
                          spreadRadius: 3.0,
                        )
                      ]
                  ),
                  child:  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(tasks[index].title, style: GoogleFonts.caveat(
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF17171A),
                          fontSize: 22.0,
                        )),
                        Divider(color: Colors.black,),
                        SizedBox(height: 10,),
                        Text(tasks[index].description, style: GoogleFonts.caveat(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 20.0,
                        )),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                GestureDetector(
                                    child: Icon(
                                      tasks[index].status == 'done'? FontAwesomeIcons.checkDouble :
                                      FontAwesomeIcons.checkCircle,
                                      size: 20,
                                      color:tasks[index].status == 'done'? Colors.green: Color(0xFF954C4CFF),
                                    ),
                                  onTap: (){
                                      cubit.updateTask(
                                          Task(
                                            id: tasks[index].id,
                                              status: 'done',
                                              title: tasks[index].title,
                                              description:tasks[index].description ,
                                              color: tasks[index].color,
                                              time: tasks[index].time),);
                                  },
                                ),

                                SizedBox(width: 10,),
                                GestureDetector(
                                  child: Icon(
                                    tasks[index].status == 'archived'? Icons.archive:
                                    Icons.archive_outlined,
                                    size: 24,
                                    color:tasks[index].status == 'archived'? Colors.green: Color(0xFF954C4CFF),),
                                onTap: (){
                                  cubit.updateTask(
                                    Task(
                                        id: tasks[index].id,
                                        status: "archived",
                                        title: tasks[index].title,
                                        description:tasks[index].description ,
                                        color: tasks[index].color,
                                        time: tasks[index].time),);
                                },
                                ),
                              ],
                            ),
                            Text(tasks[index].time, style: GoogleFonts.caveat(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 20.0,
                            )),
                          ],
                        ),

                      ],
                    ),
                  )),
              if(tasks[index].status == 'new')
              Align(
                  alignment: Alignment.topRight,
                  child: Container(

                    height: 30,width: 50,
                    decoration: BoxDecoration(
                      color: Colors.pink,
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    child: Center(
                      child: Text(tasks[index].status),
                    ),
                  ),
              ),
            ],
          ),
      staggeredTileBuilder: (int index) =>
          StaggeredTile.fit(2),
      mainAxisSpacing: 5.0,
      crossAxisSpacing: 5.0,
    ),
  );
}
