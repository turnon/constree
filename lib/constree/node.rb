require 'tree_graph'
require 'tree_html'

module Constree
  Node = Struct.new :constant, :name, :parent do

    include TreeGraph

    def label_for_tree_graph
      "#{display_name} #{verbose}"
    end

    def children_for_tree_graph
      @sub_consts ||= []
    end

    include TreeHtml

    def label_for_tree_html
      "<span class='hl'>#{display_name}</span> #{verbose}"
    end

    alias_method :children_for_tree_html, :children_for_tree_graph

    def css_for_tree_html
      '.hl{color: coral;}'
    end

    attr_accessor :ref

    def sub_nodes
      return [] unless constant.is_a? Module
      constant.constants.sort!.map! do |name|
        const_value = constant.const_get(name)
        Node.new(const_value, name, self)
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
      return false unless constant.is_a? Module
      return false unless other.is_a? Node
      constant == other.constant
    end

    def verbose
      return {ref: ref.full_name} if ref

      info = {kla: constant.class}
      return info unless constant.is_a? Module

      ancestors = constant.ancestors
      idx = ancestors.index(constant)
      if idx > 0 && !(before = ancestors[0 .. (idx - 1)]).empty?
        info[:bef] = before
      end
      unless (after = ancestors[(idx + 1) .. -1]).empty?
        info[:aft] = after
      end

      info
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

  class NodeWithAncestors < Node
    def type
      return "→ #{ref.full_name}" if ref
      return "(#{constant.class.to_s})" unless Class === constant
      "< " + constant.ancestors[1..].map(&:to_s).join(" < ")
    end
  end
end
