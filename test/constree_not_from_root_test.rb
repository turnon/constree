require 'test_helper'

class ConstreeNotFromRootTest < Minitest::Test

  def setup
    @list = Constree.list ConstreeTest::A::C
    @c, @g, @b, @c1, @e, @d, @h, @f = *@list
  end

  def test_level
    assert_equal 'ConstreeTest::A::C (Class)', @c.level
    assert_equal '├─G (Module)', @g.level
    assert_equal '│ ├─B (Class)', @b.level
    assert_equal '│ ├─C → ConstreeTest::A::C', @c1.level
    assert_equal '│ └─E (Symbol)', @e.level
    assert_equal '├─D (Module)', @d.level
    assert_equal '│ └─H → ConstreeTest::A::C', @h.level
    assert_equal '└─F (Symbol)', @f.level
  end
end

require 'constree_test/a'
