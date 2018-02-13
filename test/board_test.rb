class EightyOne::BoardTest < Test::Unit::TestCase
  def setup
    @board = EightyOne::Board.new
  end

  def test_move
    @board.initial_state
    @board.move_from(3,1).to(4,1)

    puts @board.to_s
    assert_equal(nil, @board[3,1])
    assert_equal(:FU, @board[4,1].face.symbol)
  end
end
