import 'package:amir_backend/models/priority.dart';
import 'package:amir_backend/models/task.dart';
import 'package:amir_backend/services/task.dart';
import 'package:amir_backend/views/create_task.dart';
import 'package:amir_backend/views/get_completed_task.dart';
import 'package:amir_backend/views/get_incompleted_task.dart';
import 'package:amir_backend/views/get_priority.dart';
import 'package:amir_backend/views/update_task.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GetPriorityTaskView extends StatelessWidget {
  final PriorityModel model;

  const GetPriorityTaskView({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("${model.name} Task")),
      body: StreamProvider.value(
        value: TaskServices().getTaskByPriorityID(model.docId.toString()),
        initialData: [TaskModel()],
        builder: (context, child) {
          List<TaskModel> taskList = context.watch<List<TaskModel>>();
          return ListView.builder(
            itemCount: taskList.length,
            itemBuilder: (context, i) {
              return ListTile(
                leading: Icon(Icons.task),
                title: Text(taskList[i].title.toString()),
                subtitle: Text(taskList[i].description.toString()),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Checkbox(
                      value: taskList[i].isCompleted,
                      onChanged: (val) async {
                        try {
                          await TaskServices().markTaskAsComplete(taskList[i]);
                        } catch (e) {
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text(e.toString())));
                        }
                      },
                    ),
                    IconButton(
                      onPressed: () async {
                        try {
                          await TaskServices().deleteTask(taskList[i]).then((
                            val,
                          ) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "Task has been deleted successfully",
                                ),
                              ),
                            );
                          });
                        } catch (e) {
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text(e.toString())));
                        }
                      },
                      icon: Icon(Icons.delete, color: Colors.red),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                UpdateTaskView(model: taskList[i]),
                          ),
                        );
                      },
                      icon: Icon(Icons.edit, color: Colors.blue),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
