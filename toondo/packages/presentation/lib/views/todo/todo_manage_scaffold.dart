import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:presentation/viewmodels/todo/todo_manage_viewmodel.dart';
import 'package:presentation/widgets/app_bar/custom_app_bar.dart';
import 'package:presentation/widgets/top_menu_bar/menu_bar.dart';
import 'package:presentation/widgets/calendar/calendar.dart';
import 'package:presentation/widgets/todo/goal_selection_bar.dart';
import 'package:presentation/widgets/todo/todo_section.dart';
import 'package:presentation/widgets/todo/bottom_spacer.dart';

class TodoManageScaffold extends StatelessWidget {
  const TodoManageScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<TodoManageViewModel>();
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: CustomAppBar(title: '투두리스트'),
      body: Column(
        children: [
          Calendar(
            selectedDate: viewModel.selectedDate,
            onDateSelected: (date) => viewModel.updateSelectedDate(date),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: MenuBarWidget(
              selectedMenu: _filterOptionToMenuOption(viewModel.selectedFilter),
              onItemSelected: (option) {
                final filter = _menuOptionToFilterOption(option);
                viewModel.updateSelectedFilter(filter);
              },
            ),
          ),
          if (viewModel.selectedFilter == FilterOption.goal)
            const GoalSelectionBar(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TodoSection(
                    title: '디데이 투두',
                    todos: viewModel.dDayTodos,
                    isDDay: true,
                  ),
                  TodoSection(
                    title: '데일리 투두',
                    todos: viewModel.dailyTodos,
                    isDDay: false,
                  ),
                ],
              ),
            ),
          ),
          const BottomSpacer(),
        ],
      ),
    );
  }


  MenuOption _filterOptionToMenuOption(FilterOption filter) {
    switch (filter) {
      case FilterOption.all:
        return MenuOption.all;
      case FilterOption.goal:
        return MenuOption.goal;
      case FilterOption.importance:
        return MenuOption.importance;
      default:
        return MenuOption.all;
    }
  }

  FilterOption _menuOptionToFilterOption(MenuOption option) {
    switch (option) {
      case MenuOption.all:
        return FilterOption.all;
      case MenuOption.goal:
        return FilterOption.goal;
      case MenuOption.importance:
        return FilterOption.importance;
      default:
        return FilterOption.all;
    }
  }
}

