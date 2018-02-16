class EightyOne::BoardTest < Test::Unit::TestCase
  def setup
    @board = EightyOne::Board.new
  end

  def test_move
    @board.initial_state
    @board.move_from(1,3).to(1,4)

    assert_nil(@board[1,3])
    assert_equal(:FU, @board[1,4].face.symbol)
  end

  def test_failure_movement
    @board.initial_state
    assert_raise do
      @board.move_from(8,8).to(8,7)
    end
  end

  def test_stop_towarding_movement
    @board[1,9] = EightyOne::Pieces::Ky.new(:sente)
    @board[1,7] = EightyOne::Pieces::Fu.new(:gote)

    assert_raise(EightyOne::CantGetMovement) do
      @board.move_from(1,9).to(1,6)
    end
  end

  def test_capturing
    @board[1,9] = EightyOne::Pieces::Ky.new(:sente)
    @board[1,7] = EightyOne::Pieces::Fu.new(:gote)
    @board.move_from(1,9).to(1,7)
    assert_equal(:KY, @board[1,7].face.symbol)
    assert_equal([:FU, :sente], @board.sente_hands.first.yield_self{|x| [x.face.symbol, x.turn] })
  end

  def test_encode_decode
    (1..5).each do |i| @board[10 - i, i] = EightyOne::Pieces::Fu.new(:sente) end
    (6..9).each do |i| @board[10 - i, i] = EightyOne::Pieces::Fu.new(:gote) end
    @board.sente_hands <<  EightyOne::Pieces::Ky.new(:sente)
    @board.gote_hands <<  EightyOne::Pieces::Ke.new(:gote)

    assert_equal(@board.to_s, EightyOne::Board.decode(@board.encode).to_s)
  end
end
