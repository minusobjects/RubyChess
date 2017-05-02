require_relative 'piece.rb'
require_relative 'null_piece.rb'
require_relative 'slideable_pieces.rb'
require_relative 'steppable_pieces.rb'
require_relative 'pawn.rb'

class Board

  attr_reader :grid

  def initialize
    @grid = Array.new(8) { Array.new(8) }
    setup_board
  end

  def [](x,y)
    @grid[y][x]
  end

  def []=(pos, value)
    x = pos[0]
    y = pos[1]
    @grid[y][x] = value
  end

  def setup_board
    # we messed around a bit with the pos numbers
    @grid[0][0] = Rook.new(:blue, self, [0, 0])
    @grid[0][1] = Knight.new(:blue, self, [1, 0])
    @grid[0][2] = Bishop.new(:blue, self, [2, 0])
    @grid[0][3] = King.new(:blue, self, [3, 0])
    @grid[0][4] = Queen.new(:blue, self, [4, 0])
    @grid[0][5] = Bishop.new(:blue, self, [5, 0])
    @grid[0][6] = Knight.new(:blue, self, [6, 0])
    @grid[0][7] = Rook.new(:blue, self, [7, 0])

    @grid[7][0] = Rook.new(:yellow, self, [0, 7])
    @grid[7][1] = Knight.new(:yellow, self, [1, 7])
    @grid[7][2] = Bishop.new(:yellow, self, [2, 7])
    @grid[7][3] = Queen.new(:yellow, self, [3, 7])
    @grid[7][4] = King.new(:yellow, self, [4, 7])
    @grid[7][5] = Bishop.new(:yellow, self, [5, 7])
    @grid[7][6] = Knight.new(:yellow, self, [6, 7])
    @grid[7][7] = Rook.new(:yellow, self, [7, 7])

    row = 1
    col = 0
    while col < 8
      @grid[row][col] = Pawn.new(:blue, self, [col, row])
      col += 1
    end

    row = 6
    col = 0
    while col < 8
      @grid[row][col] = Pawn.new(:yellow, self, [col, row])
      col += 1
    end

    row = 2
    while row < 6
      col = 0
      while col < 8
        @grid[row][col] = NullPiece.instance
        col += 1
      end
      row += 1
    end
  end

  def move_piece(start_pos, end_pos) # enter pos [x,y]
    start_x, start_y = start_pos
    end_x, end_y = end_pos

    piece = @grid[start_y][start_x]
    coords = [start_x, start_y, end_x, end_y]
    raise 'Illegal move!' unless possible_move?(piece, coords)

    @grid[end_y][end_x] = piece
    piece.pos = [end_x, end_y]
    @grid[start_y][start_x] = NullPiece.instance
  end

  def possible_move?(piece, coords)
    if piece.moves.include?([coords[2],coords[3]])
        return true
    end
    false
  end

  def in_bounds?(pos)
    pos.all? { |n| n >= 0 && n <= 7 }
  end

end
