import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:presentation/designsystem/components/bottom_sheets/goal_complete_bottom_sheet.dart';
import 'package:presentation/designsystem/components/buttons/app_button.dart';
import 'package:presentation/designsystem/components/buttons/double_action_buttons.dart';
import 'package:presentation/designsystem/spacing/app_spacing.dart';
import 'package:presentation/views/base_scaffold.dart';
import 'package:presentation/views/goal/input/goal_input_body.dart';
import 'package:presentation/views/todo/input/todo_input_screen.dart';
import 'package:provider/provider.dart';
import 'package:domain/entities/goal.dart';
import 'package:domain/usecases/goal/create_goal_remote.dart';
import 'package:domain/usecases/goal/save_goal_local.dart';
import 'package:domain/usecases/goal/update_goal_remote.dart';
import 'package:domain/usecases/goal/update_goal_local.dart';
import 'package:presentation/viewmodels/goal/goal_input_viewmodel.dart';
import 'package:presentation/viewmodels/home/home_viewmodel.dart';
import 'package:presentation/viewmodels/goal/goal_management_viewmodel.dart';

class GoalInputScreen extends StatelessWidget {
  final Goal? goal;
  final bool isFromOnboarding;

  const GoalInputScreen({super.key, this.goal, this.isFromOnboarding = false});

  @override
  Widget build(BuildContext context) {
    final String title =
        isFromOnboarding ? '시작하기' : (goal != null ? '목표 수정하기' : '목표 설정하기');

    return ChangeNotifierProvider<GoalInputViewModel>(
      create:
          (_) => GoalInputViewModel(
            createGoalRemoteUseCase: GetIt.instance<CreateGoalRemoteUseCase>(),
            saveGoalLocalUseCase: GetIt.instance<SaveGoalLocalUseCase>(),
            updateGoalRemoteUseCase: GetIt.instance<UpdateGoalRemoteUseCase>(),
            updateGoalLocalUseCase: GetIt.instance<UpdateGoalLocalUseCase>(),
            targetGoal: goal,
            isFromOnboarding: isFromOnboarding,
          ),
      child: Builder(
        builder: (context) {
          final viewModel = context.read<GoalInputViewModel>();

          return BaseScaffold(
            title: title,
            body: const GoalInputBody(),
            bottomWidget: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSpacing.spacing24,
                  vertical: AppSpacing.spacing8,
                ),
                child:
                    isFromOnboarding
                        ? DoubleActionButtons(
                          backText: '뒤로',
                          nextText: '다음으로',
                          onBack: () => Navigator.pop(context),
                          onNext: () async {
                            final newGoal = await viewModel.saveGoal(context);
                            if (newGoal != null) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (_) => TodoInputScreen(
                                        isDDayTodo: true,
                                        isOnboarding: true,
                                      ),
                                ),
                              );

                              // 이후 상태 동기화
                              GetIt.instance<HomeViewModel>().loadGoals();
                              GetIt.instance<GoalManagementViewModel>()
                                  .loadGoals();
                            }
                          },
                        )
                        : AppButton(
                          label: '작성하기',
                          onPressed: () async {
                            final newGoal = await viewModel.saveGoal(context);
                            if (newGoal != null) {
                              Navigator.pop(context, newGoal);
                              GetIt.instance<HomeViewModel>().loadGoals();
                              GetIt.instance<GoalManagementViewModel>()
                                  .loadGoals();

                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                useRootNavigator: true,
                                backgroundColor: Colors.transparent,
                                builder: (_) => GoalCompleteBottomSheet(
                                  goalTitle: newGoal.name,
                                  iconPath: newGoal.icon!,
                                  startDate: newGoal.startDate,
                                  endDate: newGoal.endDate,
                                  onConfirm: () {
                                    Navigator.pop(context);
                                  }
                                ),
                              );
                            }
                          },
                        ),
              ),
            ),
          );
        },
      ),
    );
  }
}
