import 'package:flutter/material.dart';
import 'package:todo_crud/todo.dart';

class AddNewTodoScreen extends StatefulWidget {
  const AddNewTodoScreen({super.key});

  @override
  State<AddNewTodoScreen> createState() => _AddNewTodoScreenState();
}

class _AddNewTodoScreenState extends State<AddNewTodoScreen> {
  final GlobalKey<FormState> _formKey  = GlobalKey<FormState>();
  final TextEditingController _titleTEController = TextEditingController();
  final TextEditingController _descriptionTEController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('add new todo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _titleTEController,
                  decoration: const InputDecoration(
                    hintText: 'title',
                  ),
                  validator: (String? value){
                    final v=value??'';
                    if(v.trim().isEmpty){
                      return 'enter title';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _descriptionTEController,
                  maxLines: 5,
                  maxLength: 50,
                  decoration: const InputDecoration(
                    hintText: 'description',
                  ),
                  validator: (String? value){
                    if(value?.trim().isEmpty??true){
                      return 'enter description';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                width: MediaQuery.sizeOf(context).width-32, // double.infinity
                child: ElevatedButton(
                  //style: // in theme data
                    onPressed: (){
                      if(_formKey.currentState!.validate()){
                        Todo todo = Todo(
                            _titleTEController.text.trim(),
                            _descriptionTEController.text.trim(),
                            DateTime.now()
                        );
                        Navigator.pop(context,todo);
                      }
                    },
                    child: const Text('add to list'),
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }
  @override
  void dispose() {
    _titleTEController.dispose();
    _descriptionTEController.dispose();
    super.dispose();
  }
}
