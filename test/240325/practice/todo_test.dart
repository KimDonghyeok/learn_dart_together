import 'dart:convert';

import 'package:dart_cli_practice/data_source/todo_api.dart';
import 'package:http/http.dart' as http;
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() async {
  JsonEncoder encoder = JsonEncoder.withIndent('  ');
  TodoApi api = TodoApi();
  final todoJsonString = await http
      .get(Uri.parse('https://jsonplaceholder.typicode.com/todos/1'))
      .then((response) => response.body);
  final todosJsonString = await http
      .get(Uri.parse('https://jsonplaceholder.typicode.com/todos'))
      .then((response) => response.body);

  group('Todo api는', () {
    test('/todo/\$id  path로 특정 id의 todo를 fetch 한다.', () async {
      try {
        final todo = await api.getTodo(1);
        String actualJson = encoder.convert(todo);

        expect(actualJson, equals(todoJsonString));
      } catch (e) {
        print(e);
      }
    });

    test('/todo path로 todo list를 fetch 한다.', () async {
      try {
        final todoList = await api.getTodos();
        String actualJson = encoder.convert(todoList);

        expect(actualJson, equals(todosJsonString));
      } catch (e) {
        print(e);
      }
    });
  });
}
