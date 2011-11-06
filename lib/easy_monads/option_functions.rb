
module EasyMonads
  module Option
    module OptionFunctions
      def self.sum_option_in_hash(hash, key, option)
        if hash[key].is_a? Some
          hash[key] = hash[key].bind { |value| Some.unit(value + option.get) }
        else
          hash[key] = option
        end
        hash
      end
    end
  end
end