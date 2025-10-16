import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_svg/svg.dart';

/// Skills Tetris Game with proper Tetromino shapes
class SkillsTetrisGame extends StatefulWidget {
  const SkillsTetrisGame({super.key});

  @override
  State<SkillsTetrisGame> createState() => _SkillsTetrisGameState();
}

class _SkillsTetrisGameState extends State<SkillsTetrisGame> {
  static const int rows = 15;
  static const int cols = 8;

  // Grid to store landed blocks (null means empty)
  List<List<TechBlock?>> _grid = List.generate(
    rows,
    (_) => List.filled(cols, null),
  );

  Tetromino? _currentPiece;
  Timer? _gameTimer;
  int _score = 0;
  bool _isGameOver = false;
  final Random _random = Random();

  final List<Map<String, dynamic>> _techStacks = [
    {
      'name': 'Flutter',
      'color': Colors.white,
      'iconPath': 'assets/skill-icons/flutter.svg',
    },
    {
      'name': 'Firebase',
      'color': Colors.black,
      'iconPath': 'assets/skill-icons/firebase.svg',
    },
    {
      'name': 'Go',
      'color': Colors.grey,
      'iconPath': 'assets/skill-icons/go.svg',
    },
    {
      'name': 'C',
      'color': Colors.green,
      'iconPath': 'assets/skill-icons/c.svg',
    },
    {
      'name': 'MongoDB',
      'color': Colors.purple,
      'iconPath': 'assets/skill-icons/mongodb.svg',
    },
    {
      'name': 'C++',
      'color': Colors.orange,
      'iconPath': 'assets/skill-icons/cpp.svg',
    },
    {
      'name': 'SQL',
      'color': Colors.amber,
      'iconPath': 'assets/skill-icons/postgresql.svg',
    },
  ];

  // Tetromino shapes (standard Tetris pieces)
  final List<List<List<int>>> _shapes = [
    // I-piece
    [
      [1, 1, 1, 1],
    ],
    // O-piece
    [
      [1, 1],
      [1, 1],
    ],
    // T-piece
    [
      [0, 1, 0],
      [1, 1, 1],
    ],
    // S-piece
    [
      [0, 1, 1],
      [1, 1, 0],
    ],
    // Z-piece
    [
      [1, 1, 0],
      [0, 1, 1],
    ],
    // J-piece
    [
      [1, 0, 0],
      [1, 1, 1],
    ],
    // L-piece
    [
      [0, 0, 1],
      [1, 1, 1],
    ],
  ];

  @override
  void initState() {
    super.initState();
    _startGame();
  }

  void _startGame() {
    _score = 0;
    _isGameOver = false;
    _grid = List.generate(rows, (_) => List.filled(cols, null));
    _currentPiece = null;

    // Pre-populate bottom rows with skills showcase
    _populateInitialSkills();

    _spawnNewPiece();

    _gameTimer = Timer.periodic(Duration(milliseconds: 500), (timer) {
      if (!_isGameOver) {
        _moveDown();
      }
    });
  }

  void _populateInitialSkills() {
    // Start from bottom row and work up
    int currentRow = rows - 1;
    int currentCol = 0;

    for (var tech in _techStacks) {
      // Place 3-4 blocks of each skill
      int blocksToPlace = 3 + _random.nextInt(2); // 3 or 4 blocks per skill
      
      for (int i = 0; i < blocksToPlace; i++) {
        if (currentRow < rows - 5) break; // Keep bottom 5 rows for showcase
        
        _grid[currentRow][currentCol] = TechBlock(
          name: tech['name'],
          color: tech['color'],
          iconPath: tech['iconPath'],
        );
        
        currentCol++;
        if (currentCol >= cols) {
          currentCol = 0;
          currentRow--;
          if (currentRow < rows - 5) break;
        }
      }
    }
  }

