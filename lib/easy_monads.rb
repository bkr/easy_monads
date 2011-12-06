require File.join(File.dirname(__FILE__), "easy_monads", "monadic")

module EasyMonads

  def self.option_everywhere!
    require File.join(File.dirname(__FILE__), "easy_monads", "option")
    require File.join(File.dirname(__FILE__), "easy_monads", "option_functions")
    Object.class_eval("include EasyMonads::Option")
  end

end