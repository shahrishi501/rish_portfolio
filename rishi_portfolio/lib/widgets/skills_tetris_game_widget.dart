import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:math';

/// Skills Tetris Game
class SkillsTetrisGame extends StatefulWidget {
  const SkillsTetrisGame({super.key});

  @override
  State<SkillsTetrisGame> createState() => _SkillsTetrisGameState();
}

class _SkillsTetrisGameState extends State<SkillsTetrisGame> {
  final List<TechBlock> _fallingBlocks = [];
  final List<TechBlock> _landedBlocks = [];
  Timer? _gameTimer;
  Timer? _spawnTimer;
  int _score = 0;
  bool _isGameOver = false;
  final Random _random = Random();

  final List<Map<String, dynamic>> _techStacks = [
    {'name': 'Flutter', 'color': Colors.blue, 'icon': '🦋'},
    {'name': 'Firebase', 'color': Colors.orange, 'icon': '🔥'},
    {'name': 'Dart', 'color': Colors.teal, 'icon': '🎯'},
    {'name': 'React', 'color': Colors.cyan, 'icon': '⚛️'},
    {'name': 'Node.js', 'color': Colors.green, 'icon': '🟢'},
    {'name': 'MongoDB', 'color': Colors.greenAccent, 'icon': '🍃'},
    {'name': 'Python', 'color': Colors.yellow, 'icon': '🐍'},
    {'name': 'AWS', 'color': Colors.amber, 'icon': '☁️'},
    {'name': 'Git', 'color': Colors.redAccent, 'icon': '📦'},
    {'name': 'Docker', 'color': Colors.blueAccent, 'icon': '🐳'},
  ];

  @override
  void initState() {
    super.initState();
    _startGame();
  }

  void _startGame() {
    _score = 0;
    _isGameOver = false;
    _fallingBlocks.clear();
    _landedBlocks.clear();

    _spawnTimer = Timer.periodic(Duration(seconds: 2), (timer) {
      if (!_isGameOver) {
        _spawnBlock();
      }
    });

    _gameTimer = Timer.periodic(Duration(milliseconds: 50), (timer) {
      if (!_isGameOver) {
        _updateGame();
      }
    });
  }

  void _spawnBlock() {
    final tech = _techStacks[_random.nextInt(_techStacks.length)];
    final screenWidth = MediaQuery.of(context).size.width;
    final xPosition = _random.nextDouble() * (screenWidth - 100);

    setState(() {
      _fallingBlocks.add(TechBlock(
        name: tech['name'],
        color: tech['color'],
        icon: tech['icon'],
        x: xPosition,
        y: 0,
      ));
    });
  }

  void _updateGame() {
    setState(() {
      for (var block in _fallingBlocks) {
        block.y += 3;
      }

      final screenHeight = MediaQuery.of(context).size.height;
      _fallingBlocks.removeWhere((block) {
        if (block.y >= screenHeight - 150) {
          _landedBlocks.add(block);
          _score += 10;
          return true;
        }
        return false;
      });

      if (_landedBlocks.length > 15) {
        _isGameOver = true;
        _gameTimer?.cancel();
        _spawnTimer?.cancel();
      }
    });
  }

  void _tapBlock(TechBlock block) {
    setState(() {
      _fallingBlocks.remove(block);
      _score += 20;
    });
  }

  void _restartGame() {
    _gameTimer?.cancel();
    _spawnTimer?.cancel();
    setState(() {
      _startGame();
    });
  }

  @override
  void dispose() {
    _gameTimer?.cancel();
    _spawnTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF1a1a2e),
            Color(0xFF16213e),
            Color(0xFF0f3460),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                      Column(
                        children: [
                          Text(
                            'Skills Game',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Tap falling skills!',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '$_score pts',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ...(_fallingBlocks.map((block) {
                return Positioned(
                  left: block.x,
                  top: block.y,
                  child: GestureDetector(
                    onTap: () => _tapBlock(block),
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: block.color.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.white, width: 2),
                        boxShadow: [
                          BoxShadow(
                            color: block.color.withOpacity(0.5),
                            blurRadius: 10,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            block.icon,
                            style: TextStyle(fontSize: 24),
                          ),
                          SizedBox(height: 4),
                          Text(
                            block.name,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList()),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 120,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.5),
                      ],
                    ),
                  ),
                  child: Center(
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      alignment: WrapAlignment.center,
                      children: _landedBlocks.map((block) {
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: block.color.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Colors.white, width: 1),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(block.icon, style: TextStyle(fontSize: 12)),
                              SizedBox(width: 4),
                              Text(
                                block.name,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
              if (_isGameOver)
                Positioned.fill(
                  child: Container(
                    color: Colors.black.withOpacity(0.8),
                    child: Center(
                      child: Container(
                        margin: EdgeInsets.all(32),
                        padding: EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '🎮',
                              style: TextStyle(fontSize: 60),
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Game Over!',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Final Score: $_score',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.grey[700],
                              ),
                            ),
                            SizedBox(height: 24),
                            ElevatedButton(
                              onPressed: _restartGame,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 32,
                                  vertical: 16,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: Text(
                                'Play Again',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(height: 12),
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text(
                                'Back to Portfolio',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              if (!_isGameOver && _score == 0)
                Positioned(
                  top: 100,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      margin: EdgeInsets.all(16),
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        '👆 Tap falling skills to catch them!\n+20 points for taps, +10 for landing',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class TechBlock {
  String name;
  Color color;
  String icon;
  double x;
  double y;

  TechBlock({
    required this.name,
    required this.color,
    required this.icon,
    required this.x,
    required this.y,
  });
}