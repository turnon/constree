require 'constree/version'
require 'constree/node'
require 'set'

module Constree
  class << self
    def uniq(mod, set = Set.new)
      set << mod
      mod.constants.each do |name|
        sub_mod = mod.const_get(name)
        uniq(sub_mod, set) if ::Module === sub_mod && !set.include?(sub_mod)
      end
      set
    end

    def list node, seen=[]
      node = Node.new node unless node.is_a? Node
      seen << node if seen.empty?

      node.sub_nodes.each do |sub_n|
        seen << sub_n
        node.children_for_tree_graph << sub_n
        list(sub_n, seen) if sub_n.not_yet? seen
      end

      seen
    end

    def of mod
      list(mod).first.tree_graph
    end

    def html_of mod
      list(mod).first.tree_html_full
    end

    def p mod
      puts of mod
    end
  end
end
