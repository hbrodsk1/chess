class Board
  attr_reader :board

  def initialize
    #Create 8x8 game board as a 2d array
    @board = Array.new(8){Array.new(8)}
    populate
  end

  def populate
    #Populates board rows 1 & 6 with Pawns
    @board[1].map! { |pawn_space| pawn_space = Pawn.new }
    @board[6].map! { |pawn_space| pawn_space = Pawn.new }

    #Populates board spaces [0][0], [0][7], [7][0], [7][7] with Rookes
    @board[0][0] = Rooke.new
    @board[0][7] = Rooke.new
    @board[7][0] = Rooke.new
    @board[7][7] = Rooke.new

    #Populates board spaces [0][1], [0][6], [7][1], [7][6] with Knights
    @board[0][1] = Knight.new
    @board[0][6] = Knight.new
    @board[7][1] = Knight.new
    @board[7][6] = Knight.new

    #Populates board spaces [0][2], [0][5], [7][2], [7][5] with Bishops
    @board[0][2] = Bishop.new
    @board[0][5] = Bishop.new
    @board[7][2] = Bishop.new
    @board[7][5] = Bishop.new

    #Populates board spaces [0][3], [7][3] with Queens
    @board[0][3] = Queen.new
    @board[7][3] = Queen.new

    #Populates board spaces [0][4], [7][4] with Kings
    @board[0][4] = King.new
    @board[7][4] = King.new
    #p board
  end
end

class Player
  attr_reader :name

  def initialize(name)
    @name = name
  end
end

class Piece
end

class Pawn < Piece

end

class Rooke < Piece

end

class Knight < Piece

end

class Bishop < Piece

end

class Queen < Piece

end

class King < Piece

end

Board.new
