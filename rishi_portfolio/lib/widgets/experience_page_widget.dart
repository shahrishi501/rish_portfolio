import 'package:flutter/material.dart';
import 'dart:math' as math;

class ExperiencePageWidget extends StatefulWidget {
  const ExperiencePageWidget({super.key});

  @override
  State<ExperiencePageWidget> createState() => _ExperiencePageWidgetState();
}

class _ExperiencePageWidgetState extends State<ExperiencePageWidget> {
  final FixedExtentScrollController _scrollController = FixedExtentScrollController();
  int _currentIndex = 0;
  double _scrollOffset = 0;

  final List<Experience> experiences = [
    Experience(
      company: '021 Trade',
      role: 'Flutter Developer Intern',
      duration: 'July 2025 - September 2025',
      description: [
        'Built and optimized cross-platform UI components.',
        'Integrated REST APIs.',
        'Improved app performance by 30%.',
      ],
      number: '01',
      websiteURL: 'https://www.021.trade/',
      deployedURL: 'https://play.google.com/store/apps/details?id=com.zerotwoonetrade.carbon',
      linkedInURL: 'https://www.linkedin.com/company/021-trade/posts/?feedView=all'
    ),
    Experience(
      company: 'ThinkLocal.AI',
      role: 'Lead App Developer Intern',
      duration: 'Jan 2024 - May 2024',
      description: [
        'Drove mobile app feature development in collaboration with founders.',
        'Integrated Firebase, REST APIs, and Google Places API.',
        'Proposed and developed core features like local discovery decks.',
        'Boosted user engagement by 40%.',
      ],
      number: '02',
      websiteURL: '',
      linkedInURL: 'https://www.linkedin.com/company/thinklocalnow/posts/?feedView=all'
    ),
  ];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() {
        _currentIndex = _scrollController.selectedItem;
        if (_scrollController.position.hasContentDimensions) {
          _scrollOffset = _scrollController.offset;
        }
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Expanded(
                    child: Text(
                      'EXPERIENCE',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                  const SizedBox(width: 48), 
                ],
              ),
            ),
            // Scrollable Experience Timeline
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: ClipRect(
                      child: CustomPaint(
                        painter: SingleCurvedPathPainter(
                          itemCount: experiences.length,
                          currentIndex: _currentIndex,
                          scrollOffset: _scrollOffset,
                        ),
                      ),
                    ),
                  ),
                  // ListWheelScrollView for circular scrolling
                  ListWheelScrollView.useDelegate(
                    controller: _scrollController,
                    itemExtent: screenHeight * 0.6,
                    diameterRatio: 2.0,
                    perspective: 0.002,
                    offAxisFraction: 0.5,
                    physics: const FixedExtentScrollPhysics(),
                    childDelegate: ListWheelChildBuilderDelegate(
                      childCount: experiences.length,
                      builder: (context, index) {
                        return _buildExperienceItem(index);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExperienceItem(int index) {
    final exp = experiences[index];
    final isActive = _currentIndex == index;

    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Number indicator
          SizedBox(
            width: 100,
            child: Text(
              exp.number,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: isActive ? 70 : 50,
                fontWeight: FontWeight.w900,
                color: isActive ? Colors.black : Colors.grey.shade300,
                height: 0.9,
              ),
            ),
          ),
          const SizedBox(width: 40),
          // Experience Card
          Expanded(
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: isActive ? 1.0 : 0.3,
              child: AnimatedScale(
                duration: const Duration(milliseconds: 300),
                scale: isActive ? 1.0 : 0.85,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(isActive ? 0.15 : 0.05),
                        blurRadius: isActive ? 16 : 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        exp.role,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          height: 1.3,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        exp.company,
                        style: const TextStyle(
                          fontSize: 22,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        exp.duration,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade600,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: exp.description.map((point) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 6),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  '• ',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    point,
                                    style: TextStyle(
                                      fontSize: 14,
                                      height: 1.5,
                                      color: Colors.grey.shade800,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SingleCurvedPathPainter extends CustomPainter {
  final int itemCount;
  final int currentIndex;
  final double scrollOffset;

  SingleCurvedPathPainter({
    required this.itemCount,
    required this.currentIndex,
    required this.scrollOffset,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final inactivePaint =
        Paint()
          ..color = Colors.grey.shade300
          ..strokeWidth = 2.5
          ..style = PaintingStyle.stroke;

    final activePaint =
        Paint()
          ..color = Colors.black
          ..strokeWidth = 2.5
          ..style = PaintingStyle.stroke;

    final dotPaint = Paint()..style = PaintingStyle.fill;

    // Push the circle to start from inside the left edge
    final topY = size.height * 0.15;
    final bottomY = size.height * 0.85;
    final totalHeight = bottomY - topY;
    final radius = totalHeight / 2;
    final centerY = topY + radius;

    // Position circle center to the left of screen edge
    final centerX = -radius * 0.6; // Push center further left

    // Create the curved path that starts from left edge
    final path = Path();

    // Start from the top-left position (first item position)
    final startAngle = math.acos(
      -centerX / radius,
    ); // Angle where x = 0 (left edge)
    final endAngle = math.pi - startAngle; // Symmetric bottom position

    // Calculate starting position (top of the arc at left edge)
    final startX = 0.0;
    final startY = centerY - radius * math.sin(startAngle);

    path.moveTo(startX, startY);

    // Create arc from top-left to bottom-left
    final rect = Rect.fromCenter(
      center: Offset(centerX, centerY),
      width: radius * 2,
      height: radius * 2,
    );

    // Arc from start angle to end angle (going clockwise)
    path.arcTo(rect, -startAngle, endAngle - (-startAngle), false);

    // Draw the full path (inactive color)
    canvas.drawPath(path, inactivePaint);

    // Draw active portion of path
    final pathMetrics = path.computeMetrics().first;
    final activeLength = pathMetrics.length * (currentIndex / (itemCount - 1));
    final activePath = pathMetrics.extractPath(0, activeLength);
    canvas.drawPath(activePath, activePaint);

    // Draw dots at each experience position along the arc
    for (int i = 0; i < itemCount; i++) {
      final progress = i / (itemCount - 1);

      // Calculate position along the arc (from start to end angle)
      final angle = -startAngle + (endAngle - (-startAngle)) * progress;
      final x = centerX + radius * math.cos(angle);
      final y = centerY + radius * math.sin(angle);

      final isActive = i <= currentIndex;
      dotPaint.color = isActive ? Colors.black : Colors.grey.shade400;

      canvas.drawCircle(Offset(x, y), isActive ? 6 : 5, dotPaint);
    }
  }

  @override
  bool shouldRepaint(SingleCurvedPathPainter oldDelegate) {
    return oldDelegate.currentIndex != currentIndex ||
        oldDelegate.scrollOffset != scrollOffset;
  }
}

class Experience {
  final String company;
  final String role;
  final String duration;
  final List<String> description;
  final String number;
  final String? websiteURL;
  final String? deployedURL;
  final String? linkedInURL;

  Experience({
    required this.company,
    required this.role,
    required this.duration,
    required this.description,
    required this.number,
    this.websiteURL,
    this.deployedURL,
    this.linkedInURL,
  });
}
