import 'package:flutter/material.dart';

//import 'add_new_todo_screen.dart'; // library import
import 'package:todo_crud/add_new_todo_screen.dart'; //package import
import 'package:todo_crud/edit_todo_screen.dart';
import 'package:todo_crud/todo.dart'; // package

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  List<Todo> todoList =[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todos'),
      ),
      body: Visibility(
        visible: todoList.isNotEmpty,
        replacement: const Center(child: Text('Todo list is empty'),),
        child: ListView.separated(
          itemCount: todoList.length,
          itemBuilder: (context, index) {
            return buildTodoListTile(index); /// method extracting. ctrl +alt+m
          },
          separatorBuilder: (context, index) {
            return Divider(
              color: Colors.grey[200],
              height: 12,
              indent: 16,
              endIndent: 16,
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onTapAddNewTodoFAB,
        backgroundColor: Colors.amber,
        child: const Icon(Icons.add),
      ),
    );
  }

  ListTile buildTodoListTile(int index) {
    return ListTile(
            // --------------------> this can be written in a separate place
            title: Text(todoList[index].title),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(todoList[index].description),
                Text(todoList[index].dateTime.toString()),
              ],
            ),
            trailing: Wrap(
              children: [
                IconButton(
                    onPressed: ()=> _onTapEditTodo(index), // not, onPressed: _onTapEditTodo(index),
                    icon: const Icon(Icons.edit)),
                IconButton(
                    onPressed: ()=> _showDeleteConfirmationDialog(index),
                    icon: const Icon(Icons.delete)),
              ],
            ),
          );
  }

  Future<void> _onTapAddNewTodoFAB() async{
    final Todo? result = await Navigator.push(context, MaterialPageRoute(builder: (context) => const AddNewTodoScreen(),),);
    if(result != null){
      todoList.add(result);
      setState(() {});
    }
  }

  Future<void> _onTapEditTodo(int index) async{
    final Todo? updatedTodo = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EditTodoScreen(
              todo: todoList[index],
            )));
    if(updatedTodo != null){
      todoList[index] = updatedTodo;
      setState(() {});
    }
  }

  void _showDeleteConfirmationDialog(int index) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Delete Todo?'),
            content: const Text('are you sure to delete this todo?'),
            actions: [
              TextButton(
                  onPressed: () {
                    _removeTodo(index);
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'yes, delete!',
                    style: TextStyle(color: Colors.red),
                  )),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('cancel')),
            ],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          );
        });
  }

  void _removeTodo(int index) {
    todoList.removeAt(index);
    setState(() {});
  }
}
