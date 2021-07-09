import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/components/header.component.dart';
import 'package:todo_list/components/rodape.component.dart';

import '../components/task_list_context.component.dart';

class TaskScreen extends StatelessWidget {
  final TextEditingController textEditingController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Header(),
            Expanded(
              child: TaskListContentView(scrollController: scrollController),
            ),
            Rodape(
              textEditingController: textEditingController,
              scrollController: scrollController,
            ),
          ],
        ),
      ),
    );
  }
}
