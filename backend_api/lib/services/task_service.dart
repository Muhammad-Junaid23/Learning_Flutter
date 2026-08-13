import 'dart:convert';
import 'package:backend_api/models/task_model.dart';
import 'package:http/http.dart' as http;

class TaskService {
  String baseURL = "https://todo-nu-plum-19.vercel.app";

  /// Create Task
  Future<TaskModel> createTask({
    required String token,
    required String description,
  }) async {
    try {
      http.Response response = await http.post(
        Uri.parse("$baseURL/todos/add"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": token,
        },
        body: jsonEncode({"description": description}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return taskModelFromJson(response.body);
      } else {
        throw Exception("Failed to create task");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  /// Get All Tasks
  Future<TaskListingModel> getAllTasks({
    required String token,
  }) async {
    try {
      http.Response response = await http.get(
        Uri.parse("$baseURL/todos/get"),
        headers: {"Authorization": token},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return taskListingModelFromJson(response.body);
      } else {
        throw Exception("Failed to fetch tasks");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  /// Get Task By Id
  Future<TaskModel> getTaskById({
    required String token,
    required String taskId,
  }) async {
    try {
      http.Response response = await http.get(
        Uri.parse("$baseURL/todos/gettodobyid/$taskId"),
        headers: {"Authorization": token},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return taskModelFromJson(response.body);
      } else {
        throw Exception("Failed to fetch task details");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  /// Update Task
  Future<bool> updateTask({
    required String token,
    required String taskId,
    required String description,
  }) async {
    try {
      http.Response response = await http.patch(
        Uri.parse("$baseURL/todos/update/$taskId"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": token,
        },
        body: jsonEncode({
          "description": description,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        throw Exception("Failed to update task");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  /// Delete Task
  Future<bool> deleteTask({
    required String token,
    required String taskId,
  }) async {
    try {
      http.Response response = await http.delete(
        Uri.parse("$baseURL/todos/delete/$taskId"),
        headers: {"Authorization": token},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        throw Exception("Failed to delete task");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  /// Get Completed Tasks
  Future<TaskListingModel> getCompletedTasks({
    required String token,
  }) async {
    try {
      http.Response response = await http.get(
        Uri.parse("$baseURL/todos/completed"),
        headers: {"Authorization": token},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return taskListingModelFromJson(response.body);
      } else {
        throw Exception("Failed to fetch completed tasks");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  /// Get Incompleted Tasks
  Future<TaskListingModel> getIncompletedTasks({
    required String token,
  }) async {
    try {
      http.Response response = await http.get(
        Uri.parse("$baseURL/todos/incomplete"),
        headers: {"Authorization": token},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return taskListingModelFromJson(response.body);
      } else {
        throw Exception("Failed to fetch incomplete tasks");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  /// Filter Task
  Future<TaskListingModel> filterTask({
    required String token,
    required String startDate,
    required String endDate,
  }) async {
    try {
      http.Response response = await http.get(
        Uri.parse("$baseURL/todos/filter?startDate=$startDate&endDate=$endDate"),
        headers: {"Authorization": token},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return taskListingModelFromJson(response.body);
      } else {
        throw Exception("Failed to filter tasks");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  /// Search Task
  Future<TaskListingModel> searchTask({
    required String token,
    required String keyword,
  }) async {
    try {
      http.Response response = await http.get(
        Uri.parse("$baseURL/todos/search?keywords=$keyword"),
        headers: {"Authorization": token},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return taskListingModelFromJson(response.body);
      } else {
        throw Exception("Failed to search tasks");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }


  ///Mark Task as Completed
  Future<bool> markTaskAsCompleted({
    required String token,
    required String taskId,
  }) async {
    try {
      final response = await http.patch(
        Uri.parse('$baseURL/todos/complete/$taskId'),
        headers: {
          'Authorization': token,
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "complete": true,
        }),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        throw response.body; // show backend error
      }
    } catch (e) {
      throw e.toString();
    }
  }


///Mark Task as Completed
Future<bool> markTaskAsIncompleted({
required String token,
required String taskId,
}) async {
  try {
    final response = await http.patch(
      Uri.parse('$baseURL/todos/complete/$taskId'),
      headers: {
        'Authorization': token,
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "complete": false,
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw response.body; // show backend error
    }
  } catch (e) {
    throw e.toString();
  }
}

}