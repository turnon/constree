require 'test_helper'

class ConstreeTest < Minitest::Test

  module A
    class B;end
    class C
      module D;end
      F = :f
    end
  end

  def setup
    @list = Constree.list A
    @a, @ab, @ac, @acd, @acf = *@list
  end

  def test_that_it_has_a_version_number
    refute_nil ::Constree::VERSION
  end

  def test_list
    expected = [ConstreeTest::A, ConstreeTest::A::B, ConstreeTest::A::C, ConstreeTest::A::C::D, :f]
    assert_equal expected, @list.map(&:constant)
  end

  def test_first_node_has_no_parent
    assert_nil @a.parent
  end

  def test_parent
    assert_equal @a, @ab.parent
    assert_equal @a, @ac.parent
    assert_equal @ac, @acd.parent
    assert_equal @ac, @acf.parent
  end

  def test_ancesotors
    assert_equal [@a], @ab.ancestors
    assert_equal [@a], @ac.ancestors
    assert_equal [@a, @ac], @acd.ancestors
    assert_equal [@a, @ac], @acf.ancestors
  end
end
