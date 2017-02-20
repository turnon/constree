require 'test_helper'

class ConstreeNotFromRootTest < Minitest::Test

  def setup
    @list = Constree.list ConstreeTest::A::C
    @c, @g, @b, @c1, @e, @d, @h, @f = *@list
  end

  def test_of
    tree = <<EOS
ConstreeTest::A::C (Class)
├─G (Module)
│ ├─B (Class)
│ ├─C → ConstreeTest::A::C
│ └─E (Symbol)
├─D (Module)
│ └─H → ConstreeTest::A::C
└─F (Symbol)
EOS
    assert_equal tree.chomp, Constree.of(ConstreeTest::A::C)
  end
end

require 'constree_test/a'
