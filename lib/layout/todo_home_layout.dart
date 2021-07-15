import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:todo_app/layout/cubit/todo_cubit.dart';
import 'package:todo_app/model/task_model.dart';
import 'package:todo_app/modules/add_task/add_task.dart';
import 'package:todo_app/modules/all_tasks/all_tasks.dart';
import 'package:todo_app/modules/calendar/calendar_screen.dart';

import '../test_new_packages/test_radial.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  _HomeLayoutState createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  // this is the data for now
  var title = DateFormat('EEEE').format(DateTime.now());
  var day = DateFormat('dd').format(DateTime.now());

  bool checkTasks = false;
  late List<GDPdata> _chargeData;
  late TooltipBehavior _tooltipBehavior;
  late List<Task> tasks;

  @override
  void initState() {
    _chargeData = getChargeData();
    _tooltipBehavior = TooltipBehavior(enable: true);
    // TODO: implement initState
    TodoCubit.get(context).createTaskDatabase();
    tasks = TodoCubit
        .get(context)
        .newTasks;
    super.initState();
  }

  List<GDPdata> getChargeData() {
    final List<GDPdata> chargData = [
      GDPdata('Ahmed', 40),
      GDPdata('zezo', 60),
      GDPdata('fatma', 80),
    ];
    return chargData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF17171A),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
          Navigator.push(
              context,PageRouteBuilder(
            opaque: false,
              pageBuilder: (context,animation, _) {
                return AddNewTask();
              },),);
        },

        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.pink,
      ),
      //floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xFF17171A),
        elevation: 0.0,
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
          child: FaIcon(
            FontAwesomeIcons.th,
            color: Colors.white,
            size: 35,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => CalendarScreen()));
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 20, 0),
              child: FaIcon(
                FontAwesomeIcons.calendarAlt,
                color: Colors.white,
                size: 35,
              ),
            ),
          ),
        ],
        title: Padding(
          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
          child: Text(
            "$title $day",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: BlocConsumer<TodoCubit, TodoState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              var cubit = TodoCubit.get(context);
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
                    child: Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Color(0xFF232329),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: SfCircularChart(
                        margin: EdgeInsets.zero,
                        legend: Legend(
                            isVisible: true,
                            overflowMode: LegendItemOverflowMode.wrap,
                            textStyle: TextStyle(color: Colors.white),
                            iconHeight: 20,
                            iconWidth: 20,
                            position: LegendPosition.left),
                        tooltipBehavior: _tooltipBehavior,
                        series: <CircularSeries>[
                          RadialBarSeries<GDPdata, String>(
                            trackColor: Colors.white,
                            cornerStyle: CornerStyle.bothCurve,
                            gap: '7',
                            radius: '90',
                            enableSmartLabels: true,
                            maximumValue: 100,
                            dataSource: _chargeData,
                            xValueMapper: (GDPdata data, _) => data.contenent,
                            yValueMapper: (GDPdata data, _) => data.gdb,
                            enableTooltip: true,
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 15, 0, 0),
                    child: Text(
                      'Projects',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // this is the project list
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Container(
                      width: double.infinity,
                      height: 250,
                      decoration: BoxDecoration(
                        color: Color(0xFF17171A),
                      ),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: ListView(
                          physics: BouncingScrollPhysics(),
                          padding: EdgeInsets.zero,
                          scrollDirection: Axis.horizontal,
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 30, 10),
                              child: Container(
                                width: 170,
                                height: double.infinity,
                                decoration: BoxDecoration(
                                  color: Color(0xFF232329),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 30, 10),
                              child: Container(
                                width: 170,
                                height: double.infinity,
                                decoration: BoxDecoration(
                                  color: Color(0xFF232329),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 30, 10),
                              child: Container(
                                width: 170,
                                height: double.infinity,
                                decoration: BoxDecoration(
                                  color: Color(0xFF232329),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  // tasks dayley
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Tasks',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => AllTasks()));
                          },
                          child: Text(
                            'View All',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.pink,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  for (int i = 0; i < cubit.todayTasks.length; i++)
                    GestureDetector(
                      onTap: (){
                        //Navigator.push(context, MaterialPageRoute(builder: (context) => AllTasks()));
                      print(cubit.todayTasks[i].title);
                      },
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                        child: Container(
                          width: double.infinity,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Color(0xFF232329),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20.0, top: 15),
                            child: Text(
                              cubit.todayTasks[i].title,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          )
      ),
    );
  }
}

class _PieData {
  _PieData(this.xData, this.yData, this.text);

  final String xData;
  final num yData;
  final String text;
}
