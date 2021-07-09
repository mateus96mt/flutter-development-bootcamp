import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/models/task.model.dart';
import 'package:todo_list/models/task_data.model.dart';

class Rodape extends StatelessWidget {
  final TextEditingController textEditingController;
  final ScrollController scrollController;

  Rodape({required this.textEditingController, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: textEditingController,
                style: TextStyle(
                  color: Colors.lightBlueAccent,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                if (this.textEditingController.text != '') {
                  Provider.of<TaskData>(context, listen: false).add(
                    Task(
                      name: textEditingController.text,
                    ),
                  );
                  this.textEditingController.clear();
                  scrollController.animateTo(
                    scrollController.position.maxScrollExtent + 100,
                    duration: Duration(microseconds: 10),
                    curve: Curves.linear,
                  );
                }
              },
              child: CircleAvatar(
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                backgroundColor: Colors.lightBlueAccent,
              ),
            )
          ],
        ),
      ),
    );
  }
}
