import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:domain/entities/todo.dart';
import 'package:presentation/viewmodels/todo/todo_manage_viewmodel.dart';
import 'package:presentation/widgets/todo/todo_list_item.dart';
import 'package:presentation/views/todo/todo_input_view.dart';

class TodoSection extends StatelessWidget {
  final String title;
  final List<Todo> todos;
  final bool isDDay;

  const TodoSection({
    super.key,
    required this.title,
    required this.todos,
    required this.isDDay,
  });

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<TodoManageViewModel>();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            key: const Key('addTodoButton'),
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => TodoInputView(isDDayTodo: isDDay),
                ),
              );
              viewModel.loadTodos();
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(1000),
                  side: const BorderSide(width: 0.5, color: Color(0x3F1C1D1B)),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1C1D1B),
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(Icons.add, size: 12, color: Color(0xFF1C1D1B)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          todos.isNotEmpty
              ? ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: todos.length,
                  itemBuilder: (context, index) {
                    final todo = todos[index];
                    return TodoListItem(
                      todo: todo,
                      goals: viewModel.goals,
                      selectedDate: DateTime(
                        viewModel.selectedDate.year,
                        viewModel.selectedDate.month,
                        viewModel.selectedDate.day,
                      ),
                      onUpdate: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                TodoInputView(todo: todo, isDDayTodo: isDDay),
                          ),
                        );
                        viewModel.loadTodos();
                      },
                      onStatusUpdate: (updated, newStatus) =>
                          viewModel.updateTodoStatus(updated, newStatus),
                      onDelete: () => viewModel.deleteTodoById(todo.id),
                      onPostpone: () {
                        final newStart =
                            todo.startDate.add(const Duration(days: 1));
                        final newEnd =
                            todo.endDate.add(const Duration(days: 1));
                        viewModel.updateTodoDates(todo, newStart, newEnd);
                      },
                      hideCompletionStatus: isDDay,
                    );
                  },
                )
              : const Text('투두가 없습니다.',
                  style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}