  void _spawnNewPiece() {
    if (_isGameOver) return;

    final tech = _techStacks[_random.nextInt(_techStacks.length)];
    final shape = _shapes[_random.nextInt(_shapes.length)];

    final startCol = (cols - shape[0].length) ~/ 2;

    final newPiece = Tetromino(
      name: tech['name'],
      color: tech['color'],
      iconPath: tech['iconPath'],
      shape: shape,
      row: 0,
      col: startCol,
    );

    // Check if spawn position is blocked (game over)
    if (_isCollision(newPiece)) {
      setState(() {
        _isGameOver = true;
        _gameTimer?.cancel();
      });
      return;
    }

    setState(() {
      _currentPiece = newPiece;
    });
  }

  bool _isCollision(Tetromino piece, {int rowOffset = 0, int colOffset = 0}) {
    for (int r = 0; r < piece.shape.length; r++) {
      for (int c = 0; c < piece.shape[r].length; c++) {
        if (piece.shape[r][c] == 1) {
          int newRow = piece.row + r + rowOffset;
          int newCol = piece.col + c + colOffset;

          // Check boundaries
          if (newRow >= rows || newCol < 0 || newCol >= cols) {
            return true;
          }

          // Check collision with landed blocks
          if (newRow >= 0 && _grid[newRow][newCol] != null) {
            return true;
          }
        }
      }
    }
    return false;
  }

  void _moveDown() {
    if (_currentPiece == null) return;

    if (!_isCollision(_currentPiece!, rowOffset: 1)) {
      setState(() {
        _currentPiece!.row++;
      });
    } else {
      _lockPiece();
    }
  }

  void _moveLeft() {
    if (_currentPiece == null) return;

    if (!_isCollision(_currentPiece!, colOffset: -1)) {
      setState(() {
        _currentPiece!.col--;
      });
    }
  }

  void _moveRight() {
    if (_currentPiece == null) return;

    if (!_isCollision(_currentPiece!, colOffset: 1)) {
      setState(() {
        _currentPiece!.col++;
      });
    }
  }

  void _rotatePiece() {
    if (_currentPiece == null) return;

    // Create rotated shape (clockwise)
    List<List<int>> rotated = List.generate(
      _currentPiece!.shape[0].length,
      (i) => List.generate(
        _currentPiece!.shape.length,
        (j) => _currentPiece!.shape[_currentPiece!.shape.length - 1 - j][i],
      ),
    );

    // Create temporary piece with rotated shape
    Tetromino tempPiece = Tetromino(
      name: _currentPiece!.name,
      color: _currentPiece!.color,
      iconPath: _currentPiece!.iconPath,
      shape: rotated,
      row: _currentPiece!.row,
      col: _currentPiece!.col,
    );

    // Check if rotation is valid
    if (!_isCollision(tempPiece)) {
      setState(() {
        _currentPiece!.shape = rotated;
      });
    }
  }

  void _lockPiece() {
    if (_currentPiece == null) return;

    // Place piece blocks on grid
    for (int r = 0; r < _currentPiece!.shape.length; r++) {
      for (int c = 0; c < _currentPiece!.shape[r].length; c++) {
        if (_currentPiece!.shape[r][c] == 1) {
          int gridRow = _currentPiece!.row + r;
          int gridCol = _currentPiece!.col + c;

          if (gridRow >= 0 &&
              gridRow < rows &&
              gridCol >= 0 &&
              gridCol < cols) {
            _grid[gridRow][gridCol] = TechBlock(
              name: _currentPiece!.name,
              color: _currentPiece!.color,
              iconPath: _currentPiece!.iconPath,
            );
          }
        }
      }
    }

    _score += 10;
    _clearFullRows();
    _currentPiece = null;
    _spawnNewPiece();
  }

  void _clearFullRows() {
    List<int> rowsToRemove = [];

    for (int r = 0; r < rows; r++) {
      if (_grid[r].every((cell) => cell != null)) {
        rowsToRemove.add(r);
      }
    }

    if (rowsToRemove.isNotEmpty) {
      setState(() {
        // Remove full rows
        for (int r in rowsToRemove.reversed) {
          _grid.removeAt(r);
          _grid.insert(0, List.filled(cols, null));
        }

        // Add score based on rows cleared
        _score += rowsToRemove.length * 100;
      });
    }
  }

  void _dropPiece() {
    if (_currentPiece == null) return;

    while (!_isCollision(_currentPiece!, rowOffset: 1)) {
      _currentPiece!.row++;
    }
    _lockPiece();
  }

