require 'test_helper'

class ConstreeTest < Minitest::Test

  def setup
    @list = Constree.list A
    @a, @ab, @ac, @acg, @acd, @acdh, @acf, @ae = *@list
  end

  def test_that_it_has_a_version_number
    refute_nil ::Constree::VERSION
  end

  def test_list
    expected = [ConstreeTest::A, ConstreeTest::A::B, ConstreeTest::A::C, ConstreeTest::A, ConstreeTest::A::C::D, ConstreeTest::A::C, :f, :e]
    assert_equal expected, @list.map(&:constant)
  end

  def test_first_node_has_no_parent
    assert_nil @a.parent
  end

  def test_parent
    assert_equal @a, @ab.parent
    assert_equal @a, @ac.parent
    assert_equal @ac, @acg.parent
    assert_equal @ac, @acd.parent
    assert_equal @ac, @acf.parent
    assert_equal @a, @ae.parent
  end

  def test_short_name
    assert_equal %{ConstreeTest::A B C G D H F E}, @list.map(&:display_name).join(' ')
  end

  def test_tree_graph_level
    assert_equal 'ConstreeTest::A (Module)', @a.tree_graph_level
    assert_equal '├─B (Class)', @ab.tree_graph_level
    assert_equal '├─C (Class)', @ac.tree_graph_level
    assert_equal '│ ├─G → ConstreeTest::A', @acg.tree_graph_level
    assert_equal '│ ├─D (Module)', @acd.tree_graph_level
    assert_equal '│ │ └─H → ConstreeTest::A::C', @acdh.tree_graph_level
    assert_equal '│ └─F (Symbol)', @acf.tree_graph_level
    assert_equal '└─E (Symbol)', @ae.tree_graph_level
  end

  def test_of
    tree = <<EOS
ConstreeTest::A (Module)
├─B (Class)
├─C (Class)
│ ├─G → ConstreeTest::A
│ ├─D (Module)
│ │ └─H → ConstreeTest::A::C
│ └─F (Symbol)
└─E (Symbol)
EOS
    assert_equal tree.chomp, Constree.of(A)
  end
end

require 'constree_test/a'
