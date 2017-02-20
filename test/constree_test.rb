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

  def test_short_name
    assert_equal %{ConstreeTest::A B C G D H F E}, @list.map(&:display_name).join(' ')
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
