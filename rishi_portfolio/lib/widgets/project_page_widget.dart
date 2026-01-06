import 'package:flutter/material.dart';
import 'package:rishi_portfolio/projects/project_detail_page.dart';

class Project {
  final String name;
  final String description;
  final String imageUrl;
  final Color accentColor;
  final String role;
  final String year;
  final String problem;
  final String solution;
  final List<String> technologies;
  final List<String> solutionScreens;

  Project({
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.accentColor,
    required this.role,
    required this.year,
    required this.problem,
    required this.solution,
    required this.technologies,
    required this.solutionScreens,
  });
}

class ProjectPageWidget extends StatelessWidget {
  const ProjectPageWidget({super.key});

  List<Project> get projects => [
    Project(
      name: 'SVKM EduConnect',
      description: 'Educational Platform connecting students with resources and learning materials.',
      imageUrl: 'assets/icons/svkm_educonnect.png',
      accentColor: Color(0xFF6366F1),
      role: 'Project Lead, Mobile Developer, UI/UX Designer',
      year: '2025',
      technologies: ['Flutter', 'Firebase', 'Node.js', 'AWS', 'MongoDB'],
      problem: '',
      solution: '',
      solutionScreens: [
        'https://res.cloudinary.com/drjwbpliq/image/upload/f_auto,q_auto,w_800/Screen_0_-_iPhone_16_Plus_zrg7zo.png',
        'https://res.cloudinary.com/drjwbpliq/image/upload/f_auto,q_auto,w_800/Screen_1_-_iPhone_16_Plus_d3v1a6.png',
        'https://res.cloudinary.com/drjwbpliq/image/upload/f_auto,q_auto,w_800/Screen_2_-_iPhone_16_Plus_pmiy7s.png',
        'https://res.cloudinary.com/drjwbpliq/image/upload/f_auto,q_auto,w_800/Screen_4_-_iPhone_16_Plus_s3jepb.png',
        'https://res.cloudinary.com/drjwbpliq/image/upload/f_auto,q_auto,w_800/Screen_3_-_iPhone_16_Plus_cutxon.png'
      ],
    ),
    Project(
      name: 'UC Noteng',
      description: 'Smart Note- Taking app with AI Powered organisation and search.',
      imageUrl: 'assets/icons/playstore-icon.png',
      accentColor: Color(0xFF3B82F6),
      role: 'Mobile Developer, UI/UX Designer',
      year: '2024',
      technologies: [
        'Flutter',
        'MySQL',
        'Firebase',
        'VertexAI',
        'Django',
        'Cloudinary',
      ],
      problem: '',
      solution: '',
      solutionScreens: [
        'https://res.cloudinary.com/drjwbpliq/image/upload/f_auto,q_auto,w_800/Simulator_Screenshot_-_iPhone_17_-_2026-01-06_at_21.29.32_uiivpe.png',
        'https://res.cloudinary.com/drjwbpliq/image/upload/f_auto,q_auto,w_800/Simulator_Screenshot_-_iPhone_17_-_2026-01-06_at_21.29.36_hvpf5l.png',
        'https://res.cloudinary.com/drjwbpliq/image/upload/f_auto,q_auto,w_800/Simulator_Screenshot_-_iPhone_17_-_2026-01-06_at_23.06.08_qqz3zl.png',
        'https://res.cloudinary.com/drjwbpliq/image/upload/f_auto,q_auto,w_800/Simulator_Screenshot_-_iPhone_17_-_2026-01-06_at_23.06.15_i7p8ld.png',
        'https://res.cloudinary.com/drjwbpliq/image/upload/f_auto,q_auto,w_800/Simulator_Screenshot_-_iPhone_17_-_2026-01-06_at_23.06.44_dz820q.png',
        'https://res.cloudinary.com/drjwbpliq/image/upload/f_auto,q_auto,w_800/Simulator_Screenshot_-_iPhone_17_-_2026-01-06_at_23.06.24_ycyxjk.png',
        'https://res.cloudinary.com/drjwbpliq/image/upload/f_auto,q_auto,w_800/Simulator_Screenshot_-_iPhone_17_-_2026-01-06_at_23.06.57_tnioms.png'
      ],
    ),
    Project(
      name: "Unistay",
      description: 'Unistay is a platform to help students and professionals find accommodation.',
      imageUrl: 'assets/icons/image 3.png',
      accentColor: Color(0xFFEC4899),
      role: 'Lead Developer',
      year: '2024',
      technologies: ['Flutter', 'Golang', 'PostgreSQL', 'Figma'],
      problem: '',
      solution: '',
      solutionScreens: [
        'https://res.cloudinary.com/drjwbpliq/image/upload/f_auto,q_auto,w_800/sign_up_pakzxp.png',
        'https://res.cloudinary.com/drjwbpliq/image/upload/f_auto,q_auto,w_800/home_g6iany.png',
        'https://res.cloudinary.com/drjwbpliq/image/upload/f_auto,q_auto,w_800/Maps_mgywkq.png',
        'https://res.cloudinary.com/drjwbpliq/image/upload/f_auto,q_auto,w_800/favourites_s64nri.png'
      ],
    ),
    Project(
      name: "Moo App", 
      description: "Moo App is a survey platform that connects brands with consumers for valuable insights.", 
      imageUrl: 'assets/icons/moo_app.png', 
      accentColor: Color(0xFF4CAF50), 
      role: 'Lead App Developer', 
      year: '2025', 
      problem: '', 
      solution: '', 
      technologies: ['Flutter', 'Django', 'AWS'], 
      solutionScreens: [
        'https://res.cloudinary.com/drjwbpliq/image/upload/f_auto,q_auto,w_800/Splash_Screen_ibdq4n.png',
        'https://res.cloudinary.com/drjwbpliq/image/upload/f_auto,q_auto,w_800/Surveys_-_Complete_surveys._Earn_rewards._It_s_that_easy._c9z4nb.png',
        'https://res.cloudinary.com/drjwbpliq/image/upload/f_auto,q_auto,w_800/Surveys_-_Complete_surveys._Earn_rewards._It_s_that_easy._1_mnvj61.png',
        'https://res.cloudinary.com/drjwbpliq/image/upload/f_auto,q_auto,w_800/Spin_xmiplr.png',
        'https://res.cloudinary.com/drjwbpliq/image/upload/f_auto,q_auto,w_800/Cashout_my7zqb.png',
        'https://res.cloudinary.com/drjwbpliq/image/upload/f_auto,q_auto,w_800/Surveys_-_Complete_surveys._Earn_rewards._It_s_that_easy._2_kax6cg.png'
      ]
    ),
    Project(
      name: "YouBook",
      description: 'Social reading platform for book lovers to connect and share.',
      imageUrl: 'assets/icons/Youbook logo_Red-02.png',
      accentColor: Color(0xFFEF4444),
      role: 'Frontend Developer',
      year: '2025',
      technologies: ['Flutter', 'GraphQL', 'WebSocket'],
      problem: '',
      solution: '',
      solutionScreens: [
        'https://res.cloudinary.com/drjwbpliq/image/upload/f_auto,q_auto,w_800/Sub_page_brqlbm.png',
        'https://res.cloudinary.com/drjwbpliq/image/upload/f_auto,q_auto,w_800/author_page_dzsmpk.png',
        'https://res.cloudinary.com/drjwbpliq/image/upload/f_auto,q_auto,w_800/Library_81_sdv9fj.png'
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with back button and title
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  SizedBox(width: 16),
                  Text(
                    'Projects',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            // Projects List
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 12),
                itemCount: projects.length,
                separatorBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Divider(
                      color: Colors.white,
                      thickness: 1,
                      height: 1,
                    ),
                  );
                },
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      // Navigate to project detail page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProjectDetailPage(project: projects[index]),
                        ),
                      );
                    },
                    child: ProjectCard(project: projects[index])
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProjectCard extends StatelessWidget {
  final Project project;

  const ProjectCard({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Project Image
          SizedBox(
            width: 120,
            height: 120,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(project.imageUrl, fit: BoxFit.contain),
            ),
          ),
          SizedBox(width: 10),

          // Project Info and Arrow
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  project.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  project.role,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Text(
                        project.description,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          height: 1.4,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(width: 8),
                    // Arrow Button at bottom right
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Color(0xFF4F4F4F),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.arrow_outward_sharp,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
