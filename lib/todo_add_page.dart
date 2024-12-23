import 'package:flutter/material.dart';
import 'package:flutter_practice/class_todo.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ToDoAddPage extends StatefulWidget {
  final Todo? modifyingItem;
  const ToDoAddPage({
    super.key,
    this.modifyingItem,//編集したいTodoアイテム
  });
  @override
  State createState() => _ToDoAddPageState();
}

class _ToDoAddPageState extends State<ToDoAddPage> {
  final _formKey = GlobalKey<FormState>();

  late Todo editingTodo;//編集したいTodoアイテムを直接変更しないようにコピーしておくTodoアイテム

  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  late Color colorSample;//編集したいTodoアイテムの色を初期値とし、色見本として変化していくColor
  void changeColor(Color changedColor) =>
      setState(() => colorSample = changedColor);

  @override
  void initState() {
    editingTodo = Todo(
      title: widget.modifyingItem?.title ?? "",
      description: widget.modifyingItem?.description ?? "",
      color: widget.modifyingItem?.color ?? Colors.amber,
    );
    _titleController = TextEditingController(text: editingTodo.title);
    _descriptionController =
        TextEditingController(text: editingTodo.description);
    colorSample = editingTodo.color;
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.modifyingItem == null ? "リスト追加" : "リスト編集"),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.all(64),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField( // TextEditingControllerとinitialValueの併用は不可
                decoration: const InputDecoration(
                  hintText: "タイトルを入力してください",
                ),
                controller: _titleController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '値を入力してください';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                maxLines: null,
                decoration: const InputDecoration(
                  hintText: "説明を入力してください",
                ),
                controller: _descriptionController,
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
                    width: 104,
                    height: 104,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: colorSample,
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  SlidePicker(
                    pickerColor: colorSample,
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
                        if (_formKey.currentState!.validate()) {
                          editingTodo = Todo(
                            title: _titleController.text,
                            description: _descriptionController.text,
                            color: colorSample,
                          );
                          Navigator.of(context).pop(editingTodo);
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
