module EightyOne
  class Face
    attr_reader :symbol, :movements

    def initialize(symbol, movements)
      @symbol = symbol
      @movements = movements
    end
  end

  module Faces
    class Direction
      include Enumerable

      attr_reader :dir

      def initialize(col, row)
        @dir = [col, row]
      end

      def each
        (1..8).each do |i|
          yield [@dir[0] * i, @dir[1] * i]
        end
      end
    end

    def self.dir(col, row)
      Direction.new(col, row)
    end

    FU = Face.new(:FU, [[0, 1]])
    KY = Face.new(:KY, [dir(0, 1)])
    KE = Face.new(:KE, [[-1, 2], [1, 2]])
    GI = Face.new(:GI, [[-1, 1], [0, 1], [1, 1], [-1, -1], [1, -1]])
    KI = Face.new(:KI, [[-1, 1], [0, 1], [1, 1], [-1, 0], [-1, 0], [0, -1]])
    KA = Face.new(:KA, [dir(-1, 1), dir(1, 1), dir(-1, -1), dir(1, -1)])
    HI = Face.new(:HI, [dir(0, 1), dir(0, -1), dir(-1, 0), dir(1, 0)])
    OU = Face.new(:OU, [[-1, 1], [0, 1], [1, 1], [-1, 0], [1, 0], [-1, -1], [0, -1], [1, -1]])
    TO = Face.new(:TO, KI.movements)
    NY = Face.new(:NY, KI.movements)
    NK = Face.new(:NK, KI.movements)
    NG = Face.new(:NG, KI.movements)
    UM = Face.new(:UM, KA.movements + [[0, 1], [-1, 0], [1, 0], [0, -1]])
    RY = Face.new(:RY, HI.movements + [[-1, 1], [1, 1], [-1, -1], [1, -1]])

    ALL = [ FU, KY, KE, GI, KI, KA, HI, OU, TO, NY, NK, NG, UM, RY ]
  end
end
