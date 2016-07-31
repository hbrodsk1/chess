require 'chess'

describe Board do
	let(:board) { Board.new }
	describe "#new" do
		context "beginning of game" do
			it "creates a new board" do
				expect(board.board.size).to eq(8)
				expect(board.board[0].size).to eq(8)
			end
		end
	end

	describe "#populate" do
		subject { board.instance_variable_get(:@board) }
		context "at beginning of game" do
			it "populates board rows 1 & 6 with Pawns" do
				subject[1].each do |type|
				expect(type.class).to eq(Pawn)
				end
				subject[6].each do |type|
				expect(type.class).to eq(Pawn)
				end
			end

			it "populates board spaces [0][0], [0][7], [7][0], [7][7] with Rookes" do
				expect(subject[0][0].class).to eq(Rooke)
				expect(subject[0][7].class).to eq(Rooke)
				expect(subject[7][0].class).to eq(Rooke)
				expect(subject[7][7].class).to eq(Rooke)
			end

			it "populates board spaces [0][1], [0][6], [7][1], [7][6] with Knights" do
				expect(subject[0][1].class).to eq(Knight)
				expect(subject[0][6].class).to eq(Knight)
				expect(subject[7][1].class).to eq(Knight)
				expect(subject[7][6].class).to eq(Knight)
			end

			it "populates board spaces [0][2], [0][5], [7][2], [7][5] with Bishops" do
				expect(subject[0][2].class).to eq(Bishop)
				expect(subject[0][5].class).to eq(Bishop)
				expect(subject[7][2].class).to eq(Bishop)
				expect(subject[7][5].class).to eq(Bishop)
			end

			it "populates board spaces [0][3], [7][3] with Queens" do
				expect(subject[0][3].class).to eq(Queen)
				expect(subject[7][3].class).to eq(Queen)
			end

			it "populates board spaces [0][4], [7][4] with Kings" do
				expect(subject[0][4].class).to eq(King)
				expect(subject[7][4].class).to eq(King)
			end
		end
	end
end

describe Player do
	let(:player) { Player.new("Black") }
	describe "#new" do
		context "beginning of game" do
			it "sets player's color" do
				expect(player.color).to eq("Black")
			end
		end
	end

	describe "#set_name" do
		before do
      		io_obj = double
      		expect(player).to receive(:gets).and_return(io_obj)
      		expect(io_obj).to receive(:chomp).and_return("Harry")
    	end
			it "returns @name" do
				player.set_name
				expect(player.instance_variable_get(:@name)).to eq("Harry")
			end
		end
	
end

describe Piece do
	let(:piece) { Piece.new("Black", "265C") }
	describe "#new" do
		context "when new piece is created" do
			it "has a color and a converted unicode symbol" do
				expect(piece.instance_variable_get(:@color)).to eq("Black")
				expect(piece.instance_variable_get(:@unicode)).to eq(["265C".hex].pack("U"))
			end
		end
	end
end

describe Pawn do
	let(:pawn) { Pawn.new("Black", "265F") }
	context "Check that it inherits from Piece class" do
		it { expect(Pawn.superclass).to be Piece }
	end

	describe "#move?" do
		context "regular move" do
			it "allows pawn to move one space forward if space is unoccupied" do
				expect(pawn.move?([1, 1], [2, 1], "Black")).to eq(true)
			end
		end

		context "improper move" do
			it "does not allow pawn to move more than one space forward at a time" do
				expect(pawn.move?([6, 2], [4, 2], "White")).to eq(false)
			end
		end
	end

	describe "#attackable_piece?" do
		subject { Board.new }
		context "pawn can capture opponent's piece" do
			it "returns true" do
				expect(pawn.attackable_piece?([5, 2], [6, 1], "Black", subject)).to eq(true)
			end
		end

		context "pawn can not capture opponent's piece" do
			it "returns false" do
				expect(pawn.attackable_piece?([5, 2], [3, 6], "White", subject)).to eq(false)
			end
		end
	end

end

describe Rooke do
	context "Check that it inherits from Piece class" do
		it { expect(Rooke.superclass).to be Piece }
	end
end

describe Knight do
	context "Check that it inherits from Piece class" do
		it { expect(Knight.superclass).to be Piece }
	end
end

describe Bishop do
	context "Check that it inherits from Piece class" do
		it { expect(Bishop.superclass).to be Piece }
	end
end

describe Queen do
	context "Check that it inherits from Piece class" do
		it { expect(Queen.superclass).to be Piece }
	end
end

describe King do
	context "Check that it inherits from Piece class" do
		it { expect(King.superclass).to be Piece }
	end
end

describe Game do
	let(:game) { Game.new }
	describe "#validate_piece_to_move_input" do
		context "proper range of numbers is given" do
			it "returns true" do
				expect(game.validate_piece_to_move_input(1, 2)).to eq(true)
			end
		end

		context "improper range of numbers is given" do
			it "returns false" do
				expect(game.validate_piece_to_move_input(8, 9)).to eq(false)
			end
		end

		context "space contains a piece to be moved" do
			it "returns true" do
				expect(game.validate_piece_to_move_input(1, 6)).to eq(true)
			end
		end

		context "space does not contain a piece to be moved" do
			it "returns false" do
				expect(game.validate_piece_to_move_input(3, 3)).to eq(false)
			end
		end
	end

	describe "#switch_players" do
		context "@current_player is player_1.name" do
			it "switches @current_player to @player_2.name" do
				@player_1 = game.instance_variable_set(:@player_1, Player.new("Black"))
				allow(@player_1).to receive(:name).and_return("Harry")
				@player_2 = game.instance_variable_set(:@player_2, Player.new("White"))
				allow(@player_2).to receive(:name).and_return("Nick")
	
				game.instance_variable_set(:@current_player, @player_1.name)
				game.switch_players
				expect(game.instance_variable_get(:@current_player)).to eq(@player_2.name)
			end
		end
	end
end


