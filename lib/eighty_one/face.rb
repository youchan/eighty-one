module EightyOne
  class Face
    attr_reader :symbol, :movement

    def initialize(symbol, movement)
      @symbol = symbol
      @movement = movement
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
    TO = Face.new(:TO, KI.movement)
    NY = Face.new(:NY, KI.movement)
    NK = Face.new(:NK, KI.movement)
    NG = Face.new(:NG, KI.movement)
    UM = Face.new(:UM, KA.movement + [[0, 1], [-1, 0], [1, 0], [0, -1]])
    RY = Face.new(:RY, HI.movement + [[-1, 1], [1, 1], [-1, -1], [1, -1]])
  end
end