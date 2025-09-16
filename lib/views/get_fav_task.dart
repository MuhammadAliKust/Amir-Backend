import 'package:amir_backend/models/task.dart';
import 'package:amir_backend/provider/user.dart';
import 'package:amir_backend/services/task.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GetFavoriteTask extends StatelessWidget {
  const GetFavoriteTask({super.key});

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text("Get Favorite Task")),
      body: StreamProvider.value(
        value: TaskServices().getMyFavoriteTask(
          user.getUser().docId.toString(),
        ),
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
              );
            },
          );
        },
      ),
    );
  }
}
