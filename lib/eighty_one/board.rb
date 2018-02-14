module EightyOne
  class Board
    include Helper

    def initialize
      @board = Array.new(81)
    end

    def initial_state
      (1..9).each do |i|
        self[i, 7] = Pieces::Fu.new(:sente)
        self[i, 3] = Pieces::Fu.new(:gote)
      end
      [1, 9].each do |i|
        self[i, 9] = Pieces::Ky.new(:sente)
        self[i, 1] = Pieces::Ky.new(:gote)
      end
      [2, 8].each do |i|
        self[i, 9] = Pieces::Ke.new(:sente)
        self[i, 1] = Pieces::Ke.new(:gote)
      end
      [3, 7].each do |i|
        self[i, 9] = Pieces::Gi.new(:sente)
        self[i, 1] = Pieces::Gi.new(:gote)
      end
      [4, 6].each do |i|
        self[i, 9] = Pieces::Ki.new(:sente)
        self[i, 1] = Pieces::Ki.new(:gote)
      end
      self[2, 8] = Pieces::Ka.new(:sente)
      self[8, 2] = Pieces::Ka.new(:gote)
      self[8, 8] = Pieces::Hi.new(:sente)
      self[2, 2] = Pieces::Hi.new(:gote)
      self[5, 9] = Pieces::Ou.new(:sente)
      self[5, 1] = Pieces::Ou.new(:gote)
    end

    def inside?(col, row)
      1 <= row && 9 >= row && 1 <= col && 9 >= col
    end

    def placeable?(piece, col, row)
      inside?(col, row) && !(self[col, row]&.turn != piece.turn)
    end

    def []=(col, row, value)
      assert(inside?(col, row))
      assert(value.nil? || Piece === value)
      @board[(row - 1) * 9 + col - 1] = value
    end

    def [](col, row)
      @board[(row - 1) * 9 + col - 1]
    end

    alias :at :[]

    def row(row)
      @board[(row - 1) * 9, 9]
    end

    def dests_from(col, row)
      piece = self.at(col, row)
      assert(Piece === piece)
      piece.face.movements.select{|m| placeable?(m, col + m[0], row + m[1]) }
    end

    def move_from(col, row)
      Transition.new(self, col, row)
    end

    def place(piece, col, row)
      dest = self.at(col, row)
      if dest
        assert(Piece === dest)
        assert(dest.turn != piece.turn)
        dest.reset(piece.turn)
      end
      self[col, row] = piece
    end

    def to_s
      (1..9).map do |i|
        "P#{i}" + row(i).map{|c| c ? c.to_s : ' * '}.join
      end.join(?\n)
    end

    class Transition
      include Helper

      def initialize(board, col, row)
        @from = [col, row]
        @board = board
        @piece = board.at(col, row)
        assert(Piece === @piece)
      end

      def to(col, row)
        @board[*@from] = nil
        @board.place(@piece, col, row)
      end
    end
  end
end
