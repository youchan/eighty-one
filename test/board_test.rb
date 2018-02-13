class EightyOne::BoardTest < Test::Unit::TestCase
  def setup
    @board = EightyOne::Board.new
  end

  def test_move
    @board.initial_state
    @board.move_from(1,3).to(1,4)

    assert_equal(nil, @board[1,3])
    assert_equal(:FU, @board[1,4].face.symbol)
  end
end
