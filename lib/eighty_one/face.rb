module EightyOne
  class Face
    attr_reader :symbol, :movements

    def initialize(symbol, movements)
      @symbol = symbol
      @movements = movements
    end
  end

  module Faces
    FU = Face.new(:FU, [0, 1])
    KY = Face.new(:KY, (1..8).map{|i| [0, i] })
    KE = Face.new(:KE, [[-1, 2], [1, 2]])
    GI = Face.new(:GI, [[-1, 1], [0, 1], [1, 1], [-1, -1], [1, -1]])
    KI = Face.new(:KI, [[-1, 1], [0, 1], [1, 1], [-1, 0], [-1, 0], [0, -1]])
    KA = Face.new(:KA, (1..8).map{|i| [[-i, i], [i, i], [-i, -i], [i, -i]] }.flatten(1))
    HI = Face.new(:HI, (1..8).map{|i| [[0, i], [0, -i], [-i, 0], [i, 0]] }.flatten(1))
    OU = Face.new(:OU, [[-1, 1], [0, 1], [1, 1], [-1, 0], [1, 0], [-1, -1], [0, -1], [1, -1]])
    TO = Face.new(:TO, KI.movements)
    NY = Face.new(:NY, KI.movements)
    NK = Face.new(:NK, KI.movements)
    NG = Face.new(:NG, KI.movements)
    UM = Face.new(:UM, KA.movements + [[0, 1], [-1, 0], [1, 0], [0, -1]])
    RY = Face.new(:RY, HI.movements + [[-1, 1], [1, 1], [-1, -1], [1, -1]])
  end
end
