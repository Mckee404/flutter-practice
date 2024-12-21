//タイトル、説明、タスクの色を選択（カラーピッカー、外部のパッケージ）
//辞書型,クラス


import 'package:flutter/material.dart';
import 'package:flutter_practice/class_todo.dart';
import 'todo_add_page.dart';
import 'todo_item.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToDoリスト',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: ToDoListPage(),
    );
  }
}

class ToDoListPage extends StatefulWidget {
  @override
  _ToDoListPageState createState() => _ToDoListPageState();
}

class _ToDoListPageState extends State<ToDoListPage> {
  List<Todo> toDoList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('リスト一覧'),
      ),
      body: ListView.builder(
        itemCount: toDoList.length,
        itemBuilder: (context, index) {
          return ToDoItem(
              item: toDoList[index],
              onDelete: () {
                setState(() {
                  toDoList.removeAt(index);
                });
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newTodo = await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) {
              return ToDoAddPage();
            }),
          );
          if (newTodo != null) {
            setState(() {
              toDoList.add(newTodo);
            });
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}