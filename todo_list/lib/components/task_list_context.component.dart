import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/components/list_item.component.dart';
import 'package:todo_list/models/task_data.model.dart';

class TaskListContentView extends StatelessWidget {
  const TaskListContentView({
    Key? key,
    required this.scrollController,
  }) : super(key: key);

  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      builder: (context, taskData, child) => Container(
        padding: EdgeInsets.all(15),
        child: ListView.builder(
          controller: scrollController,
          itemCount: taskData.tasksCount,
          itemBuilder: (context, index) {
            return //Text('test');
                TaskListItem(
              task: taskData.tasks[index],
              onChanged: () {
                Provider.of<TaskData>(context, listen: false)
                    .changeTaskState(index);
              },
              onDelete: () {
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: Text('Deleting item'),
                    content: Text(
                        'Are you sure you want to delete item \"${taskData.tasks[index].name}\"?'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('No'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Provider.of<TaskData>(context, listen: false)
                              .removeAt(index);
                        },
                        child: const Text('Yes'),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
      ),
    );
  }
}
