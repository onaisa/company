import 'package:company/UI/component/component.dart';
import 'package:company/cubit/companyapp_cubit.dart';
import 'package:company/models/taskmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskesScreen extends StatefulWidget {
  @override
  _TaskesScreenState createState() => _TaskesScreenState();
}

class _TaskesScreenState extends State<TaskesScreen> {
  Color dodeColor = Colors.green;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CompanyappCubit, CompanyappState>(
      listener: (context, state) {
        if (state is DoneTaskSuccessState) {
          showToast(text: 'done success', state: ToastStates.SUCCESS);
        } else if (state is DoneTaskErrorState) {
          showToast(text: '${state.error}', state: ToastStates.ERROR);
        }
      },
      builder: (context, state) {
        CompanyappCubit cubit = CompanyappCubit.get(context);
        return Center(
            child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ' your taskes :',
                    style: TextStyle(fontSize: 22.0, color: Colors.deepOrange),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  if (state is DoneTaskLoudingState) LinearProgressIndicator(),
                  Expanded(
                    child: Card(
                      elevation: 5.0,
                      child: cubit.allTaskes.length == 0
                          ? Center(child: Text('no taskes'))
                          : ListView.separated(
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return TaskItem(
                                    context: context,
                                    index: index,
                                    taskModel: cubit.allTaskes[index]);
                              },
                              separatorBuilder: (context, index) => Divider(),
                              itemCount: cubit.allTaskes.length),
                    ),
                  ),
                  if (cubit.userModel.administration == true)
                    Align(
                      alignment: AlignmentDirectional.bottomEnd,
                      child: FloatingActionButton(
                        onPressed: () {
                          if (cubit.userModel.administration == true) {
                            showBottomSheet(
                                elevation: 15.0,
                                context: context,
                                builder: (context) => BuildBottomSheetItem());
                          } else {
                            showToast(
                                text: 'only admin cane add task ',
                                state: ToastStates.WARNING);
                          }
                        },
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ));
      },
    );
  }

  Widget TaskItem({int index, BuildContext context, TaskModel taskModel}) =>
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Text(
                      'Task ${index + 1} :',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    Expanded(
                      child: Text(
                        taskModel.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              CircleAvatar(
                backgroundColor:
                    CompanyappCubit.get(context).isdone[taskModel.id] == false
                        ? Colors.grey[100]
                        : Colors.teal[300],
                child: IconButton(
                    onPressed: () {
                      CompanyappCubit.get(context).taskesDone(id: taskModel.id);
                    },
                    icon: Icon(
                      Icons.done,
                      color: Colors.black,
                    )),
              ),
              SizedBox(
                width: 5.0,
              ),
              CircleAvatar(
                backgroundColor:
                    CompanyappCubit.get(context).isdone[taskModel.id] == true
                        ? Colors.grey[100]
                        : Colors.yellow,
                child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.warning_outlined,
                      color: Colors.black,
                    )),
              ),
              SizedBox(
                width: 8.0,
              ),
            ],
          ),
          Text(
            taskModel.description,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.caption,
          ),
        ]),
      );
}

class BuildBottomSheetItem extends StatelessWidget {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController IdEmployeeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CompanyappCubit, CompanyappState>(
      listener: (context, state) {
        if (state is CreateTaskSuccessState) {
          showToast(text: 'create task success', state: ToastStates.SUCCESS);
          CompanyappCubit.get(context).getAllTaskes();
          Navigator.pop(context);
        } else {
          if (state is CreateTaskErrorState)
            showToast(text: 'can not create task ', state: ToastStates.ERROR);
        }
      },
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.all(15.0),
          color: Colors.orange[50],
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                color: Colors.white,
                child: TextFormField(
                  maxLines: 1,
                  controller: titleController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.edit),
                      labelText: 'title',
                      border: OutlineInputBorder()),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                color: Colors.white,
                child: TextFormField(
                  maxLines: 2,
                  controller: descriptionController,
                  keyboardType: TextInputType.multiline,
                  scrollPhysics: BouncingScrollPhysics(),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.edit),
                    labelText: 'description',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.ideographic,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: Container(
                        color: Colors.white,
                        child: TextFormField(
                          controller: IdEmployeeController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'employee number',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                        child: Container(
                      color: Colors.orange,
                      child: MaterialButton(
                        onPressed: () {
                          CompanyappCubit.get(context).createTask(
                              id: int.parse(IdEmployeeController.text),
                              title: titleController.text,
                              description: descriptionController.text);
                        },
                        child: Text(
                          'create',
                          style: TextStyle(color: Colors.white, fontSize: 20.0),
                        ),
                      ),
                    )),
                  ],
                ),
              ),
              if (state is CreateTaskLoudingState) LinearProgressIndicator(),
            ],
          ),
        );
      },
    );
  }
}
