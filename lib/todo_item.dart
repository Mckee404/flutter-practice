import 'package:flutter/material.dart';
import 'class_todo.dart';

class ToDoItem extends StatelessWidget {
  final Todo item;
  final VoidCallback onDelete;

  ToDoItem({required this.item, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    if (item.description == "") {
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
              border: Border(left: BorderSide(color: item.color, width: 20)),
            ),
            padding: EdgeInsets.all(10.0),
            alignment: Alignment.centerLeft,
            child: ListTile(
              title: Text(item.title),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: onDelete,
              ),
            ),
          ),
        ),
      );
    } else {
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
              border: Border(left: BorderSide(color: item.color, width: 20)),
            ),
            padding: EdgeInsets.all(10.0),
            alignment: Alignment.centerLeft,
            child: ListTile(
              title: Text(item.title),
              subtitle: Text(item.description,
                  maxLines: 3, overflow: TextOverflow.ellipsis),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: onDelete,
              ),
            ),
          ),
        ),
      );
    }
  }
}
