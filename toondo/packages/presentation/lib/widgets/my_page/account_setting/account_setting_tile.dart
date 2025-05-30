import 'package:flutter/material.dart';

class AccountSettingTile extends StatelessWidget {
  final String label;
  final String? value;
  final VoidCallback? onTap;

  const AccountSettingTile({super.key, required this.label, this.value, this.onTap});

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).textTheme.bodyMedium?.color;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        height: 52,
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: textColor,
                fontFamily: 'Pretendard Variable',
              ),
            ),
            Row(
              children: [
                if (value != null)
                  Text(
                    value!,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: textColor,
                      fontFamily: 'Pretendard Variable',
                    ),
                  ),
                const SizedBox(width: 16),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Color(0xFFD9D9D9),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
