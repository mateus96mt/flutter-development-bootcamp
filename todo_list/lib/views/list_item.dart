import 'package:flutter/material.dart';
import 'package:todo_list/views/class.model.dart';

class TaskListItem extends StatelessWidget {
  final Task task;
  final VoidCallback onChanged;
  final VoidCallback onDelete;

  TaskListItem(
      {required this.task, required this.onChanged, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            task.name,
            style: task.isDone
                ? TextStyle(
                    decoration: TextDecoration.lineThrough,
                  )
                : TextStyle(),
          ),
          flex: 10,
        ),
        Expanded(
          child: Container(),
        ),
        CheckBoxCustom(
          checkBoxValue: task.isDone,
          onChange: this.onChanged,
        ),
        GestureDetector(
          child: Icon(
            Icons.delete,
            color: Colors.redAccent,
          ),
          onTap: onDelete,
        ),
      ],
    );
  }
}

class CheckBoxCustom extends StatelessWidget {
  final bool checkBoxValue;
  final VoidCallback onChange;

  CheckBoxCustom({required this.checkBoxValue, required this.onChange});

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: checkBoxValue,
      onChanged: (value) {
        onChange();
      },
    );
  }
}
