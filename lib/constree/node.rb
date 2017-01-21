module Constree
  Node = Struct.new :constant, :name, :parent, :is_last do
    def sub_nodes
      return [] unless constant.is_a? Module
      names = constant.constants
      names.reduce([]) do |nodes, name|
        nodes << Node.new(constant.const_get(name), name, self, nodes.count == names.count - 1)
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

    def last?
      is_last ? true : false
    end

    def top?
      parent ? false : true
    end

    def branch
      return '' unless parent
      last? ? '└─' : '├─'
    end

    def indent
      ancestors.map do |a|
        if a.top?
          ''
        else
          a.last? ? ' ' : '│ '
        end
      end.join
    end

    def level
      indent + branch + short_name
    end

    def short_name
      (name || constant.name.split(/::/)[-1]).to_s
    end

  end
end
