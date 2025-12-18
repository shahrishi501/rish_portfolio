import 'package:flutter/material.dart';
import 'package:rishi_portfolio/projects/tabs/problem_tab_page.dart';
import 'package:rishi_portfolio/projects/tabs/solution_tab_page.dart';
import 'package:rishi_portfolio/projects/tabs/summary_tab_page.dart';
import 'package:rishi_portfolio/projects/tabs/tech_stack_tab_page.dart';
import 'package:rishi_portfolio/widgets/project_page_widget.dart';

class ProjectDetailPage extends StatelessWidget {
  final Project project;

  const ProjectDetailPage({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          leading: BackButton(color: Colors.white),
          title: Text(
            project.name,
            style: const TextStyle(color: Colors.white),
          ),
          bottom: const TabBar(
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey,
            dividerColor: Colors.transparent,
            labelStyle: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
            tabs: [
              Tab(text: "Summary"),
              Tab(text: "Problem"),
              Tab(text: "Tech stack"),
              Tab(text: "Solution"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            SummaryTab(project: project),
            ProblemTab(project: project),
            TechStackTab(project: project),
            SolutionTab(project: project),
          ],
        ),
      ),
    );
  }
}
