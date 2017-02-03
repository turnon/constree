require 'test_helper'

class ConstreeNotFromRootTest < Minitest::Test

  def setup
    @list = Constree.list ConstreeTest::A::C
    @c, @g, @b, @c1, @e, @d, @h, @f = *@list
  end

  def test_tree_graph_level
    assert_equal 'ConstreeTest::A::C (Class)', @c.tree_graph_level
    assert_equal '├─G (Module)', @g.tree_graph_level
    assert_equal '│ ├─B (Class)', @b.tree_graph_level
    assert_equal '│ ├─C → ConstreeTest::A::C', @c1.tree_graph_level
    assert_equal '│ └─E (Symbol)', @e.tree_graph_level
    assert_equal '├─D (Module)', @d.tree_graph_level
    assert_equal '│ └─H → ConstreeTest::A::C', @h.tree_graph_level
    assert_equal '└─F (Symbol)', @f.tree_graph_level
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
