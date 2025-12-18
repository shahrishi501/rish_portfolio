import 'package:flutter/material.dart';
import 'package:rishi_portfolio/widgets/project_page_widget.dart';

class ProblemTab extends StatelessWidget {
  final Project project;

  const ProblemTab({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
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

          // Optional persona / research image
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              project.imageUrl,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(height: 24),

          Text(
            project.problem,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}
