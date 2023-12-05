class Todo {
  String? Id;
  String? todotext;
  bool isdone;
  Todo({required this.Id, required this.todotext, this.isdone = false});
  static List<Todo> todolist() {
    return [
      Todo(Id: '01', todotext: 'eating', isdone: true),
      Todo(Id: '02', todotext: 'play', isdone: true),
      Todo(Id: '03', todotext: 'email'),
      Todo(Id: '04', todotext: 'code'),
      Todo(Id: '05', todotext: 'jpy')
    ];
  }
}
