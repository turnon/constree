require 'test_helper'

class ConstreeTest < Minitest::Test

  module A
    class B;end
    class C
      module D;end
      F = :f
    end
    E = :e
  end

  def setup
    @list = Constree.list A
    @a, @ab, @ac, @acd, @acf, @ae = *@list
  end

  def test_that_it_has_a_version_number
    refute_nil ::Constree::VERSION
  end

  def test_list
    expected = [ConstreeTest::A, ConstreeTest::A::B, ConstreeTest::A::C, ConstreeTest::A::C::D, :f, :e]
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

  def test_is_last
    assert @acf.last?
    refute @acd.last?
  end

  def test_branch
    assert_equal '', @a.branch
    assert_equal '├─', @ab.branch
    assert_equal '└─', @acf.branch
  end

  def test_indent
    assert_equal '', @a.indent
    assert_equal '', @ab.indent
    assert_equal '', @ac.indent
    assert_equal '│ ', @acd.indent
    assert_equal '│ ', @acf.indent
    assert_equal '', @ae.indent
  end

  def test_short_name
    assert_equal %{A B C D F E}, @list.map(&:short_name).join(' ')
  end

  def test_level
    assert_equal 'A', @a.level
    assert_equal '├─B', @ab.level
    assert_equal '├─C', @ac.level
    assert_equal '│ ├─D', @acd.level
    assert_equal '│ └─F', @acf.level
    assert_equal '└─E', @ae.level
  end
end
