int cols, rows;
int cellSize = 10;
int[][] grid;
int[][] nextGrid;

void setup() {
  size(800, 600);
  cols = width / cellSize;
  rows = height / cellSize;
  grid = new int[cols][rows];
  nextGrid = new int[cols][rows];

  background(0);
  stroke(55);

  // Draw the grid lines
  for (int y = 0; y <= height; y += cellSize) {
    line(0, y, width, y);
  }
  for (int x = 0; x <= width; x += cellSize) {
    line(x, 0, x, height);
  }

  initGrid();
}

void draw() {
  background(0); // Clear the screen for the next frame
  displayGrid();
  updateGrid();
}

void initGrid() {
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      grid[i][j] = (random(100) < 20) ? 1 : 0; // Random initialization
    }
  }
}

int checkAround(int x, int y) {
  int count = 0;
  for (int i = -1; i <= 1; i++) {
    for (int j = -1; j <= 1; j++) {
      if (i == 0 && j == 0) continue; // Skip the current cell

      int neighborX = x + i;
      int neighborY = y + j;

      // Check boundaries
      if (neighborX >= 0 && neighborX < cols && neighborY >= 0 && neighborY < rows) {
        count += grid[neighborX][neighborY];
      }
    }
  }
  return count;
}

void updateGrid() {
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      int neighbors = checkAround(i, j);

      // Apply the Game of Life rules
      if (grid[i][j] == 1) {
        nextGrid[i][j] = (neighbors == 2 || neighbors == 3) ? 1 : 0; // Survive or die
      } else {
        nextGrid[i][j] = (neighbors == 3) ? 1 : 0; // Birth
      }
    }
  }

  // Swap the grids
  int[][] temp = grid;
  grid = nextGrid;
  nextGrid = temp;
}

void displayGrid() {
  for (int y = 0; y < rows; y++) {
    for (int x = 0; x < cols; x++) {
      if (grid[x][y] > 0) {
        fill(0, 200, 0);
      } else {
        fill(0);
      }
      square(x * cellSize, y * cellSize, cellSize);
    }
  }
}
