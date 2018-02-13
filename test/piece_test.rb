class EightyOne::PieceTest < Test::Unit::TestCase
  def test_create_fu
    fu = EightyOne::Pieces::Fu.new(:sente)
    assert_equal(:FU, fu.face.symbol)
  end
end
