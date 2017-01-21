require 'constree'

class Module
  def constree
    ::Constree.of self
  end

  def constreep
    ::Constree.p self
  end
end
