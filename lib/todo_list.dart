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

    addDay(mapOfTask);

    if (mapOfTask['id']?.isNotEmpty &&
        mapOfTask['name']?.isNotEmpty &&
        mapOfTask['category']?.isNotEmpty) {
      taskList.add(mapOfTask);
    } else {
      print('Cannot create a task. Please, fill all fields');
    }
  }

  void addFewTasks() {
    var isContinue = '1';
    while (isContinue == '1') {
      addTask();
      print('Add another task: \n 1. Yes \t 2. No');
      isContinue = stdin.readLineSync()!;
    }
  }

  void addDay(mapOfTask) {
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
  }

  static void deleteTask({required taskList}) {
    if (taskList?.isNotEmpty) {
      print('\n Type ID to delete');
      final deletedId = stdin.readLineSync();
      taskList.removeWhere((task) => task['id'] == deletedId);
    } else {
      print('Nothing to delete');
    }
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
      print('\n Category: $key | Number of tasks: $numberOfTasks | \n Tasks:');
      for (var task in tasksInCategory) {
        var day = task['day'] ?? '';
        print('ID: ${task['id']} | Task: ${task['name']} | Day: $day');
      }
    });
    if (taskList.isEmpty) {
      print('Your task list is empty');
    }
  }

  void mainMenu() {
    var appRunning = true;
    while (appRunning == true) {
      print(
          '\n Choose menu: \n 1. Add new task \t 2. Add few tasks \n 3. Delete task \t 4. Show task list \n 5. Exit');
      var choose = stdin.readLineSync();
      switch (choose) {
        case '1':
          addTask();
          break;
        case '2':
          addFewTasks();
          break;
        case '3':
          deleteTask(taskList: taskList);
          break;
        case '4':
          showTask();
          break;
        case '5':
          appRunning = false;
          break;

        default:
          break;
      }
    }
  }
}
