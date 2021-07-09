import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/task_data.model.dart';

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 30,
        right: 30,
        top: 20,
        bottom: 20,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            child: Icon(
              Icons.list,
              color: Colors.lightBlueAccent,
              size: 20,
            ),
            backgroundColor: Colors.white,
            radius: 20,
          ),
          separator(),
          Text(
            'Todoey',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          separator(),
          Text(
            '${Provider.of<TaskData>(context).tasksCount} tasks',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          Expanded(
            child: Container(),
          ),
          GestureDetector(
            onTap: () {
              deleteAllTasks(context);
            },
            child: CircleAvatar(
              child: Icon(
                Icons.delete,
                color: Colors.black,
                size: 40,
              ),
              backgroundColor: Colors.lightBlueAccent,
            ),
          )
        ],
      ),
    );
  }

  void deleteAllTasks(BuildContext context) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
            'Deleting all ${Provider.of<TaskData>(context).tasksCount} items'),
        content: Text('Are you sure you want to all items?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Provider.of<TaskData>(context, listen: false).clear();
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }

  Widget separator() {
    return SizedBox(
      width: 10,
    );
  }
}
