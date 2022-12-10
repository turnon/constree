require 'test_helper'

class ConstreeNotFromRootTest < Minitest::Test

  # def setup
  #   @list = Constree.list ConstreeTest::A::C
  #   @c, @g, @b, @c1, @e, @d, @h, @f = *@list
  # end

  def test_of
    tree = <<EOS
ConstreeTest::A::C {:kla=>Class, :aft=>[Object, Minitest::Expectations, Kernel, BasicObject]}
├─D {:kla=>Module}
│ └─H {:ref=>"ConstreeTest::A::C"}
├─F {:kla=>Symbol}
└─G {:kla=>Module}
  ├─B {:kla=>Class, :aft=>[Object, Minitest::Expectations, Kernel, BasicObject]}
  ├─C {:ref=>"ConstreeTest::A::C"}
  ├─E {:kla=>Float}
  └─J {:kla=>Class, :aft=>[Object, Minitest::Expectations, Kernel, BasicObject]}
    ├─K {:kla=>Class, :aft=>[Object, Minitest::Expectations, Kernel, BasicObject]}
    ├─L {:kla=>Module}
    ├─M {:kla=>Module}
    └─N {:kla=>Class, :bef=>[ConstreeTest::A::J::L], :aft=>[ConstreeTest::A::J::M, ConstreeTest::A::J::K, Object, Minitest::Expectations, Kernel, BasicObject]}
EOS
    assert_equal tree.chomp, Constree.of(ConstreeTest::A::C)
  end
end

require 'constree_test/a'
