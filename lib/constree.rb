require 'constree/version'
require 'constree/node'

module Constree

  class << self

    def list node, seen=[]
      node = Node.new node unless node.is_a? Node
      seen << node if seen.empty?

      node.sub_nodes.each do |sub_n|
	seen << sub_n
	list sub_n, seen
      end

      seen
    end

  end

end
