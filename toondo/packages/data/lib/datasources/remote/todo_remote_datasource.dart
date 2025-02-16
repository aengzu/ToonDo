import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:data/constants.dart';
import 'package:domain/entities/todo.dart';
import 'package:get_it/get_it.dart';
import 'package:data/repositories/auth_repository_impl.dart';

class TodoRemoteDataSource {
  http.Client client = http.Client();
  // Use GetIt to get the auth repository instance.
  final authRepository = GetIt.instance<AuthRepositoryImpl>();

  Future<bool> commitTodos(
    List<Todo> unsyncedTodos,
    List<Todo> deletedTodos,
  ) async {
    final token = await authRepository.getToken();
    if (token == null) {
      throw Exception('JWT 토큰이 없습니다. 다시 로그인해주세요.');
    }

    // 2) toDoRequests 생성, id와 goalId를 서버 스펙에 맞게 Long (int) 타입으로 변환
    final toDoRequests =
        unsyncedTodos.map((t) {
          return {
            "todoId": int.parse(t.id),
            "goalId": t.goalId != null ? int.parse(t.goalId!) : null,
            "title": t.title,
            "status": t.status,
            "startDate": t.startDate.toIso8601String().split('T')[0],
            "endDate": t.endDate.toIso8601String().split('T')[0],
            "urgency": t.urgency,
            "importance": t.importance,
            "comment": t.comment.isEmpty ? null : t.comment,
          };
        }).toList();

    final deletedTodoIds = deletedTodos.map((t) => t.id).toList();

    final requestBody = {
      "toDoRequests": toDoRequests,
      "deletedTodoIds": deletedTodoIds,
    };
    print(requestBody);

    final url = Uri.parse('${Constants.baseUrl}/todos/all/commit');
    try {
      final response = await client.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );
      final decoded = jsonDecode(response.body);
      print('Response Status Code : ${response.statusCode}');
      if (response.statusCode == 200) {
        // 예) {"message":"투두 동기화 성공","savedTodosCount":2,"deletedCount":3}
        print('동기화 성공: ${decoded['message']}');
        return true;
      } else if (response.statusCode == 400) {
        final errMsg = decoded['message'] ?? 'Bad Request';
        throw Exception('서버 응답 400: $errMsg');
      } else {
        throw Exception('Failed to commit todos: ${response.statusCode}');
      }
    } catch (e) {
      print('Error commit todos: $e');
      rethrow;
    }
  }

  // 서버로부터 투두 전체 목록을 fetch (전체 갱신)
  Future<List<Todo>> fetchTodos() async {
    final token = await authRepository.getToken();
    if (token == null) throw Exception('JWT 토큰이 없습니다.');
    final url = Uri.parse('${Constants.baseUrl}/todos/all/fetch');
    final response = await client.get(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      final List<dynamic> todosJson = decoded['todos'];
      return todosJson.map((json) {
        final String todoId = json['todoId'].toString();
        final dynamic goalId = json['goalId'];
        return Todo(
          id: todoId,
          goalId: goalId != null ? goalId.toString() : null,
          title: json['title'],
          status: (json['status'] as num).toDouble(),
          startDate: DateTime.parse(json['startDate']),
          endDate: DateTime.parse(json['endDate']),
          urgency: json['urgency'] as int,
          importance: json['importance'] as int,
          comment: json['comment'] ?? '',
        );
      }).toList();
    }
    throw Exception('Failed to fetch todos: ${response.statusCode}');
  }
}
