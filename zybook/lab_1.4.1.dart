import 'dart:io';
import 'dart:math';

/// A class representing the Minesweeper game.
class Minesweeper {
  List<List<String>> board;
  List<List<bool>> revealed;
  int rows;
  int cols;
  int numMines;
  bool gameOverFlag = false;

  /// Creates a Minesweeper game with the specified number of rows, columns, and mines.
  Minesweeper(this.rows, this.cols, this.numMines)
      : board = List.generate(rows, (_) => List.filled(cols, ' ')),
        revealed = List.generate(rows, (_) => List.filled(cols, false)) {
    placeMines();
    calculateNumbers();
  }

  /// Places the specified number of mines randomly on the board.
  void placeMines() {
    Random random = Random();
    int count = 0;
    while (count < numMines) {
      int row = random.nextInt(rows);
      int col = random.nextInt(cols);
      if (board[row][col] != 'X') {
        board[row][col] = 'X';
        count++;
      }
    }
  }

  /// Calculates the number of adjacent mines for each cell and updates the board.
  void calculateNumbers() {
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
        if (board[i][j] == 'X') {
          continue;
        }
        int mineCount = 0;
        for (int x = -1; x <= 1; x++) {
          for (int y = -1; y <= 1; y++) {
            int newRow = i + x;
            int newCol = j + y;
            if (newRow >= 0 && newRow < rows && newCol >= 0 && newCol < cols && board[newRow][newCol] == 'X') {
              mineCount++;
            }
          }
        }
        if (mineCount > 0) {
          board[i][j] = mineCount.toString();
        }
      }
    }
  }

  /// Reveals the cell at the specified row and column.
  /// If the cell contains a mine, the game is over.
  /// If the cell is empty, recursively reveals adjacent cells.
  void revealCell(int row, int col) {
    if (row < 0 || row >= rows || col < 0 || col >= cols || revealed[row][col] || gameOverFlag) {
      return;
    }

    revealed[row][col] = true;

    if (board[row][col] == 'X') {
      gameOver();
    } else if (board[row][col] == ' ') {
      revealNeighbors(row, col);
    }
  }

  /// Recursively reveals the neighbors of the specified cell.
  void revealNeighbors(int row, int col) {
    for (int i = -1; i <= 1; i++) {
      for (int j = -1; j <= 1; j++) {
        int newRow = row + i;
        int newCol = col + j;
        if (newRow >= 0 && newRow < rows && newCol >= 0 && newCol < cols) {
          revealCell(newRow, newCol);
        }
      }
    }
  }

  /// Ends the game and prints the final board state.
  void gameOver() {
    gameOverFlag = true;
    print('Game Over!');
    printBoard(showAll: true);
    exit(0);
  }

  /// Prints the current state of the board.
  /// Revealed cells show their content, while unrevealed cells show '#'.
  /// If `showAll` is true, all cells are shown.
  void printBoard({bool showAll = false}) {
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
        if (showAll || revealed[i][j]) {
          stdout.write(board[i][j]);
        } else {
          stdout.write('#');
        }
        stdout.write(' ');
      }
      stdout.writeln();
    }
  }
}

void main() {
  int rows = 10;
  int cols = 10;
  int numMines = 10;

  Minesweeper game = Minesweeper(rows, cols, numMines);

  while (true) {
    game.printBoard();
    stdout.write('Enter row and column to reveal (e.g., "3 4"): ');
    String? input = stdin.readLineSync();
    if (input == null || input.isEmpty) {
      print('Invalid input. Please enter row and column.');
      continue;
    }

    List<String> parts = input.split(' ');
    if (parts.length != 2) {
      print('Invalid input. Please enter row and column.');
      continue;
    }

    try {
      int row = int.parse(parts[0]);
      int col = int.parse(parts[1]);

      if (row < 0 || row >= game.rows || col < 0 || col >= game.cols) {
        print('Coordinates out of bounds. Please try again.');
        continue;
      }

      game.revealCell(row, col);
    } catch (e) {
      print('Invalid input. Please enter valid numbers for row and column.');
    }
  }
}
