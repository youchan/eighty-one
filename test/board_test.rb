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
      puts @board.to_s
    end
  end
end
