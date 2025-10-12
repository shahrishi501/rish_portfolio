import 'package:flutter/material.dart';
import 'package:timelines_plus/timelines_plus.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ExperiencePageWidget extends StatefulWidget {
  const ExperiencePageWidget({super.key});

  @override
  State<ExperiencePageWidget> createState() => _ExperiencePageWidgetState();
}

class _ExperiencePageWidgetState extends State<ExperiencePageWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final List<Animation<Offset>> _slideAnimations;
  late final List<Animation<double>> _fadeAnimations;
  late List<bool> _isVisible;

  final List<Experience> experiences = [
    Experience(
      company: '021 Trade',
      role: 'Flutter Developer Intern',
      duration: 'July 2025 - September 2025',
      description:
          'Built and optimized cross-platform UI components, integrated REST APIs, and improved app performance by 30%.',
    ),
    Experience(
      company: 'Smallcase',
      role: 'Software Engineering Intern',
      duration: 'Jan 2025 - March 2025',
      description:
          'Worked on backend APIs for financial data and implemented Flutter screens for the investment dashboard.',
    ),
    Experience(
      company: 'DJ Sanghvi Research Lab',
      role: 'Machine Learning Intern',
      duration: 'May 2024 - July 2024',
      description:
          'Developed credit risk prediction models using Python and deployed a research dashboard using Streamlit.',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _slideAnimations = List.generate(
      experiences.length,
      (i) =>
          Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
            CurvedAnimation(
              parent: _controller,
              curve: Interval(i * 0.2, 1.0, curve: Curves.easeOut),
            ),
          ),
    );

    _fadeAnimations = List.generate(
      experiences.length,
      (i) => Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(i * 0.2, 1.0, curve: Curves.easeIn),
        ),
      ),
    );

    _isVisible = List.filled(experiences.length, false);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onVisibilityChanged(int index, bool visible) {
    if (visible && !_isVisible[index]) {
      setState(() {
        _isVisible[index] = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
                Center(
                  child: Text(
                    'Experience',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.topLeft,
              child: FixedTimeline.tileBuilder(
                theme: TimelineThemeData(
                  nodePosition: 0.02, // timeline stick to left
                  color: Colors.grey.shade300,
                  indicatorTheme: const IndicatorThemeData(size: 20.0),
                  connectorTheme: const ConnectorThemeData(thickness: 2.5),
                ),
                builder: TimelineTileBuilder.connected(
                  connectionDirection: ConnectionDirection.before,
                  itemCount: experiences.length,
                  contentsBuilder: (context, index) {
                    final exp = experiences[index];
                    return VisibilityDetector(
                      key: Key('exp-$index'),
                      onVisibilityChanged: (info) {
                        if (info.visibleFraction > 0.3) {
                          _onVisibilityChanged(index, true);
                        }
                      },
                      child: AnimatedBuilder(
                        animation: _controller,
                        builder:
                            (context, child) => AnimatedOpacity(
                              opacity: _fadeAnimations[index].value,
                              duration: const Duration(milliseconds: 300),
                              child: AnimatedSlide(
                                offset: _slideAnimations[index].value,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeOut,
                                child: child,
                              ),
                            ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12, bottom: 16),
                          child: ExperienceCard(exp: exp),
                        ),
                      ),
                    );
                  },
                  indicatorBuilder: (_, index) {
                    final active = _isVisible[index];
                    return DotIndicator(
                      size: 25,
                      color: active ? Colors.blueAccent : Colors.grey.shade300,
                      child: Icon(
                        Icons.work,
                        size: 16,
                        color: active ? Colors.white : Colors.grey.shade600,
                      ),
                    );
                  },
                  connectorBuilder:
                      (_, index, ___) => SolidLineConnector(
                        color:
                            _isVisible[index]
                                ? Colors.blueAccent
                                : Colors.grey.shade300,
                        thickness: 2.5,
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Experience {
  final String company;
  final String role;
  final String duration;
  final String description;

  Experience({
    required this.company,
    required this.role,
    required this.duration,
    required this.description,
  });
}

class ExperienceCard extends StatelessWidget {
  final Experience exp;
  const ExperienceCard({super.key, required this.exp});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 4,
      shadowColor: Colors.blue.withOpacity(0.2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              exp.role,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                height: 1.3,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              exp.company,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.blueAccent,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              exp.duration,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade700,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              exp.description,
              style: const TextStyle(fontSize: 15, height: 1.4),
            ),
          ],
        ),
      ),
    );
  }
}
