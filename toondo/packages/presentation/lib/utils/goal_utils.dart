import 'package:common/gen/assets.gen.dart';
import 'package:domain/entities/goal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:domain/entities/status.dart';
import 'package:presentation/designsystem/colors/app_colors.dart';
import 'package:presentation/designsystem/dimensions/app_dimensions.dart';

/// 날짜를 문자열로 반환
String buildGoalSubtitle(DateTime startDate, DateTime? endDate) {
  final start = DateFormat('yyyy.MM.dd').format(startDate);
  // TODO: '마감일 없이 할래요' 기능 - endDate가 null인 경우 표시 방식 변경
  if (endDate == null) {
    return '$start ~ 무제한'; // 또는 '$start ~ (마감일 없음)' 등
  }
  final end = DateFormat('yyyy.MM.dd').format(endDate);
  return '$start ~ $end';
}

/// 목표가 완료 상태인지 여부
bool isGoalChecked(Status status) {
  return status == Status.completed;
}

/// 목표 종료일 기준 D-Day 계산
int calculateDDay(DateTime? endDate) {
  // TODO: '마감일 없이 할래요' 기능 - endDate가 null인 경우 D-Day 계산 방식 변경
  if (endDate == null) {
    return -1; // 마감일이 없는 목표는 특별한 값 반환 (예: -1은 '무제한'을 의미)
  }
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final diff = endDate.difference(today).inDays;
  return diff >= 0 ? diff : 0;
}

/// 아이콘 이름이 비어 있거나 경로가 이상할 경우 경로 보정
String resolveGoalIconPath(String? iconName) {
  if (iconName == null || iconName.isEmpty) {
    return Assets.icons.icHelpCircle.path;
  }

  final fileName = iconName.split('/').last;
  final normalized = fileName.startsWith('ic_') ? fileName : 'ic_$fileName';
  return 'assets/icons/$normalized';
}

Map<String, List<Goal>> groupGoalsByCompletion(List<Goal> goals) {
  final now = DateTime.now();

  final succeeded = goals
      .where((g) => g.status == Status.completed)
      .toList();
  final failed = goals
      // TODO: '마감일 없이 할래요' 기능 - endDate가 null인 목표는 실패 판정에서 제외
      .where((g) => g.status == Status.active && g.endDate != null && g.endDate!.isBefore(now))
      .toList();
  final givenUp = goals
      .where((g) => g.status == Status.givenUp)
      .toList();

  return {
    '성공': succeeded,
    '실패': failed,
    '포기': givenUp,
  };
}

/// GOAL에서 사용하는 아이콘 스타일
Widget buildGoalIconWithCircle(
    dynamic icon, {
      double? size,
      double? borderWidth,
      double? innerPadding,
      Color? borderColor,
      bool isChecked = false,
    }) {
  final resolvedSize = size ?? AppDimensions.goalIconSize;
  final resolvedBorderWidth = borderWidth ?? AppDimensions.goalItemBorderWidth;
  final resolvedInnerPadding = innerPadding ?? AppDimensions.goalIconInnerPadding;
  final resolvedBorderColor = borderColor ?? AppColors.green500;

  return Container(
    width: resolvedSize,
    height: resolvedSize,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: Colors.transparent,
      border: Border.all(
        color: resolvedBorderColor,
        width: resolvedBorderWidth,
      ),
    ),
    padding: EdgeInsets.all(resolvedInnerPadding),
    child: _buildGoalIcon(
      icon,
      size: resolvedSize - 2 * resolvedInnerPadding,
    ),
  );
}


/// TODO에서 사용하는 아이콘 스타일
Widget buildTodoIconWithCircle(
    dynamic icon, {
      required Color backgroundColor,
      double? size,
      double? borderWidth,
      double? innerPadding,
    }) {
  final resolvedSize = size ?? AppDimensions.goalIconSize;
  final resolvedBorderWidth = borderWidth ?? AppDimensions.goalItemBorderWidth;
  final resolvedInnerPadding = innerPadding ?? AppDimensions.goalIconInnerPadding;

  return Container(
    width: resolvedSize,
    height: resolvedSize,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: backgroundColor,
      border: Border.all(
        color: backgroundColor,
        width: resolvedBorderWidth,
      ),
    ),
    padding: EdgeInsets.all(resolvedInnerPadding),
    child: _buildGoalIcon(
      icon,
      size: resolvedSize - 2 * resolvedInnerPadding,
    ),
  );
}



/// 실제 아이콘을 반환하는 내부 함수
Widget _buildGoalIcon(
    dynamic icon, {
      required double size,
      BoxFit fit = BoxFit.contain,
    }) {
  if (icon is SvgGenImage) {
    return icon.svg(width: size, height: size, fit: fit);
  }
  if (icon is AssetGenImage) {
    return icon.image(width: size, height: size, fit: fit);
  }
  if (icon is String && icon.endsWith('.svg')) {
    return SvgPicture.asset(icon, width: size, height: size, fit: fit);
  }
  if (icon is String) {
    return Image.asset(icon, width: size, height: size, fit: fit);
  }
  return Icon(Icons.help_outline_rounded, size: size);
}

