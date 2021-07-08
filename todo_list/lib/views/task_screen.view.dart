import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'class.model.dart';
import 'list_item.dart';

class TaskScreen extends StatefulWidget {
  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  TextEditingController textEditingController = TextEditingController();
  ScrollController scrollController = ScrollController();

  List<Task> tasksList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            header(),
            Expanded(
              child: listContent(),
            ),
            rodape(),
          ],
        ),
      ),
    );
  }

  Widget separator() {
    return SizedBox(
      width: 10,
    );
  }

  void buildModal() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          // padding: EdgeInsets.all(15),
          child: Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom + 20,
              left: 35,
              right: 35,
              top: 35,
            ),
            child: Column(
              children: [
                Text(
                  'Add task',
                  style: TextStyle(
                    color: Colors.lightBlueAccent,
                    fontSize: 24,
                  ),
                ),
                TextField(
                  controller: textEditingController,
                  style: TextStyle(
                    color: Colors.lightBlueAccent,
                  ),
                ),
                SizedBox(
                  height: 14,
                ),
                FlatButton(
                  color: Colors.lightBlueAccent,
                  onPressed: () {
                    print('tes');
                    addTask();
                  },
                  child: Text(
                    'Add',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget header() {
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
            '${this.tasksList.length} tasks',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          Expanded(
            child: Container(),
          ),
          GestureDetector(
            onTap: deleteAllTasks,
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

  Widget listContent() {
    return Container(
      padding: EdgeInsets.all(15),
      child: ListView.builder(
        controller: scrollController,
        itemCount: tasksList.length,
        itemBuilder: (context, index) {
          return //Text('test');
              TaskListItem(
            task: tasksList[index],
            onChanged: () {
              this.setState(() {
                this.tasksList[index].isDone = !this.tasksList[index].isDone;
              });
            },
            onDelete: () {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: Text('Deleting item'),
                  content: Text(
                      'Are you sure you want to delete item \"${tasksList[index].name}\"?'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('No'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        this.setState(() {
                          this.tasksList.removeAt(index);
                        });
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
    );
  }

  void addTask() {
    if (this.textEditingController.text != '') {
      setState(() {
        this.tasksList.add(
              Task(name: this.textEditingController.text),
            );
        this.textEditingController.clear();
        this.scrollController.animateTo(
              this.scrollController.position.maxScrollExtent + 100,
              duration: Duration(microseconds: 10),
              curve: Curves.linear,
            );
      });
    }
  }

  Widget rodape() {
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
              onTap: addTask,
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

  void deleteAllTasks() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text('Deleting all ${this.tasksList.length} items'),
        content: Text('Are you sure you want to all items?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                this.tasksList.clear();
              });
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }
}
