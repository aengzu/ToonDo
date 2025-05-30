import 'package:common/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:presentation/widgets/home/chat_toggle_button.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool chatEnabled;
  const HomeAppBar({super.key, required this.chatEnabled});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0,
      centerTitle: true,
      title: const Text(
        'ToonDo',
        style: TextStyle(
          color: Color(0xff1C1D1B),
          fontWeight: FontWeight.w600,
          fontFamily: 'Pretendard Variable',
          letterSpacing: 1.2,
          fontSize: 14,
        ),
      ),
      leadingWidth: 56,
      leading: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: ChatToggleButton(enabled: chatEnabled),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: IconButton(
            onPressed: () {
              // TODO 추후 상점 화면 이동
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (_) => ()),
              // );
            },
            icon: Assets.icons.icStore.svg(width: 40, height: 40),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