  void _restartGame() {
    _gameTimer?.cancel();
    setState(() {
      _startGame();
    });
  }

  @override
  void dispose() {
    _gameTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final availableHeight = screenHeight - 200; // Space for header and controls

    // Calculate block size based on available space
    final blockSizeByWidth = (screenWidth * 0.9) / cols;
    final blockSizeByHeight = (availableHeight * 0.8) / rows;
    final calculatedBlockSize = min(blockSizeByWidth, blockSizeByHeight);
    final blockSize = max(calculatedBlockSize, 50.0).floorToDouble();

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF1a1a2e), Color(0xFF16213e), Color(0xFF0f3460)],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  // Header
                  Container(
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
                              'Skills Tetris',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Stack your skills!',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            '$_score',
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

                  // Game Grid
                  Expanded(
                    child: Center(
                      child: Container(
                        width: blockSize * cols,
                        height: blockSize * rows,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white30, width: 2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: cols,
                              childAspectRatio: 1.0,
                            ),
                            itemCount: rows * cols,
                            itemBuilder: (context, index) {
                              int r = index ~/ cols;
                              int c = index % cols;
                              
                              TechBlock? block = _grid[r][c];

                              // Check if current piece occupies this position
                              if (_currentPiece != null) {
                                int relRow = r - _currentPiece!.row;
                                int relCol = c - _currentPiece!.col;

                                if (relRow >= 0 &&
                                    relRow < _currentPiece!.shape.length &&
                                    relCol >= 0 &&
                                    relCol < _currentPiece!.shape[relRow].length &&
                                    _currentPiece!.shape[relRow][relCol] == 1) {
                                  block = TechBlock(
                                    name: _currentPiece!.name,
                                    color: _currentPiece!.color,
                                    iconPath: _currentPiece!.iconPath,
                                  );
                                }
                              }

                              return Container(
                                decoration: BoxDecoration(
                                  color: block?.color ?? Colors.black.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.1),
                                    width: 0.5,
                                  ),
                                ),
                                child: block != null
                                    ? Stack(
                                        children: [
                                          // Icon
                                          Padding(
                                            padding: EdgeInsets.all(2.0),
                                            child: SvgPicture.asset(
                                              block.iconPath,
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                          // Skill name overlay for better visibility
                                          Positioned(
                                            bottom: 0,
                                            left: 0,
                                            right: 0,
                                            child: Container(
                                              padding: EdgeInsets.symmetric(vertical: 1),
                                              decoration: BoxDecoration(
                                                color: Colors.black.withOpacity(0.7),
                                                borderRadius: BorderRadius.only(
                                                  bottomLeft: Radius.circular(4),
                                                  bottomRight: Radius.circular(4),
                                                ),
                                              ),
                                              child: Text(
                                                block.name,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: blockSize * 0.15,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    : null,
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Controls
                  Container(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildControlButton(Icons.arrow_back, _moveLeft),
                        _buildControlButton(Icons.arrow_downward, _moveDown),
                        _buildControlButton(Icons.arrow_forward, _moveRight),
                        _buildControlButton(Icons.rotate_right, _rotatePiece),
                        _buildControlButton(
                          Icons.vertical_align_bottom,
                          _dropPiece,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // Game Over Overlay
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
                            Text('🎮', style: TextStyle(fontSize: 60)),
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
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                            ),
                          ],
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

  Widget _buildControlButton(IconData icon, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: _isGameOver ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white.withOpacity(0.2),
        padding: EdgeInsets.all(16),
        shape: CircleBorder(),
      ),
      child: Icon(icon, color: Colors.white, size: 24),
    );
  }
}

class Tetromino {
  String name;
  Color color;
  String iconPath;
  List<List<int>> shape;
  int row;
  int col;

  Tetromino({
    required this.name,
    required this.color,
    required this.iconPath,
    required this.shape,
    required this.row,
    required this.col,
  });
}

class TechBlock {
  String name;
  Color color;
  String iconPath;

  TechBlock({required this.name, required this.color, required this.iconPath});
}