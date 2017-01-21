module Constree
  Node = Struct.new :constant, :parent, :is_last do
    def sub_nodes
      return [] unless constant.is_a? Module
      constant.constants.map do |name|
	Node.new constant.const_get(name), self
      end
    end

    def ancestors
      return [] unless parent
      p, anc = parent, []
      while p
	anc.unshift p
	p = p.parent
      end
      anc
    end

  end
end
