require 'tree_graph'

module Constree
  Node = Struct.new :constant, :name, :parent do

    include TreeGraph

    def label_for_tree_graph
      display_name + ' ' + type
    end

    def children_for_tree_graph
      @sub_consts ||= []
    end

    attr_accessor :ref

    def sub_nodes
      return [] unless constant.is_a? Module
      constant.constants.map do |name|
        Node.new(constant.const_get(name), name, self)
      end
    end

    def top?
      parent ? false : true
    end

    def display_name
      (name || constant.name).to_s
    end

    def full_name
      top? ? constant.name : "#{parent.full_name}::#{name}"
    end

    def == other
      return false unless other.is_a? Node
      constant == other.constant
    end

    def type
      return "→ #{ref.full_name}" if ref
      return "(#{constant.class.to_s})" unless Class === constant
      "< " + constant.ancestors[1..].map(&:to_s).join(" < ")
    end

    def not_yet? seen
      i = seen.find_index self
      if i == seen.count - 1
       true
      else
        self.ref = seen[i]
        false
      end
    end

  end
end
