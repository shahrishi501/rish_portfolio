import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

// About Me Page with Expandable Sections
class AboutMePage extends StatefulWidget {
  const AboutMePage({super.key});

  @override
  State<AboutMePage> createState() => _AboutMePageState();
}

class _AboutMePageState extends State<AboutMePage> {
  Set<int> expandedSections = {};

  void toggleSection(int index) {
    setState(() {
      if (expandedSections.contains(index)) {
        expandedSections.remove(index);
      } else {
        expandedSections.add(index);
      }
    });
  }

  final List<TechStackItem> techStackItems = [
    TechStackItem(name: 'Flutter', iconPath: 'assets/skill-icons/flutter.svg'),
    TechStackItem(name: 'Firebase', iconPath: 'assets/skill-icons/firebase.svg',),
    TechStackItem(name: 'C', iconPath: 'assets/skill-icons/c.svg'),
    TechStackItem(name: 'C++', iconPath: 'assets/skill-icons/cpp.svg'),
    TechStackItem(name: 'Go', iconPath: 'assets/skill-icons/go.svg'),
    TechStackItem(name: 'MongoDB', iconPath: 'assets/skill-icons/mongodb.svg'),
    TechStackItem(name: 'PostgreSQL', iconPath: 'assets/skill-icons/postgresql.svg',),
  ];

  final List<SectionData> sections = [
    SectionData(
      title: 'Introduction',
      content: 'Hi, I’m Rishi Shah!\n\nA software engineer passionate about building clean, functional, and user-friendly mobile apps. \n\nWhen I’m not coding, I’m usually discovering new music or curating playlists that keep me inspired.\n\nYou’ll also find me exploring cafés, observing their atmosphere, and enjoying the stories each space carries.',
      type: SectionType.text
    ),
    SectionData(
      title: 'What I Do',
      content: 'I specialize in mobile app development using Flutter, creating cross-platform solutions that are fast, scalable, and user-friendly.\n\nI enjoy building applications that solve real-world problems with clean code and thoughtful design.',
      type: SectionType.text
    ),
    SectionData(
      title: 'Tech Stack',
      content: 'Flutter • Dart • Firebase • REST APIs • Git\nUI/UX Design • Mobile Development\nCloud Computing • AI & ML',
      type: SectionType.techStack,
    ),
    SectionData(
      title: 'Location',
      content: '📍 Mumbai, India 🇮🇳\n\nOpen to remote opportunities and collaborations worldwide.',
      type: SectionType.text,
    ),
    SectionData(
      title: 'Education',
      content: '🎓 B.Tech in Computer Engineering – DJ Sanghvi College of Engineering, Mumbai, Maharashtra \n\nExpected Graduation: May 2026',
      type: SectionType.text,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF000000), Color(0xFF1a1a1a)],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            children: [
              // Custom AppBar
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 24,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                    SizedBox(width: 4),
                    Text(
                      'About Me',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),

              // Profile Image
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  height: 250,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: AssetImage("assets/img/IMG_5179.jpg"),
                      fit: BoxFit.cover,
                      alignment: Alignment(0, -0.3),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 10),

              // Expandable Sections
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  itemCount: sections.length,
                  itemBuilder: (context, index) {
                    return _buildExpandableSection(
                      sections[index],
                      index,
                      expandedSections.contains(index),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExpandableSection(
    SectionData section,
    int index,
    bool isExpanded,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: 1),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.white, width: 1)),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () => toggleSection(index),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    section.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.3),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isExpanded
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),
          ),
          AnimatedCrossFade(
            firstChild: Container(),
            secondChild: Padding(
              padding: EdgeInsets.only(left: 8, right: 8, bottom: 20),
              child: section.type == SectionType.techStack
                  ? _buildTechStackGrid()
                  :
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  section.content,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    height: 1.6,
                  ),
                ),
              ),
            ),
            crossFadeState:
                isExpanded
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
            duration: Duration(milliseconds: 300),
          ),
        ],
      ),
    );
  }

  Widget _buildTechStackGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1,
      ),
      itemCount: techStackItems.length,
      itemBuilder: (context, index) {
        return _buildTechStackItem(techStackItems[index]);
      },
    );
  }

  Widget _buildTechStackItem(TechStackItem item) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 50,
          height: 50,
          padding: EdgeInsets.all(8),
          child: SvgPicture.asset(
            item.iconPath,
            fit: BoxFit.contain,
          ),
        ),
        SizedBox(height: 6),
        Text(
          item.name,
          style: TextStyle(
            color: Colors.white.withOpacity(0.8),
            fontSize: 12,
          ),
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}


enum SectionType { text, techStack }

class SectionData {
  final String title;
  final String content;
  final SectionType type;

  SectionData({
    required this.title,
    required this.content,
    this.type = SectionType.text,
  });
}

class TechStackItem {
  final String name;
  final String iconPath;

  TechStackItem({required this.name, required this.iconPath});
}
