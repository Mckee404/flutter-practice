//最後の引数までカンマを入れて自動整形された形で整えておく
//setStateしなくてもいいところはsetStateしないほうがパフォーマンスに優れる
//クラスにはkeyを設定しておいたほうがよいこともある
//Widget型の変数をif文で制御すると省略できる部分がある
//constをつけたほうがパフォーマンスに優れる
//テキストボックスの中身を逐一変数に保存するのはあまり良くない

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
  void goToTodoAddPage() async {
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('リスト一覧'),
      ),
      body: ListView.builder(
        itemCount: toDoList.length,
        itemBuilder: (context, index) {
          return TodoItem(
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
        child: const Icon(Icons.add),
      ),
    );
  }
}
