require 'tree_graph'

module Constree
  Node = Struct.new :constant, :name, :parent, :is_last do

    include TreeGraph

    def parent_for_tree_graph
      parent
    end

    def label_for_tree_graph
      display_name + ' ' + type
    end

    def is_last_for_tree_graph
      is_last ? true : false
    end

    attr_accessor :ref

    def sub_nodes
      return [] unless constant.is_a? Module
      names = constant.constants
      names.reduce([]) do |nodes, name|
        nodes << Node.new(constant.const_get(name), name, self, nodes.count == names.count - 1)
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
      ref ? "→ #{ref.full_name}" : "(#{constant.class.to_s})"
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
