module EightyOne
  class Board
    include Helper

    def initialize
      @board = Array.new(81)
    end

    def initial_state
      (1..9).each do |i|
        self[7, i] = Pieces::Fu.new(:sente)
        self[3, i] = Pieces::Fu.new(:gote)
      end
      [1, 9].each do |i|
        self[9, i] = Pieces::Ky.new(:sente)
        self[1, i] = Pieces::Ky.new(:gote)
      end
      [2, 8].each do |i|
        self[9, i] = Pieces::Ke.new(:sente)
        self[1, i] = Pieces::Ke.new(:gote)
      end
      [3, 7].each do |i|
        self[9, i] = Pieces::Gi.new(:sente)
        self[1, i] = Pieces::Gi.new(:gote)
      end
      [4, 6].each do |i|
        self[9, i] = Pieces::Ki.new(:sente)
        self[1, i] = Pieces::Ki.new(:gote)
      end
      self[8, 2] = Pieces::Ka.new(:sente)
      self[2, 8] = Pieces::Ka.new(:gote)
      self[8, 8] = Pieces::Hi.new(:sente)
      self[2, 2] = Pieces::Hi.new(:gote)
      self[9, 5] = Pieces::Ou.new(:sente)
      self[1, 5] = Pieces::Ou.new(:gote)
    end

    def inside?(row, col)
      1 <= row && 9 >= row && 1 <= col && 9 >= col
    end

    def placeable?(piece, row, col)
      inside?(row, col) && !(self[row, col]&.turn != piece.turn)
    end

    def []=(row, col, value)
      assert(inside?(row, col))
      assert(Piece === value)
      @board[(row - 1) * 9 + col - 1] = value
    end

    def [](row, col)
      @board[(row - 1) * 9 + col - 1]
    end

    def row(row)
      @board[(row - 1) * 9, 9]
    end

    def dests_from(row, col)
      piece = self.at(row, col)
      assert(Piece === piece)
      piece.face.movements.select{|m| placeable?(m, row + m[0], col + m[1]) }
    end

    def to_s
      (1..9).map do |i|
        "P#{i}" + row(i).map{|c| c ? c.to_s : ' * '}.join
      end.join(?\n)
    end
  end
end
