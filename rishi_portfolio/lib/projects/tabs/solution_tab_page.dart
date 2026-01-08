import 'package:flutter/material.dart';
import 'package:rishi_portfolio/widgets/project_page_widget.dart';

class SolutionTab extends StatefulWidget {
  final Project project;

  const SolutionTab({super.key, required this.project});

  @override
  State<SolutionTab> createState() => _SolutionTabState();
}

class _SolutionTabState extends State<SolutionTab> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final project = widget.project;

    final lines = project.solution
        .split('\n')
        .map((line) => line.trim())
        .where((line) => line.isNotEmpty)
        .toList();

    final intro = lines.isNotEmpty ? lines.first : '';
    final outro = lines.length > 2 ? lines.last : '';
    final bulletPoints = lines.length > 2 
        ? lines.sublist(1, lines.length - 1) 
        : (lines.length == 2 ? [lines[1]] : <String>[]);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Title
          const Text(
            "Solution",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 12),

          /// Intro
          if (intro.isNotEmpty)
            Text(
              intro,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                height: 1.6,
              ),
            ),

          const SizedBox(height: 16),

          /// Bullet points
          ...bulletPoints.map((point) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "•  ",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  child: Text(
                    point,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      height: 1.6,
                    ),
                  ),
                ),
              ],
            ),
          )),

          /// Outro
          if (outro.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                outro,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  height: 1.6,
                ),
              ),
            ),

          const SizedBox(height: 32),

          /// Key Screens
          const Text(
            "Key Screens",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 16),

          _buildCarousel(project),

          const SizedBox(height: 16),

          _buildIndicators(project.solutionScreens.length),
        ],
      ),
    );
  }

  /// ---------- Carousel ----------
  Widget _buildCarousel(Project project) {
    return SizedBox(
      height: 600,
      child: Row(
        children: [
          _navButton(
            icon: Icons.chevron_left,
            onTap: () {
              if (_currentIndex > 0) {
                _pageController.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                );
              }
            },
          ),

          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: project.solutionScreens.length,
              onPageChanged: (index) {
                setState(() => _currentIndex = index);
              },
              itemBuilder: (_, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Container(
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade800,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Image.network(
                      project.solutionScreens[index],
                      fit: BoxFit.contain,
                    ),
                  ),
                );
              },
            ),
          ),

          _navButton(
            icon: Icons.chevron_right,
            onTap: () {
              if (_currentIndex < project.solutionScreens.length - 1) {
                _pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _navButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(icon, color: Colors.white, size: 28),
    );
  }

  /// ---------- Indicators ----------
  Widget _buildIndicators(int count) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        count,
        (index) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: _currentIndex == index ? 10 : 6,
          height: 6,
          decoration: BoxDecoration(
            color: _currentIndex == index ? Colors.white : Colors.white30,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}