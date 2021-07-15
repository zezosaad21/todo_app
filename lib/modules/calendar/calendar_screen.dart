import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF17171A),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xFF17171A),
        elevation: 0.0,
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
          child: GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: FaIcon(
              FontAwesomeIcons.arrowLeft,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
      ),
      body: SfCalendar(
        backgroundColor: Color(0xFF17171A),
        view: CalendarView.day,
        firstDayOfWeek: 6,
        //initialSelectedDate: DateTime(2021,09,01,05,30),
        //initialDisplayDate: DateTime(2021,09,01,05,30),
        dataSource: MeetingDataSource(getAppointments()),
        onTap: (CalendarTapDetails details){
          DateTime date = details.date!;
          dynamic appointments = details.appointments;
          CalendarElement view = details.targetElement;
          var d = details.resource;
          print(date);
          print(appointments);
          print(view);
        },
      ),
    );
  }
}

List<Appointment> getAppointments(){
  List<Appointment> meetings = <Appointment>[];
  final DateTime today = DateTime.now();
  final DateTime startTime = DateTime(today.year,today.month,today.day, 9,0,0);
  //final DateTime endTime = DateTime(today.year,today.month,today.day, 9,0,0);
  final DateTime endTime = startTime.add(const Duration(hours: 3));

  meetings.add(Appointment(
    startTime: startTime,
    endTime: endTime,
    subject: "StudyEnglish",
    color: Colors.red,
    recurrenceRule: 'FREQ=DAILY;COUNT=10',
  ));

  return meetings;
}

class MeetingDataSource extends CalendarDataSource{

  MeetingDataSource(List<Appointment> source) {
    appointments = source;

  }
}