import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rishi_portfolio/home_screen.dart';
import 'package:svg_path_parser/svg_path_parser.dart';

class HelloAnimationFixed extends StatefulWidget {
  const HelloAnimationFixed({super.key});
  @override
  State<HelloAnimationFixed> createState() => _HelloAnimationFixedState();
}

class _HelloAnimationFixedState extends State<HelloAnimationFixed>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  final List<String> _svgFiles = [
  'assets/icons/Group.svg',
  'assets/icons/hindi.svg',
  'assets/icons/italian.svg',
  'assets/icons/spanish.svg',
];
  List<Path> _paths = [];
  List<List<Path>> _allPaths = [];
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

      _loadAllPaths().then((_) {
        _animateNextLanguage();
      });

     Future.delayed(const Duration(seconds: 10), () {
      if (!mounted) return;
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ));
    });
  }

  Future<void> _loadAllPaths() async {
  final List<List<Path>> allPaths = [];

  for (final pathFile in _svgFiles) {
    final raw = await rootBundle.loadString(pathFile);
    final regex = RegExp(r'd="([^"]+)"');
    final matches = regex.allMatches(raw);
    final List<Path> parsed = [];

    for (final m in matches) {
      final d = m.group(1);
      if (d != null && d.trim().isNotEmpty) {
        try {
          parsed.add(parseSvgPath(d));
        } catch (e) {
          debugPrint('Could not parse path from $pathFile: $e');
        }
      }
    }

    if (parsed.isNotEmpty) allPaths.add(parsed);
  }

  setState(() {
    _allPaths = allPaths;
  });
}

void _animateNextLanguage() {
  if (_allPaths.isEmpty) return;

  setState(() => _paths = _allPaths[_currentIndex]);

  _controller
    ..reset()
    ..forward().whenComplete(() async {
      await Future.delayed(const Duration(milliseconds: 500)); // small pause
      setState(() {
        _currentIndex = (_currentIndex + 1) % _allPaths.length;
      });
      _animateNextLanguage();
    });
}

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child:
            _paths.isEmpty
                ? const CircularProgressIndicator(color: Colors.white)
                : AnimatedBuilder(
                  animation: _controller,
                  builder: (context, _) {
                    return CustomPaint(
                      size: const Size(500, 300),
                      painter: _HelloPainter(
                        paths: _paths,
                        progress: Curves.easeInOut.transform(_controller.value),
                      ),
                    );
                  },
                ),
      ),
    );
  }
}

class _HelloPainter extends CustomPainter {
  final List<Path> paths;
  final double progress;

  _HelloPainter({required this.paths, required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    if (paths.isEmpty) return;
    Rect? unionBounds;
    for (final p in paths) {
      final b = p.getBounds();
      unionBounds = unionBounds == null ? b : unionBounds.expandToInclude(b);
    }
    final bounds = unionBounds ?? Rect.fromLTWH(0, 0, 1, 1);

    
    final scale = (size.width * 0.9) / bounds.width; // 90% width
    final tx = (size.width - bounds.width * scale) / 2 - bounds.left * scale;
    final ty = (size.height - bounds.height * scale) / 2 - bounds.top * scale;

    final Matrix4 m4 =
        Matrix4.identity()
          ..translate(tx, ty)
          ..scale(scale, scale);
    final Float64List matrix = m4.storage;

    final List<PathMetric> metrics = [];
    for (final p in paths) {
      final transformed = p.transform(matrix);
      final pm = transformed.computeMetrics();
      metrics.addAll(pm);
    }

  
    double totalLength = 0;
    for (final pm in metrics) totalLength += pm.length;
    final drawUntil = totalLength * progress;

    double drawn = 0;
    final Path visible = Path();
    Offset? tipPosition;

    for (final pm in metrics) {
      if (drawn >= drawUntil) break;

      final remaining = drawUntil - drawn;
      final take = remaining.clamp(0.0, pm.length);
      final sub = pm.extractPath(0, take);
      visible.addPath(sub, Offset.zero);

      final tangent = pm.getTangentForOffset(take);
      if (tangent != null) {
        tipPosition = tangent.position;
      }

      drawn += take;
    }

    final paint =
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.8
          ..strokeCap = StrokeCap.round
          ..color = Colors.white;

    canvas.drawPath(visible, paint);

    if (tipPosition != null) {
      final glowPaint =
          Paint()
            ..style = PaintingStyle.fill
            ..color = Colors.white.withOpacity(0.95)
            ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);
      canvas.drawCircle(tipPosition, 4.0, glowPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _HelloPainter old) =>
      old.progress != progress || old.paths != paths;
}
