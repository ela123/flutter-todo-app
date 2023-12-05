import 'package:flutter/material.dart';
import 'package:todo/model/todo.dart';
import '../constants/colors.dart';
import '../widgets/todo_item.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todolist = Todo.todolist();
  final todocontrol = TextEditingController();
  List<Todo> foundtodo = [];
  @override
  void initState() {
    foundtodo = todolist;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15,
            ),
            child: Column(children: [
              SearchBox(),
              Expanded(
                child: ListView(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        top: 50,
                        bottom: 20,
                      ),
                      child: Text(
                        'all to do',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    for (Todo todoo in foundtodo.reversed)
                      TodoItem(
                        todo: todoo,
                        ontochage: handeltodo,
                        ondelete: deleteitem,
                      ),
                  ],
                ),
              )
            ]),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(children: [
              Expanded(
                  child: Container(
                margin: EdgeInsets.only(
                  bottom: 20,
                  right: 20,
                  left: 20,
                ),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 0.0),
                        blurRadius: 10.0,
                        spreadRadius: 0.0)
                  ],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: todocontrol,
                  decoration: InputDecoration(
                    hintText: 'add new',
                    border: InputBorder.none,
                  ),
                ),
              )),
              Container(
                margin: EdgeInsets.only(bottom: 20, left: 20, right: 10),
                child: ElevatedButton(
                  child: Text(
                    '+',
                    style: TextStyle(
                      fontSize: 40,
                    ),
                  ),
                  onPressed: () {
                    Addtodo(todocontrol.text);
                  },
                  style: ElevatedButton.styleFrom(
                      primary: tdBlue,
                      minimumSize: Size(60, 60),
                      elevation: 10),
                ),
              )
            ]),
          )
        ],
      ),
    );
  }

  void handeltodo(Todo todo) {
    setState(() {
      todo.isdone = !todo.isdone;
    });
  }

  void deleteitem(String id) {
    setState(() {
      todolist.removeWhere((item) => item.Id == id);
    });
  }

  void Addtodo(String todo) {
    setState(() {
      todolist.add(Todo(
          Id: DateTime.now().millisecondsSinceEpoch.toString(),
          todotext: todo));
    });
    todocontrol.clear();
  }

  void Runfilter(String keyword) {
    List<Todo> result = [];
    if (keyword.isEmpty) {
      result = todolist;
    } else {
      result = todolist
          .where((item) =>
              item.todotext!.toLowerCase().contains(keyword.toLowerCase()))
          .toList();
    }
    setState(() {
      foundtodo = result;
    });
  }

  Widget SearchBox() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 15,
      ),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: TextField(
        onChanged: (value) => Runfilter(value),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            color: tdBlack,
            size: 20,
          ),
          prefixIconConstraints: BoxConstraints(
            maxHeight: 20,
            minWidth: 25,
          ),
          border: InputBorder.none,
          hintText: "search",
          hintStyle: TextStyle(
            color: tdGrey,
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: tdBGColor,
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Icon(
          Icons.menu,
          color: tdBlack,
          size: 30,
        ),
        Container(
          height: 30,
          width: 30,
          child: 
        )
      ]),
    );
  }
}
