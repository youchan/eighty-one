module EightyOne
  class Piece
    include Helper

    def self.new_class(forward, backword)
      Class.new(self) do |c|
        c.instance_eval do
          define_method(:forward) { forward }
          define_method(:backward) { backward }
        end
      end
    end

    attr_reader :turn

    def initialize(turn)
      assert(turn == :sente || turn == :gote)
      @turn = turn
      @is_forward = true
    end

    def face
      @is_forward ? forward : backward
    end

    def reset(turn)
      @turn = turn
      @is_forward = true
    end

    def promote
      @is_forward = false
    end

    def to_s
      (@turn == :sente ? ?+ : ?-) + face.symbol.to_s
    end
  end

  module Pieces
    Fu = Piece.new_class(Faces::FU, Faces::TO)
    Ky = Piece.new_class(Faces::KY, Faces::NY)
    Ke = Piece.new_class(Faces::KE, Faces::NK)
    Gi = Piece.new_class(Faces::GI, Faces::NG)
    Ki = Piece.new_class(Faces::KI, nil)
    Ka = Piece.new_class(Faces::KA, Faces::UM)
    Hi = Piece.new_class(Faces::HI, Faces::RY)
    Ou = Piece.new_class(Faces::OU, nil)
  end
end