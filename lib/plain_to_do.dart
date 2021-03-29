import 'package:radency_hometask1/task.dart';

class PlainToDo implements Task {
  @override
  var id;
  @override
  var name;
  @override
  var category;

  PlainToDo({
    required this.id,
    required this.name,
    required this.category,
  });
}