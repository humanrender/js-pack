require "rubygems"
require "thor"
require "yaml"
require "json"
require "ruby-debug"
require 'pathname'
require "yui/compressor"

module JSPack
  
  class Loader 
    
    def initialize
      require_relative "../mixins/resource.rb"
      require_relative "../mixins/paths.rb"
      require_relative "config.rb"
      require_relative "logger.rb"
      require_relative "compiler.rb"
      require_relative "template.rb"
      require_relative "runner.rb"
      require_relative "task.rb"
      require_relative "git.rb"
      require_relative "resource_mapper.rb"
      require_relative "package.rb"
    end
    
  end
  
  module RequireRelative
    def require_relative(path)
      require File.join(File.dirname(caller[0]), path.to_str)
    end
  end
end