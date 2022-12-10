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
    expected = [
      ConstreeTest::A, 1.2, ConstreeTest::A::B, ConstreeTest::A::C, :f,
      ConstreeTest::A, ConstreeTest::A::C::D, ConstreeTest::A::C,
      ConstreeTest::A::J, ConstreeTest::A::J::K, ConstreeTest::A::J::M,
      ConstreeTest::A::J::N, ConstreeTest::A::J::L
    ].map(&:to_s).sort

    actual = @list.map(&:constant).map(&:to_s).sort

    assert_equal expected, actual
  end

  def test_short_name
    expected = %{B C ConstreeTest::A D E F G H J K L M N}
    actual = @list.map(&:display_name).sort.join(' ')
    assert_equal expected, actual
  end

  def test_of
    tree = <<EOS
ConstreeTest::A {:kla=>Module}
├─B {:kla=>Class, :aft=>[Object, Minitest::Expectations, Kernel, BasicObject]}
├─C {:kla=>Class, :aft=>[Object, Minitest::Expectations, Kernel, BasicObject]}
│ ├─D {:kla=>Module}
│ │ └─H {:ref=>"ConstreeTest::A::C"}
│ ├─F {:kla=>Symbol}
│ └─G {:ref=>"ConstreeTest::A"}
├─E {:kla=>Float}
└─J {:kla=>Class, :aft=>[Object, Minitest::Expectations, Kernel, BasicObject]}
  ├─K {:kla=>Class, :aft=>[Object, Minitest::Expectations, Kernel, BasicObject]}
  ├─L {:kla=>Module}
  ├─M {:kla=>Module}
  └─N {:kla=>Class, :bef=>[ConstreeTest::A::J::L], :aft=>[ConstreeTest::A::J::M, ConstreeTest::A::J::K, Object, Minitest::Expectations, Kernel, BasicObject]}
EOS
    assert_equal tree.chomp, Constree.of(A)
  end
end

require 'constree_test/a'
