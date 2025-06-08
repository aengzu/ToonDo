import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:presentation/viewmodels/todo/todo_manage_viewmodel.dart';

class GoalSelectionBar extends StatelessWidget {
  const GoalSelectionBar({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<TodoManageViewModel>();

    return Container(
      height: 40,
      margin: const EdgeInsets.symmetric(horizontal: 28, vertical: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: viewModel.goals.length,
        itemBuilder: (context, index) {
          final goal = viewModel.goals[index];
          final isSelected = viewModel.selectedGoalId == goal.id;
          return GestureDetector(
            onTap: () => viewModel.updateSelectedFilter(
              FilterOption.goal,
              goalId: goal.id,
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF78B545) : Colors.transparent,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFFE4F0D9)),
              ),
              child: Center(
                child: Text(
                  goal.name,
                  style: TextStyle(
                    color: isSelected
                        ? Colors.white
                        : Colors.black.withOpacity(0.5),
                    fontWeight:
                        isSelected ? FontWeight.w700 : FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
