//aaaaaa

import 'package:flutter/material.dart';
import 'package:flutter_practice/class_todo.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ToDoAddPage extends StatefulWidget {
  @override
  _ToDoAddPageState createState() => _ToDoAddPageState();
}

class _ToDoAddPageState extends State<ToDoAddPage> {
  final _formKey = GlobalKey<FormState>();


  // var todo=Todo(_titleText,_description);
  var todo = Todo();

  void changeColor(Color changedColor) => setState(() => todo.color = changedColor);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('リスト追加'),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.all(64),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // TextField(
              //   decoration: const InputDecoration(
              //     hintText: "タイトルを入力してください",
              //   ),
              //   onChanged: (String value) {
              //     setState(() {
              //       _titleText = value;
              //     });
              //   },
              // ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: "タイトルを入力してください",
                ),
                onFieldSubmitted: (value) {
                  // do something
                },
                onChanged: (String value) {
                  setState(() {
                    todo.title = value;
                  });
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  // 入力値を受け取る
                  if (value == null || value.isEmpty) {
                    return '値を入力してください'; // エラーメッセージとして表示される
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 8,
              ),
              TextField(
                maxLines: null,
                decoration: const InputDecoration(
                  hintText: "説明を入力してください",
                ),
                onChanged: (String value) {
                  setState(() {
                    todo.description = value;
                  });
                },
              ),
              const SizedBox(
                height: 40,
              ),
              Text(
                "ラベルの色を選択",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              Row(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: todo.color,
                    ),
                  ),
                  SizedBox(width: 15,),
                  SlidePicker(
                    pickerColor: todo.color,
                    onColorChanged: changeColor,
                    enableAlpha: false,
                    showIndicator: false,
                    displayThumbColor: false,
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
              const SizedBox(
                height: 60,
              ),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.edit),
                      label: const Text('保存する'),
                      onPressed: () {
                        // ボタンタップ時の処理
                        if (_formKey.currentState!.validate()) {
                          Navigator.of(context).pop(todo);
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.close),
                      label: const Text('キャンセル'),
                      onPressed: () {
                        // ボタンタップ時の処理
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
