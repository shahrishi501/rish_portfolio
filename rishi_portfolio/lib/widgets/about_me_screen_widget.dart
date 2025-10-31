import 'package:flutter/material.dart';
import 'dart:math';

// About Me Page with Shuffling Cards
class AboutMePage extends StatefulWidget {
  const AboutMePage({super.key});

  @override
  State<AboutMePage> createState() => _AboutMePageState();
}

class _AboutMePageState extends State<AboutMePage> with TickerProviderStateMixin {
  int currentCardIndex = 0;
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  
  final List<CardData> cards = [
    CardData(
      title: 'Hi, I\'m Rishi Shah! 👋',
      content: 'Software Engineer passionate about creating beautiful and functional mobile applications.',
      icon: Icons.person,
      gradient: [Color(0xFF6366F1), Color(0xFF9333EA)],
      hasImage: true,
    ),
    CardData(
      title: 'What I Do',
      content: 'I specialize in mobile app development with Flutter and cross-platform solutions. I love building applications that solve real-world problems.',
      icon: Icons.code,
      gradient: [Color(0xFF9333EA), Color(0xFFEC4899)],
    ),
    CardData(
      title: 'My Passion',
      content: 'I enjoy working on innovative projects that challenge me to learn and grow. When I\'m not coding, you can find me exploring new technologies.',
      icon: Icons.lightbulb,
      gradient: [Color(0xFFEC4899), Color(0xFFEF4444)],
    ),
    CardData(
      title: 'Tech Stack',
      content: '',
      icon: Icons.laptop_mac,
      gradient: [Color(0xFF10B981), Color(0xFF14B8A6)],
      interests: ['Mobile Development', 'Flutter', 'UI/UX Design', 'Cloud Computing', 'AI & ML', 'Problem Solving'],
    ),
    CardData(
      title: 'Location',
      content: 'Mumbai, India 🇮🇳',
      icon: Icons.location_on,
      gradient: [Color(0xFFF97316), Color(0xFFFBBF24)],
    ),
    CardData(
      title: 'Education',
      content: 'Computer Science Graduate with a passion for continuous learning and innovation.',
      icon: Icons.school,
      gradient: [Color(0xFF6366F1), Color(0xFF3B82F6)],
    ),
    CardData(
      title: 'Let\'s Connect!',
      content: 'rishi@example.com',
      subcontent: 'Always open to exciting opportunities and collaborations.',
      icon: Icons.email,
      gradient: [Color(0xFF06B6D4), Color(0xFF3B82F6)],
    ),
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
    _slideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _nextCard() {
    if (currentCardIndex < cards.length - 1) {
      setState(() {
        _slideAnimation = Tween<Offset>(
          begin: Offset.zero,
          end: Offset(-1.5, 0),
        ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
      });
      
      _controller.forward().then((_) {
        setState(() {
          currentCardIndex++;
        });
        _controller.reset();
      });
    }
  }

  void _previousCard() {
    if (currentCardIndex > 0) {
      setState(() {
        _slideAnimation = Tween<Offset>(
          begin: Offset.zero,
          end: Offset(1.5, 0),
        ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
      });
      
      _controller.forward().then((_) {
        setState(() {
          currentCardIndex--;
        });
        _controller.reset();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1E293B), Color(0xFF0F172A)],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            children: [
              // Custom AppBar
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Text(
                      'About Me',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              
              // Card Stack
              Expanded(
                child: GestureDetector(
                  onHorizontalDragEnd: (details) {
                    if (details.primaryVelocity! < 0) {
                      _nextCard();
                    } else if (details.primaryVelocity! > 0) {
                      _previousCard();
                    }
                  },
                  child: Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Background cards for depth effect
                        if (currentCardIndex < cards.length - 1)
                          Transform.scale(
                            scale: 0.9,
                            child: Opacity(
                              opacity: 0.5,
                              child: _buildCard(cards[currentCardIndex + 1], false),
                            ),
                          ),
                        
                        // Current card with animation
                        SlideTransition(
                          position: _slideAnimation,
                          child: _buildCard(cards[currentCardIndex], true),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard(CardData cardData, bool isInteractive) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      height: MediaQuery.of(context).size.height * 0.65,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: cardData.gradient,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          children: [
            // Background pattern
            Positioned.fill(
              child: Opacity(
                opacity: 0.1,
                child: CustomPaint(
                  painter: GridPatternPainter(),
                ),
              ),
            ),
            
            // Content
            Padding(
              padding: EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile image for first card
                  if (cardData.hasImage)
                    Center(
                      child: Container(
                        height: 140,
                        width: 140,
                        margin: EdgeInsets.only(bottom: 24, top: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          image: DecorationImage(
                            image: AssetImage("assets/img/IMG_5178.JPG"),
                            fit: BoxFit.cover,
                          ),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.5),
                            width: 3,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 15,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                      ),
                    )
                  else
                    Container(
                      padding: EdgeInsets.all(16),
                      margin: EdgeInsets.only(bottom: 20, top: 20),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(
                        cardData.icon,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  
                  // Title
                  Text(
                    cardData.title,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 16),
                  
                  // Content
                  if (cardData.content.isNotEmpty)
                    Text(
                      cardData.content,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white.withOpacity(0.95),
                        height: 1.6,
                      ),
                    ),
                  
                  // Subcontent
                  if (cardData.subcontent != null) ...[
                    SizedBox(height: 12),
                    Text(
                      cardData.subcontent!,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withOpacity(0.8),
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                  
                  // Interests/Skills
                  if (cardData.interests != null) ...[
                    SizedBox(height: 16),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: cardData.interests!
                          .map((interest) => Container(
                                padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.25),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.4),
                                    width: 1.5,
                                  ),
                                ),
                                child: Text(
                                  interest,
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                  ],
                  
                  Spacer(),
                  
                  // Swipe instruction
                  if (isInteractive)
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.swipe,
                            color: Colors.white.withOpacity(0.6),
                            size: 20,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Swipe to explore',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.6),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
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
}

class CardData {
  final String title;
  final String content;
  final String? subcontent;
  final IconData icon;
  final List<Color> gradient;
  final List<String>? interests;
  final bool hasImage;

  CardData({
    required this.title,
    required this.content,
    this.subcontent,
    required this.icon,
    required this.gradient,
    this.interests,
    this.hasImage = false,
  });
}

class GridPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    const spacing = 30.0;
    
    for (double i = 0; i < size.width; i += spacing) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
    }
    
    for (double i = 0; i < size.height; i += spacing) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}