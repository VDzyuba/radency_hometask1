import 'dart:io';
import 'package:radency_hometask1/plain_to_do.dart';

enum DayOfTheWeek {
  Monday,
  Tuesday,
  Wednesday,
  Thursday,
  Friday,
  Saturday,
  Sunday
}

class ToDoList {
  final taskList = <Map>[];

  void addTask() {
    print('\n Type ID, Name, Category by Enter');
    final instanceOfTask = PlainToDo(
        id: stdin.readLineSync(),
        name: stdin.readLineSync(),
        category: stdin.readLineSync());

    final mapOfTask = <String, dynamic>{
      'id': instanceOfTask.id,
      'name': instanceOfTask.name,
      'category': instanceOfTask.category,
    };

    print('\n Is task is recurring? \n 1. Yes \n 2. No');
    final isTaskRecurring = stdin.readLineSync();
    if (isTaskRecurring == '1') {
      print(
          '\n Type a day: \n 1. Monday \t 2. Tuesday \n 3. Wednesday \t 4. Thusday \n 5. Friday \t 6. Saturday \n 7. Sunday');
      final dayOfTheWeek = int.parse(stdin.readLineSync()!) - 1;
      for (var day in DayOfTheWeek.values) {
        if (dayOfTheWeek == day.index) {
          mapOfTask['day'] = day.toString().split('.').last;
        }
      }
    }
    taskList.add(mapOfTask);
  }

  static void deleteTask({required taskList}) {
    print('\n Type ID to delete');
    final deletedId = stdin.readLineSync();
    taskList.removeWhere((task) => task['id'] == deletedId);
  }

  Map<S, List<Map>> groupByCategory<S>(S Function(Map) key) {
    var groupedMap = <S, List<Map>>{};
    for (var task in taskList) {
      (groupedMap[key(task)] ??= []).add(task);
    }
    return groupedMap;
  }

  void showTask() {
    var groupedMap = groupByCategory((item) => item['category']);
    groupedMap.keys.forEach((key) {
      var tasksInCategory = groupedMap[key];
      var numberOfTasks = tasksInCategory!.length;
      print('Category: $key | Number: $numberOfTasks | \n Tasks:');
      for (var task in tasksInCategory) {
        var day = task['day'] ?? '';
        print('ID: ${task['id']} | Task: ${task['name']} | Day: $day');
      }
    });
  }

  void addFewElements() {}

  void mainMenu() {
    var appRunning = true;
    while (appRunning == true) {
      print(
          '\n Choose menu: \n 1. Add new task \t 2. Delete task \n 3. Show task list \t 4. Exit');
      var choose = stdin.readLineSync();
      switch (choose) {
        case '1':
          addTask();
          break;
        case '2':
          deleteTask(taskList: taskList);
          break;
        case '3':
          showTask();
          break;
        case '4':
          appRunning = false;
          break;

        default:
          break;
      }
    }
  }
}
