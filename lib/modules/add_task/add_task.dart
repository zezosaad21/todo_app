import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/layout/cubit/todo_cubit.dart';
import 'package:todo_app/model/task_model.dart';
import 'package:todo_app/shared/widgets/color_picker.dart';

class AddNewTask extends StatelessWidget {
   AddNewTask({Key? key}) : super(key: key);

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoCubit, TodoState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = TodoCubit.get(context);

        return Scaffold(
          //backgroundColor: Colors.transparent,
          backgroundColor: Color(0xFF17171A),
          appBar: AppBar(
            backgroundColor: Color(0xFF17171A),
            elevation: 0.0,
            actions: [
              //IconButton(onPressed: (){}, icon: Icon(Icons.check),hoverColor: Colors.transparent,)
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: GestureDetector(
                  onTap: () {
                    //TODO: type her function of insert task data in the database
                    cubit.insertTask(
                        Task(title: titleController.text,
                            description: descriptionController.text,
                            status: 'new',
                            color: cubit.color,
                            time: cubit.date)).then((value){
                              Navigator.pop(context);
                    });
                  },
                  child: Icon(
                    Icons.check,
                  ),
                ),
              )
            ],
          ),
          body: LayoutBuilder(
            builder: (context, constrain) => SafeArea(
              child: TweenAnimationBuilder(
                tween: Tween(begin: 0.0, end: 1.0),
                duration: Duration(milliseconds: 1500),
                builder: ( context, double value, child){
                  return ShaderMask(
                      shaderCallback: (rect) {
                       return RadialGradient(
                          radius: value * 5,
                           colors: [
                             Colors.white,
                             Colors.white,
                             Colors.transparent,
                             Colors.transparent,
                           ],
                         stops: [0.0,0.55,0.6,1.0],
                         center: FractionalOffset(0.95,0.90),

                       ).createShader(rect);
                      }, child: child,);
                },
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height,
                    child:  Padding(
                      padding:
                      const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Title",
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 2.0,
                            ),
                          ),
                          TextFormField(
                            controller: titleController,
                            decoration: InputDecoration(

                              border: InputBorder.none, hintText: 'Title ',),
                          ),
                          Divider(),
                          Container(
                            width: double.infinity,
                            height: 70,
                            child: Row(
                              children: [
                                Text(
                                  'Color : ',
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    height: 30,
                                    child: MyColorPicker(
                                      onSelectColor: (value) =>
                                          cubit.changeColor(value),
                                      availableColors: [
                                        0xFFFADEAD,
                                        0xFFF7E5D5,
                                        0xFFF8DBD9,
                                        0xFFFAA2A4,
                                        0xFFEDEEEF,
                                        0xFF9DECFC,
                                        0xFFF8F580,
                                        0xFFC7A1D3,
                                        0xFFFFD9E3,
                                        0xFFffcdd2,
                                      ],
                                      initialColor: Color(cubit.color),
                                      circleItem: true,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Description",
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 2.0,
                            ),
                          ),
                          Container(
                            height: 120,
                            child: TextFormField(
                              controller: descriptionController,
                              keyboardType: TextInputType.multiline,
                              textInputAction: TextInputAction.newline,
                              maxLines: null,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Descriptions',
                              ),
                            ),
                          ),
                          Container(
                            height: 50,
                            width: double.infinity,
                            child: Row(
                              children: [
                                GestureDetector(
                                  child: Icon(Icons.calendar_today,size: 30,),
                                  onTap: ()=> cubit.pickedDate(context),
                                ),
                                SizedBox(width: 10,),
                                Text(
                                  cubit.date == DateFormat.yMMMd().format(DateTime.now()) ? "Today" : cubit.date
                                  , style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),)
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
