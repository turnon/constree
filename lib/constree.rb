require 'constree/version'
require 'constree/node'

module Constree

  class << self

    def list node, seen=[]
      node = Node.new node unless node.is_a? Node
      seen << node if seen.empty?

      node.sub_nodes.each do |sub_n|
        seen << sub_n
        list(sub_n, seen) if sub_n.not_yet? seen
      end

      seen
    end

    def of mod
      list(mod).
        map(&:tree_graph_level).
        join("\n")
    end

    def p mod
      puts of mod
    end

  end

end
