import 'package:flutter/material.dart';
import 'class_todo.dart';
import 'todo_add_page.dart';

class TodoItem extends StatefulWidget {
  Todo item;
  final VoidCallback onDelete;
  TodoItem({super.key, required this.item, required this.onDelete});

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  late Todo item;
  late VoidCallback onDelete;
  @override
  void initState() {
    super.initState();

    item = widget.item;
    onDelete = widget.onDelete;
  }

  @override
  Widget build(BuildContext context) {
    final Text? listTileSubTitle;
    if (item.description.isEmpty) {
      listTileSubTitle = null;
    } else {
      listTileSubTitle = Text(item.description);
    }
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ClipPath(
        clipper: ShapeBorderClipper(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        child: Container(
          decoration: BoxDecoration(
            border: Border(
                left: BorderSide(
              color: item.color,
              width: 24,
            )),
          ),
          padding: EdgeInsets.all(8.0),
          alignment: Alignment.centerLeft,
          child: ListTile(
            title: Text(item.title),
            subtitle: listTileSubTitle,
            trailing: Wrap(
              spacing: 8,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () async {
                    final returnValue = await Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) {
                        return ToDoAddPage(modifyingItem: item,);
                      }),
                    );
                    if(returnValue is Todo){
                      setState(() {
                        item=returnValue;
                      });
                    }
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: onDelete,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}