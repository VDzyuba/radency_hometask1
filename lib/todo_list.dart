import 'dart:io';

enum DayOfTheWeek {
  Monday,
  Tuesday,
  Wednesday,
  Thursday,
  Friday,
  Saturday,
  Sunday
}

abstract class Task {
  var name;
  var id;
  var category;
}

class PlainToDo implements Task {
  @override
  var name;
  @override
  var id;
  @override
  var category;

  PlainToDo({
    required this.id,
    required this.name,
    required this.category,
  });
}

class ToDoList {
  var listMain = <Map>[];

  void addTask() {
    print('Type id, name, categoty by Enter');
    var ins = PlainToDo(
        id: stdin.readLineSync(),
        name: stdin.readLineSync(),
        category: stdin.readLineSync());

    final map = <String, dynamic>{
      'id': ins.id,
      'name': ins.name,
      'category': ins.category,
    };

    print('Is Task is Reccuring? \n 1. Yes \n 2. No');
    var isReccuring = stdin.readLineSync();
    if (isReccuring == '1') {
      print(
          'Type day: \n 1. Monday \t 2. Tuesday \n 3. Wednesday \t 4. Thusday \n 5. Friday \t 6. Saturday \n 7. Sunday');
      final day = int.parse(stdin.readLineSync()!) - 1;
      for (var i in DayOfTheWeek.values) {
        if (day == i.index) {
          map['day'] = i.toString().split('.').last;
        }
      }
    }
    listMain.add(map);
  }

  Map<String, List<Map>> groupBy(String Function(Map) key) {
    var groupMap = <String, List<Map>>{};
    for (var element in listMain) {
      (groupMap[key(element)] ??= []).add(element);
    }
    return groupMap;
  }

  void showTask() {
    ;
    var newMap = groupBy((item) => item['category']).map((k, v) => MapEntry(
        k,
        v.map((item) {
          item.remove('category');
          return item;
        }).toList()));
    print(newMap);
  }

  void addFewElements() {}

  void deleteTask() {
    listMain.removeWhere((item) => item['id'] == stdin.readLineSync());
  }

  void menu() {
    var runningApp = true;
    while (runningApp == true) {
      print(
          'Choose menu: \n 1. Add task \t 2. Delete task \n 3. Show tasks \t 4. Exit');
      var choose = stdin.readLineSync();
      switch (choose) {
        case '1':
          addTask();
          break;
        case '2':
          deleteTask();
          break;
        case '3':
          // sortByCategory('category' , 'id','name', 'day', list);
          showTask();
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
