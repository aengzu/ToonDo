// lib/data/datasources/local/animation_local_datasource.dart
import 'dart:math';
import 'dart:io';
import 'package:domain/entities/gesture.dart';
import 'package:injectable/injectable.dart';
import 'package:rive/rive.dart';

typedef _AnimKey = String;

@LazySingleton()
class AnimationLocalDataSource {
  Artboard? _artboard;
  final _controllers = <_AnimKey, SimpleAnimation>{};
  final _rng = Random();

  /* ─── 제스처 ↔ 후보 애니 ─── */
  final Map<Gesture, List<_AnimKey>> _gestureMap = {
    Gesture.tap:       ['happy', 'shine'],
    Gesture.doubleTap: ['angry', 'melt'],
    Gesture.longPress: ['melt'],
    Gesture.drag:      ['angry', 'happy'],
    Gesture.pinch:     ['melt', 'angry'],
  };

  static const _idle  = 'id';
  static const _blink = 'eye';

  /* ─── Rive 로드 ─── */
  Future<void> load(File riveAsset) async {
    final bytes = await riveAsset.readAsBytes();
    final file  = RiveFile.import(bytes.buffer.asByteData());
    _artboard   = file.mainArtboard;

    // idle 컨트롤러 등록
    final idleCtrl = SimpleAnimation(_idle, autoplay: true);
    _controllers[_idle] = idleCtrl;
    _artboard?.addController(idleCtrl);
  }

  /* ─── 외부 API ─── */
  Future<String> playByGesture(Gesture g) async {
    final list = _gestureMap[g] ?? [_idle];
    final key  = list[_rng.nextInt(list.length)];
    await _play(key, oneShot: true);
    return key;
  }

  Future<String> playBySentiment(String text) async {
    final key = _pickSentiment(text);
    await _play(key, oneShot: true);
    return key;
  }

  /* ─── 내부 공통 플레이 ─── */
  Future<void> _play(String key, {bool oneShot = false}) async {
    if (_artboard == null) return;

    for (final c in _controllers.values) {
      _artboard!.removeController(c);
    }

    final ctrl = _controllers[key] ??= SimpleAnimation(key, autoplay: true, mix: 0.2);
    ctrl.instance?.animation.loop = oneShot ? Loop.oneShot : Loop.loop;

    _artboard!.addController(ctrl);

    if (oneShot) {
      final seconds = ctrl.instance?.animation.duration ?? 1.0;
      Future.delayed(Duration(milliseconds: (seconds * 1000).ceil()), () {
        if (_artboard != null) {
          _artboard!.removeController(ctrl);
          _artboard!.addController(_controllers[_idle]!);
        }
      });
    }
  }


  /* ─── 감정 매핑 ─── */
  _AnimKey _pickSentiment(String text) {
    final lower = text.toLowerCase();
    if (lower.contains('축하') || lower.contains('좋아') || lower.contains('😁')) {
      return 'happy';
    }
    if (lower.contains('피곤') || lower.contains('슬퍼') || lower.contains('😓')) {
      return 'sad';
    }
    return _idle;
  }
}
