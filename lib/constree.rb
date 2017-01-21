require 'constree/version'
require 'constree/node'

module Constree

  class << self

    def list node, seen=[]
      node = Node.new node unless node.is_a? Node
      seen << node if seen.empty?

      node.sub_nodes.each do |sub_n|
        seen << sub_n
        list(sub_n, seen) if not_listed? seen, sub_n
      end

      seen
    end

    def not_listed? seen, node
      seen.find_index(node) == seen.count - 1
    end

  end

end
