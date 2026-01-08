import 'package:flutter/material.dart';
import 'package:rishi_portfolio/widgets/project_page_widget.dart';

class SummaryTab extends StatelessWidget {
  final Project project;

  const SummaryTab({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text("Summary",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              )),
          
          const SizedBox(height: 20),
          // Image
          Container(
            height: 180,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Center(
              child: Image.asset(
                project.imageUrl,
                fit: BoxFit.contain,
              ),
            ),
          ),

          const SizedBox(height: 20),

          Text(
            project.description,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 17,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}
