module ZipitJS
  
  class Loader 
    
    def initialize
      require_relative "../mixins/resource.rb"
      require_relative "erb_template.rb"
      require_relative "runner.rb"
    end
    
  end
  
  module RequireRelative
    def require_relative(path)
      require File.join(File.dirname(caller[0]), path.to_str)
    end
  end
end