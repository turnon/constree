require 'minitest'

class ConstreeTest < Minitest::Test

  module A
    class B;end
    class C
      G = A
      module D
        H = C
      end
      F = :f
    end
    E = :e
  end

end
