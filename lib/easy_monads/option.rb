
module EasyMonads
  module Option
    class Option < EasyMonads::Monadic
      def initialize(*args)
        raise RuntimeError.new("Attempt to initialize abstract #{self.class.name} class")
      end

      alias get data
      alias or_nil data
    end

    class None < Option
      def initialize(*args)
        @data = nil
      end

      def bind
        self
      end

      def each
      end

      def ==(other_monad)
        other_monad.is_a? self.class
      end

      def <=>(other_monad)
        if self == other_monad
          0
        else
          raise RuntimeError.new("#{self.class.name} is not comparable to other types") # nil <=> ... would raise NoMethodError
        end
      end

      def size
        0
      end

      def exists?(&pred)
        false
      end

      def defined?
        false
      end

      def get_or_else(else_val=nil)
        if block_given?
          yield
        else
          else_val
        end
      end

      def empty?
        true
      end

      def or_else
        yield
      end
    end

    NONE = None.new.freeze

    class Some < Option
      def initialize(data)
        @data = data
      end

      def size
        1
      end

      def exists?(&pred)
        pred.call(data) ? true : false
      end

      def defined?
        true
      end

      def get_or_else(ignored=nil)
        data
      end

      def empty?
        false
      end

      def or_else
        self
      end
    end
  end
end