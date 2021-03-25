import 'dart:io';

enum dayOfTheWeek {
  Monday,
  Tuesday,
  Wednesday,
  Thursday,
  Friday,
  Saturday,
  Sundey
}

abstract class Task {
  var name;
  var id;
  var category;

  void addTask();

  void addFewElements();

  void deleteTask();
}

class ToDoList implements Task {
  @override
  var category;

  @override
  var id;

  @override
  var name;

  final list = [];

  @override
  void addTask() {
    final map = {};
    print('id');
    id = stdin.readLineSync();
    map['id'] = id;

    print('name');
    name = stdin.readLineSync();
    map['name'] = name;

    print('category');
    category = stdin.readLineSync();
    map['category'] = category;

    print('This task is recurring: \n 1.Yes \n 2.No');
    var isReccuring = stdin.readLineSync();
    if (isReccuring == '1') {
      print(
          'Choose a day: \n 1. Monday \n 2. Tuesday \n 3. Wednesday \n 4. Thursday \n 5. Friday \n 6. Saturday \n 7. Sunday');
      var day = stdin.readLineSync();
      switch (day) {
        case '1':
          map['day'] = dayOfTheWeek.Monday;
          break;
        case '2':
          map['day'] = dayOfTheWeek.Tuesday;
          break;
        case '3':
          map['day'] = dayOfTheWeek.Wednesday;
          break;
        case '4':
          map['day'] = dayOfTheWeek.Thursday;
          break;
        case '5':
          map['day'] = dayOfTheWeek.Friday;
          break;
        case '6':
          map['day'] = dayOfTheWeek.Saturday;
          break;
        case '7':
          map['day'] = dayOfTheWeek.Sundey;
          break;
      }
    }

    list.add(map);
  }

  static void showTask(list) {
    print(list);
  }

  @override
  void addFewElements() {}

  @override
  void deleteTask() {
    list.removeWhere((item) => item['id'] == stdin.readLineSync());
  }

  void menu() {
    var runningApp = true;

    while (runningApp == true) {
      print(
          'Choose menu \n 1. Add task \n 2. Delete task \n 3. Show tasks \n 4. Exit');
      var choose = stdin.readLineSync();
      switch (choose) {
        case '1':
          addTask();
          break;
        case '2':
          deleteTask();
          break;
        case '3':
          showTask(list);
          break;
        case '4':
          runningApp = false;
          break;

        default:
          break;
      }
    }
  }
}
