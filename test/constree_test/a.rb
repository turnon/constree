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
    E = 1.2

    class J
      class K;end
      module L;end
      module M;end

      class N < K
        prepend L
        include M
      end
    end
  end

end
