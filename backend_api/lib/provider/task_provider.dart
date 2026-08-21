import 'package:flutter/material.dart';
import 'package:backend_api/models/task_model.dart';
import 'package:backend_api/services/task_service.dart';

class TaskProvider extends ChangeNotifier {
  final TaskService _taskService = TaskService();

  List<Task> _tasks = [];
  List<Task> _searchResults = [];
  List<Task> _filteredResults = [];

  bool _isLoading = false;
  String? _errorMessage;

  String? _activeKeyword;
  DateTimeRange? _activeFilterRange;

  // Getters
  List<Task> get tasks => _tasks;
  List<Task> get completedTasks => _tasks.where((t) => t.complete == true).toList();
  List<Task> get incompletedTasks => _tasks.where((t) => t.complete == false).toList();
  List<Task> get searchResults => _searchResults;
  List<Task> get filteredResults => _filteredResults;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Getter that determines what the UI should display
  List<Task> get displayedTasks {
    List<Task> temp = _tasks;

    // Apply Keyword Filter if active
    if (_activeKeyword != null && _activeKeyword!.isNotEmpty) {
      temp = temp.where((t) =>
          (t.description ?? '').toLowerCase().contains(_activeKeyword!.toLowerCase())
      ).toList();
    }

    // Apply Date Range Filter if active
    if (_activeFilterRange != null) {
      temp = temp.where((t) {
        if (t.createdAt == null) return false;
        final created = t.createdAt!;

        return created.isAfter(_activeFilterRange!.start.subtract(const Duration(days: 1))) &&
            created.isBefore(_activeFilterRange!.end.add(const Duration(days: 1)));
      }).toList();
    }

    return temp;
  }

  bool get isFilteredOrSearched =>
      (_activeKeyword != null && _activeKeyword!.isNotEmpty) || _activeFilterRange != null;

  // Search Action
  void searchInMemory(String keyword) {
    _activeKeyword = keyword;
    notifyListeners();
  }

  // Filter Action
  void filterByDateRange(DateTime start, DateTime end) {
    _activeFilterRange = DateTimeRange(start: start, end: end);
    notifyListeners();
  }

  // Reset Action back to normal state
  void resetFilters() {
    _activeKeyword = null;
    _activeFilterRange = null;
    notifyListeners();
  }

  // Set loading helper
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  // ==================== FETCH ALL TASKS ====================
  Future<void> fetchAllTasks(String token) async {
    _setLoading(true);
    _errorMessage = null;

    try {
      final taskListingModel = await _taskService.getAllTasks(token: token);
      _tasks = taskListingModel.tasks ?? [];
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  // ==================== CREATE TASK ====================
  Future<bool> createTask({
    required String token,
    required String description,
  }) async {
    try {
      final newTaskModel = await _taskService.createTask(
        token: token,
        description: description,
      );

      if (newTaskModel.task != null) {
        _tasks.insert(0, newTaskModel.task!);
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  // ==================== TOGGLE TASK COMPLETION ====================
  Future<void> toggleTaskStatus({
    required String token,
    required Task task,
    required bool isCompleted,
  }) async {
    final taskIndex = _tasks.indexWhere((t) => t.id == task.id);
    if (taskIndex == -1) return;

    // Optimistic Update
    final originalTask = _tasks[taskIndex];
    _tasks[taskIndex] = task.copyWith(complete: isCompleted);
    notifyListeners();

    try {
      if (isCompleted) {
        await _taskService.markTaskAsCompleted(
          token: token,
          taskId: task.id.toString(),
        );
      } else {
        await _taskService.markTaskAsIncompleted(
          token: token,
          taskId: task.id.toString(),
        );
      }
    } catch (e) {
      // Revert state on failure
      _tasks[taskIndex] = originalTask;
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // ==================== UPDATE TASK ====================
  Future<bool> updateTask({
    required String token,
    required String taskId,
    required String description,
  }) async {
    try {
      final success = await _taskService.updateTask(
        token: token,
        taskId: taskId,
        description: description,
      );

      if (success) {
        final index = _tasks.indexWhere((t) => t.id == taskId);
        if (index != -1) {
          _tasks[index] = _tasks[index].copyWith(description: description);
          notifyListeners();
        }
        return true;
      }
      return false;
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  // ==================== DELETE TASK ====================
  Future<void> deleteTask({
    required String token,
    required String taskId,
  }) async {
    final taskIndex = _tasks.indexWhere((t) => t.id == taskId);
    if (taskIndex == -1) return;

    // Optimistic Delete
    final removedTask = _tasks.removeAt(taskIndex);
    notifyListeners();

    try {
      await _taskService.deleteTask(
        token: token,
        taskId: taskId,
      );
    } catch (e) {
      // Revert insertion on failure
      _tasks.insert(taskIndex, removedTask);
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // ==================== SEARCH TASKS ====================
  Future<void> searchTasks({
    required String token,
    required String keyword,
  }) async {
    _setLoading(true);
    try {
      final result = await _taskService.searchTask(
        token: token,
        keyword: keyword,
      );
      _searchResults = result.tasks ?? [];
    } catch (e) {
      _errorMessage = e.toString();
      _searchResults = [];
    } finally {
      _setLoading(false);
    }
  }

  // ==================== FILTER TASKS BY DATE ====================
  Future<void> filterTasksByDate({
    required String token,
    required String startDate,
    required String endDate,
  }) async {
    _setLoading(true);
    try {
      final result = await _taskService.filterTask(
        token: token,
        startDate: startDate,
        endDate: endDate,
      );
      _filteredResults = result.tasks ?? [];
    } catch (e) {
      _errorMessage = e.toString();
      _filteredResults = [];
    } finally {
      _setLoading(false);
    }
  }
}