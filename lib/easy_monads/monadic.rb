module EasyMonads
  class Monadic
    include Enumerable
    include Comparable

    class << self
      def unit(*args)
        new(*args)
      end
    end

    def unit(to_wrap)
      self.class.unit(to_wrap)
    end

    def bind(&func)
      result = func.call(data) if defined? @data
      raise RuntimeError.new("Result of .bind must be a Monadic but was #{result.class.name}") unless result.is_a? Monadic
      result
    end

    def bind_unit(&func)
      self.bind { |*args| self.unit(func.call(*args)) }
    end

    def data
      @data
    end

    def each
      yield data
    end

    def ==(other_monad)
      return false unless other_monad.is_a? EasyMonads::Monadic
      data == other_monad.data
    end

    def <=>(other_monad)
      return RuntimeError.new("Can only compare with other Monadic objects") unless other_monad.is_a? EasyMonads::Monadic
      data <=> other_monad.data
    end
  end
end