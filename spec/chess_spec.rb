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
				expect(type).to be_a(Pawn)
				end
				subject[6].each do |type|
				expect(type).to be_a(Pawn)
				end
			end

			it "populates board spaces [0][0], [0][7], [7][0], [7][7] with Rookes" do
				expect(subject[0][0]).to be_a(Rooke)
				expect(subject[0][7]).to be_a(Rooke)
				expect(subject[7][0]).to be_a(Rooke)
				expect(subject[7][7]).to be_a(Rooke)
			end

			it "populates board spaces [0][1], [0][6], [7][1], [7][6] with Knights" do
				expect(subject[0][1]).to be_a(Knight)
				expect(subject[0][6]).to be_a(Knight)
				expect(subject[7][1]).to be_a(Knight)
				expect(subject[7][6]).to be_a(Knight)
			end

			it "populates board spaces [0][2], [0][5], [7][2], [7][5] with Bishops" do
				expect(subject[0][2]).to be_a(Bishop)
				expect(subject[0][5]).to be_a(Bishop)
				expect(subject[7][2]).to be_a(Bishop)
				expect(subject[7][5]).to be_a(Bishop)
			end

			it "populates board spaces [0][3], [7][3] with Queens" do
				expect(subject[0][3]).to be_a(Queen)
				expect(subject[7][3]).to be_a(Queen)
			end

			it "populates board spaces [0][4], [7][4] with Kings" do
				expect(subject[0][4]).to be_a(King)
				expect(subject[7][4]).to be_a(King)
			end
		end
	end
end

describe Player do
	let(:player) { Player.new("Dingo") }
	describe "#new" do
		context "beginning of game" do
			it "sets player's name" do
				expect(player.name).to eq("Dingo")
			end
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
	context "Check that it inherits from Piece class" do
		it { expect(Pawn.superclass).to be Piece }
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


