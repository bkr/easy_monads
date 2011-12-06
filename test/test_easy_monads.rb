require 'helper'

class TestEasyMonads < Test::Unit::TestCase
  # What the hell is a monad, you ask? Check out
  # http://www.codecommit.com/blog/ruby/monads-are-not-metaphors

  class TestMonadic < EasyMonads::Monadic
    def initialize(data)
      @data = data
    end
  end

  context "A monadic Object" do
    setup do
      @monad = TestMonadic.new("test")
    end

    should "be enumerable" do
      assert @monad.is_a? Enumerable
      assert defined? @monad.each
    end

    should "be comparable" do
      assert @monad.is_a? Comparable
      assert defined? @monad.<=>
    end

    should "expose its contained data" do
      assert_equal "test", @monad.data
    end

    should "have a fancy bind_unit method that does a bind and a unit in one" do
      assert_equal TestMonadic.new("TEST"), @monad.bind_unit { |value| value.upcase }
    end

    # For all this monad identity business, checkout out
    # http://moonbase.rydia.net/mental/writings/programming/monads-in-ruby/01identity
    should "be true for identify law one" do
      f = lambda { |value| TestMonadic.unit("#{value} foo") }
      assert_equal "test foo", @monad.bind { |value| f.call(value) }.data
      assert_equal f.call("test"), @monad.bind { |value| f.call(value) }
    end

    should "be true for identity law two" do
      assert_equal @monad, @monad.bind { |value| TestMonadic.unit(value) }
    end

    context "for identity law three" do
      setup do
        @f = lambda { |value| TestMonadic.unit(value * 2) }
        @g = lambda { |value| TestMonadic.unit("#{value} foo") }
      end

      execute do
        @monad.bind do |value_a|
          @f.call(value_a)
        end.bind do |value_b|
          @g.call(value_b)
        end
      end

      should "be true" do
        assert_equal "testtest foo", @execute_result.data
        test_result = @monad.bind do |value_a|
          @f.call(value_a).bind do |value_b|
            @g.call(value_b)
          end
        end
        assert_equal @execute_result, test_result
      end
    end
  end

  context "An Option" do

    should "raise an error if used directly" do
      assert_raises(RuntimeError) { EasyMonads::Option::Option.new("foo") }
    end

    context "that is a None" do
      setup do
        @none = EasyMonads::Option::NONE
      end

      should "not bind to anything" do
        assert_equal EasyMonads::Option::NONE, @none.bind { raise RuntimeError.new("Should not have entered block") }
      end

      should "not enumerate" do
        count = 0
        @none.each { count += 1 }
        assert_equal 0, count
      end

      should "return nil for .get" do
        assert_equal nil, @none.get
      end

      should "return true for .empty?" do
        assert_equal true, @none.empty?
      end

      should "return 0 for .size" do
        assert_equal 0, @none.size
      end

      should "return false always for .exists? and not call the predicate block" do
        assert_equal false, @none.exists? { raise RuntimeError.new("Should not enter the block") }
      end

      should "return the else for .get_or_else" do
        assert_equal "foo", @none.get_or_else("foo")
      end

      should "return the evaluated block for .get_or_else when passed a block" do
        assert_equal "foo", @none.get_or_else { "foo" }
      end

      should "return false for .defined?" do
        assert_equal false, @none.defined?
      end

      should "return nil for .or_nil" do
        assert_equal nil, @none.or_nil
      end

      should "execute the block for .or_else" do
        entered = "grouchy"
        @none.or_else { entered = "happy" }
        assert_equal "happy", entered
      end
    end

    context "that is a Some" do
      setup do
        @some = EasyMonads::Option::Some.new("hello")
      end

      should "bind to another Some" do
        assert_equal "hello world", @some.bind { |value| EasyMonads::Option::Some.new("#{value} world") }.data
      end

      should "enumerate" do
        count = 0
        @some.each { count += 1 }
        assert_equal 1, count
      end

      should "return its data for .get" do
        assert_equal "hello", @some.get
      end

      should "return false for .empty?" do
        assert_equal false, @some.empty?
      end

      should "return 1 for its size" do
        assert_equal 1, @some.size
        another_some = EasyMonads::Option::Some.new(["hello", "world"])
        assert_equal 1, another_some.size
      end

      should "return true when a predicate is true for .exists?" do
        assert_equal true, @some.exists? { |value| value == "hello" }
      end

      should "return false when a predicate is false for .exists?" do
        assert_equal false, @some.exists? { |value| value == "fooie" }
      end

      should "return its data for .get_or_else" do
        assert_equal "hello", @some.get_or_else("goodbye")
      end

      should "return its data and ignore the block for .get_or_else when passed a block" do
        assert_equal "hello", @some.get_or_else { raise RuntimeError.new("Should not enter the block") }
      end

      should "return true for .defined?" do
        assert_equal true, @some.defined?
      end

      should "return its data for .or_nil" do
        assert_equal "hello", @some.or_nil
      end

      should "not enter the block for .or_else" do
        assert_nothing_raised { @some.or_else { raise RuntimeError.new("Should not enter the block") } }
      end

      should "return self for .or_else" do
        assert_equal @some, @some.or_else {}
      end
    end
  end
end