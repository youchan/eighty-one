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

    def double_fu?(piece, col, row)
      piece.face.symbol == :FU && (1..9).any?{|i| self[i, row]&.yield_self{|p| p.face.symbol == :FU && p.turn == piece.turn } }
    end

    def can_move_to_any_place?(piece, col, row)
      !([:FU, :KY].include?(piece.face.symbol) && (piece.sente? ? col == 1 : col == 9))
    end

    def placeable?(piece, col, row, from_hand = false)
      res = inside?(col, row) && !(self[col, row]&.turn == piece.turn)
      res &&= can_move_to_any_place?(piece, col, row) && !double_fu?(piece, col, row) if from_hand
      res
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
      dest = Proc.new{|(c, r)| [col + c, row + r] }
      piece.face.movements.map do |m|
        if EightyOne::Faces::Direction === m
          m.toward_while do |p|
            dest[p].yield_self{|p| placeable?(piece, *p) && self.at(*p).nil? }
          end
        else
          dest[m].yield_self{|p| placeable?(piece, *p) ? [p] : [] }
        end
      end.flatten(1)
    end

    def move_from(col, row)
      Movement.new(self, col, row)
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

    class Movement
      include Helper

      def initialize(board, col, row)
        @from = [col, row]
        @board = board
        @piece = board.at(col, row)
        assert(Piece === @piece)
      end

      def to(col, row)
        if @board.dests_from(*@from).include?([col, row])
          @board[*@from] = nil
          @board.place(@piece, col, row)
        else
          raise CantGetMovement.new
        end
      end
    end
  end
end
