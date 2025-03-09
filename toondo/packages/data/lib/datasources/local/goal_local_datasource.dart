// 로컬 저장소(Hive)에서 Goal 데이터를 관리하는 Repository
import 'package:data/models/goal_status.dart';
import 'package:hive/hive.dart';
import '../../models/goal_model.dart';
import 'package:domain/entities/goal.dart';

class GoalLocalDatasource {
  Box<GoalModel> goalBox = Hive.box<GoalModel>('goals');

  Future<void> clearGoals() async {
    await goalBox.clear();
  }

  Future<void> saveGoal(Goal goal) async {
    final model = GoalModel.fromEntity(goal);
    if (model.id != null) {
      await goalBox.put(model.id, model);
    }
  }

  List<Goal> getAllGoals() {
    return goalBox.values.map((model) => model.toEntity()).toList();
  }

  Future<void> updateGoal(Goal goal) async {
    await saveGoal(goal);
  }

  // New: Delete a goal locally using its ID.
  Future<void> deleteGoal(String goalId) async {
    await goalBox.delete(goalId);
  }

  updateGoalStatus(Goal goal, GoalStatus newStatus) {}

  updateGoalProgress(Goal goal, double newProgress) {}
}
