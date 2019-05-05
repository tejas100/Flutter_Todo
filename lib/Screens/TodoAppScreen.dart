import 'package:flutter/material.dart';
import 'package:todo/model/todo.dart';
import 'package:shared_preferences/shared_preferences.dart'; //to store localy

//stf

class TodoApp extends StatefulWidget {
  @override
  _TodoAppState createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  final TextEditingController controller = new TextEditingController();
  List<Todo> todoList =[];

int count =0;


void initState(){
  super.initState();
  localStorageTest();
}


localStorageTest() async{
var amIStored=await SharedPreferences.getInstance();
if(amIStored == null) 
  print("Local Storage is Empty");
else {
  print("Something in Storage");
}
}



void addTodoItem(){
  Todo item = Todo(); //creating item of type Todo
  item.task=controller.text; 
  item.isCompleted = false; //for the 1st time is is false
  item.id=count++;

  setState(() {
   todoList.add(item);
   controller.text=""; 
  });
  Navigator.of(context).pop();
}

void ItemDel(index){

  setState(() {
    todoList.removeAt(index);
  });

  

}



  @override
  Widget build(BuildContext context) {
    print(todoList);
    return Scaffold(
      appBar: AppBar(
        title: Text("To-Do"),
      ),

      floatingActionButton: FloatingActionButton(
        
        onPressed: (){

        showDialog(context: context,
        builder: (BuildContext newContext){
          return AlertDialog(
              title: Text("Add New Task"),
              content: Column(

                mainAxisSize: MainAxisSize.min,
                children:<Widget>[
                  TextField(

          controller: controller, //text will tacken by this controller
          decoration: InputDecoration(labelText: "Enter task here"),
        ),
        SizedBox(height: 20,),
  

        RaisedButton(onPressed: (){

          addTodoItem();
        },
        child: Text("Add me"),
        
        )
                ] 
              ), //design our layout
          );
          });
      },
      child: Icon(Icons.add),),
      body: ListView.builder(  //ListView.builder to build list view

        itemCount: todoList.length,
        itemBuilder: (BuildContext context,int index){
          return Card(
            child: ListTile(
            leading: Checkbox(
              value: todoList[index].isCompleted,
              onChanged: (val){
                  int indexOfObject = todoList.indexOf(todoList[index]);
                  Todo item = todoList[index];
                  item.isCompleted =! item.isCompleted;
                  setState(() {
                   todoList[indexOfObject] = item;
                  });


              },),
              title: Text("${todoList[index].task}",style: TextStyle(
                decoration: todoList[index].isCompleted? TextDecoration.lineThrough : TextDecoration.none ),),
              trailing: IconButton(
                onPressed: (){
                  ItemDel(index);
                },
                icon: Icon(Icons.delete,color:Colors.white),
              ),
            )
          );
        },
      )
      
      ,
     
    );
    
  }
}