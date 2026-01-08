import 'package:flutter/material.dart';
import 'package:rishi_portfolio/widgets/project_page_widget.dart';

class ProblemTab extends StatelessWidget {
  final Project project;

  const ProblemTab({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    
    final lines = project.problem
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
          const Text(
            "Problem Statement",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 20),

          // Intro text (not a bullet point)
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

          // Display middle lines as bullet points
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

          // Outro text (not a bullet point)
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
        ],
      ),
    );
  }
}