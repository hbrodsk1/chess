class Board
  attr_accessor :board

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

  def display

    print "       "
    (0..7).each do |top_row_number|
      print "#{top_row_number}     "
    end
    print "\n       --------------------------------------------"
    puts "\n"

    (0..7).each do |row|
      print "   #{row}"
      print "   "
      (0..7).each do |col|
        if @board[row][col].class.superclass == Piece
          print @board[row][col].unicode
        else
          print @board[row][col]
        end

        print "  |  " if !@board[row][col].nil? unless col == 7
        print "   |  " if @board[row][col].nil? unless col == 7
      end
      print "\n"
      print "       --------------------------------------------\n" 
    end
    print "\n"
  end
end

class Player
  attr_reader :name, :color

  def initialize(color)
    @name = ""
    @color = color
  end

  def set_name
    puts "Please enter your name..."
    @name = gets.chomp

    #return @name
  end
end

class Piece
  attr_reader :color, :unicode

  def initialize(color, unicode)
    @color = color
    #Converts unicode into a chess piece symbol
    @unicode = [unicode.hex].pack("U")
  end
end

class Pawn < Piece
  def self.move(current_space, end_space)

  end

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

class Game

  def initialize
    @player_1 = ""
    @player_2 = ""
    @current_player = ""
    @current_color = ""
    @piece_to_move = ""
    @space_to_move_to = ""
    @board = Board.new
  end

  def welcome_message
    puts "\n\nWelcome to chess!\n\nPlayer 1, what would you like to be called?\n"

    @player_1 = Player.new("Black") ; @player_1.set_name
    @current_player = @player_1.name
    @current_color = @player_1.color

    puts "\nThank you #{@player_1.name}"

    puts "\nPlayer 2, what would you like to be called?\n"

    @player_2 = Player.new("White") ; @player_2.set_name
    puts "\nThank you #{@player_2.name}\n\n"
  end

  def turn_message
    #@board.board[2][2] = Pawn.new("Black", "265F")
    #@board.board[1][2] = nil
    #@board.display
    @board.display
    puts "Your turn, #{@current_player}. Please select the piece you would like to move\nby typing in its coordinates, separated by a comma and a space. ie. 6, 2\n\n"

    find_piece_type
  end

  def find_piece_type
    if format_origin_space_input && format_destination_space_input
      @piece_class = @board.board[@piece_to_move[0]][@piece_to_move[1]].class
      
      @board.board[@space_to_move_to[0]][@space_to_move_to[1]] = @board.board[@piece_to_move[0]][@piece_to_move[1]]
      @board.board[@piece_to_move[0]][@piece_to_move[1]] = nil
      @board.display
    else
      turn_message 
    end
  end

  def format_origin_space_input
    acceptable_input = ["0", "1", "2", "3", "4", "5", "6", "7"]
    @piece_to_move = gets.chomp.split(", ")

    if @piece_to_move.length == 2 && @piece_to_move.all? { |num| acceptable_input.include?(num) }
      @piece_to_move = @piece_to_move.map! { |string| string.to_i }
      return validate_piece_to_move_input(@piece_to_move[0], @piece_to_move[1])
    else
      error_message("bad range")
      return false
    end
  end

  def format_destination_space_input
    acceptable_input = ["0", "1", "2", "3", "4", "5", "6", "7"]

    puts "Please select the space you would like to move to\nby typing in its coordinates, separated by a comma and a space. ie. 6, 2\n\n"
    @space_to_move_to = gets.chomp.split(", ")

    if @space_to_move_to.length == 2 && @space_to_move_to.all? { |num| acceptable_input.include?(num) }
      @space_to_move_to = @space_to_move_to.map! { |string| string.to_i }
      return validate_space_to_move_to(@space_to_move_to[0], @space_to_move_to[1])
    else
      error_message("bad range")
      return false
    end
    #@board.board[@piece_to_move[0]][@piece_to_move[1]] = nil
    #@board.display
  end

  def validate_piece_to_move_input(input_1, input_2)
    unless input_1.between?(0, 7) && input_2.between?(0, 7)
      return false
    end

    if !@board.board[input_1][input_2].nil?
      return true
    else
      error_message("no piece")
      return false
    end
  end

  def validate_space_to_move_to(input_1, input_2)
    if @board.board[input_1][input_2].nil?
      return true
    #else
     # error_message("no piece")
      #return false
    end
  end

  def error_message(error_type)
    case error_type
    when "bad range"
      #@board.display
      puts "\n\nPlease make sure consists of two numbers betweem 0 and 7"
    when "no piece"
      #@board.display
      puts "\n\nYou must enter a space that currently has one of your pieces"
    end
  end

  def switch_players
    if @current_player == @player_1.name
      @current_player = @player_2.name
    elsif @current_player == @player_2.name
      @current_player = @player_1.name
    end
  end
end


x = Game.new ; x.welcome_message ; x.turn_message
