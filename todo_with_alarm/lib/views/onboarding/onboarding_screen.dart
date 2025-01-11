// lib/views/onboarding/onboarding_screen.dart

import 'dart:async'; // Timer를 사용하기 위해 추가
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart'; // Provider 추가
import 'onboarding2_screen.dart'; // Onboarding2Page 임포트
import '../../viewmodels/onboarding/onboarding_viewmodel.dart'; // ViewModel 임포트

class OnboardingScreen extends StatefulWidget {
  final int userId;

  OnboardingScreen({required this.userId});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  Timer? _timer; // Timer 변수 선언

  @override
  void initState() {
    super.initState();
    // 3초 후에 Onboarding2Page로 이동하면서 userId 전달
    _timer = Timer(Duration(seconds: 3), () {
      if (!mounted) return; // 위젯이 여전히 mounted 상태인지 확인
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider<OnboardingViewModel>(
            create: (_) => OnboardingViewModel(userId: widget.userId),
            child: Onboarding2Page(userId: widget.userId),
          ),
        ),
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Timer 취소
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Color(0xFFFCFCFC),
        child: Stack(
          children: [
            // 하얀 타원 배경
            Positioned(
              left: -79.64,
              top: MediaQuery.of(context).size.height * 0.66,
              child: Container(
                width: 534.28,
                height: 483.32,
                decoration: ShapeDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(0.38, -0.93),
                    end: Alignment(-0.38, 0.93),
                    colors: [
                      Color.fromRGBO(252, 241, 190, 1),
                      Color.fromRGBO(249, 228, 123, 1),
                    ],
                  ),
                  shape: OvalBorder(),
                ),
              ),
            ),
            // 텍스트
            Positioned(
              left: MediaQuery.of(context).size.width * 0.5 - 100,
              top: MediaQuery.of(context).size.height * 0.32,
              child: Text(
                '반가워요!\n제 이름은 슬라임이에요 😄',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF78B545),
                  fontSize: 20,
                  fontFamily: 'Pretendard Variable',
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.30,
                ),
              ),
            ),
            // 캐릭터 및 그림자
            Positioned(
              left: MediaQuery.of(context).size.width * 0.5 - 93.14,
              top: MediaQuery.of(context).size.height * 0.53,
              child: Column(
                children: [
                  SvgPicture.asset(
                    'assets/icons/character.svg',
                    width: 186.29,
                    height: 134.30,
                  ),
                  SizedBox(height: 12.44),
                  SvgPicture.asset(
                    'assets/icons/shadow.svg',
                    width: 139.30,
                    height: 21.99,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}