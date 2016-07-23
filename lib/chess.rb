

class Board
  attr_reader :board

  def initialize
    #Create 8x8 game board as a 2d array
    @board = Array.new(8){Array.new(8)}
    populate
  end

  def populate
    #Populates board rows 1 & 6 with Pawns
    @board[1].map! { |pawn_space| pawn_space = Pawn.new("Black", "265F") }
    @board[6].map! { |pawn_space| pawn_space = Pawn.new("White", "2659") }

    #Populates board spaces [0][0], [0][7], [7][0], [7][7] with Rookes
    @board[0][0] = Rooke.new("Black", "265C")
    @board[0][7] = Rooke.new("Black", "265C")
    @board[7][0] = Rooke.new("White", "2656")
    @board[7][7] = Rooke.new("White", "2656")

    #Populates board spaces [0][1], [0][6], [7][1], [7][6] with Knights
    @board[0][1] = Knight.new("Black", "265E")
    @board[0][6] = Knight.new("Black", "265E")
    @board[7][1] = Knight.new("White", "2658")
    @board[7][6] = Knight.new("White", "2658")

    #Populates board spaces [0][2], [0][5], [7][2], [7][5] with Bishops
    @board[0][2] = Bishop.new("Black", "265D")
    @board[0][5] = Bishop.new("Black", "265D")
    @board[7][2] = Bishop.new("White", "2657")
    @board[7][5] = Bishop.new("White", "2657")

    #Populates board spaces [0][3], [7][3] with Queens
    @board[0][3] = Queen.new("Black", "265B")
    @board[7][3] = Queen.new("White", "2655")

    #Populates board spaces [0][4], [7][4] with Kings
    @board[0][4] = King.new("Black", "265A")
    @board[7][4] = King.new("White", "2654")
  end
end

class Player
  attr_reader :name

  def initialize(name)
    @name = name
  end
end

class Piece
  attr_reader :color, :unicode

  def initialize(color, unicode)
    @color = color
    @unicode = [unicode.hex].pack("U")
  end
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
