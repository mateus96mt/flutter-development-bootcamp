import 'package:flutter/material.dart';

void buildModal(BuildContext context,
    TextEditingController textEditingController, VoidCallback addTask) {
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
