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
          Text(
            project.solution,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              height: 1.6,
            ),
          ),

          const SizedBox(height: 12),

          /// Bullet points
          // ...project.solutionPoints.map(
          //   (point) => _Bullet(text: point),
          // ),

          const SizedBox(height: 20),

          /// Outro
          Text(
            project.solution,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 15,
              height: 1.6,
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
                    child: Image.asset(
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