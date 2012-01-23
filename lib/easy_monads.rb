require File.join(File.dirname(__FILE__), "easy_monads", "monadic")
require File.join(File.dirname(__FILE__), "easy_monads", "option")
require File.join(File.dirname(__FILE__), "easy_monads", "option_functions")

module EasyMonads

  def self.option_everywhere!
    Object.class_eval("include EasyMonads::Option")
  end

end