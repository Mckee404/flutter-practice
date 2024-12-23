//aaaaaa

import 'package:flutter/material.dart';
import 'package:flutter_practice/class_todo.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ToDoAddPage extends StatefulWidget {
  Todo? modifyingItem;
  ToDoAddPage({super.key, this.modifyingItem});
  @override
  _ToDoAddPageState createState() => _ToDoAddPageState();
}

class _ToDoAddPageState extends State<ToDoAddPage> {
  final _formKey = GlobalKey<FormState>();

  var todo = Todo();

  void changeColor(Color changedColor) => setState(() => todo.color = changedColor);

  @override
  void initState(){
    todo=widget.modifyingItem??todo;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.modifyingItem==null?"リスト追加":"リスト編集"),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.all(64),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(
                  hintText: "タイトルを入力してください",
                ),
                initialValue: todo.title,
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
              TextFormField(
                initialValue: todo.description,
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
              const Text(
                "ラベルの色を選択",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: todo.color,
                    ),
                  ),
                  const SizedBox(width: 16,),
                  SlidePicker(
                    pickerColor: todo.color,
                    onColorChanged: changeColor,
                    enableAlpha: false,
                    showIndicator: false,
                    displayThumbColor: false,
                  ),
                ],
              ),
              const SizedBox(
                height: 56,
              ),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.done),
                      label: const Text('保存する'),
                      onPressed: () {
                        // ボタンタップ時の処理
                        if (_formKey.currentState!.validate()) {
                          Navigator.of(context).pop(todo);
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 8,
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
